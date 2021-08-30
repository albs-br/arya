

byte RandomIndex() {
  byte random;
  do {
     random = GetRandom() & 0b00000111; // AND mask to get a value in the 0-7 range
  }
  while(random > 4); // Get a number between 0 and 4
  
  return random;
}

void RandomPiece() {
  topPiece = nextTopPiece;
  midPiece = nextMidPiece;
  bottomPiece = nextBottomPiece;

  nextTopPiece = pieces[RandomIndex()];
  nextMidPiece = pieces[RandomIndex()];
  nextBottomPiece = pieces[RandomIndex()];
}

void UpdateAndDrawPieceStatic() {
  
  // Update and draw piece static
  playfield[col][line] = topPiece;
  playfield[col][line + 1] = midPiece;
  playfield[col][line + 2] = bottomPiece;
  DrawPiece(line);

  // Set piece to next
  col = INITIAL_COL;
  line = INITIAL_LINE;
  
  counter = 0;

  // Check if initial place of piece is occupied
  if(playfield[col][line] != EMPTY ||
     playfield[col][line + 1] != EMPTY ||
     playfield[col][line + 2] != EMPTY) {
    gameOver = TRUE;
  }  
  else {
    RandomPiece();

    CheckPlayfield(1);

    DrawNextPiece();
  }

  DrawPlayfield();
}

void BlinkPauseText() {
  if(JIFFY & 0b00001000) {
    DrawString("PAUSE", 13, 12);
  }
  else {
    //if(JIFFY & 0b11110000) {
      // Clear PAUSE text
      DrawLine(6);
    //}
  }
}

void Pause() {
  byte keyboard;
  
  DrawString("PAUSE", 13, 12);
  
  while(TRUE) {
    
    BlinkPauseText();
    
    // Check if ESC key is released
    keyboard = SNSMAT(7);
    if((keyboard & 0b00000100) != 0) {

      while(TRUE) {
        
    	BlinkPauseText();
        
        // Check if ESC key is pressed again
        keyboard = SNSMAT(7);
        if((keyboard & 0b00000100) == 0) {
          
          while(TRUE) {

    	    BlinkPauseText();

            // Check if ESC key is released again
            keyboard = SNSMAT(7);
            if((keyboard & 0b00000100) != 0) {
              // Clear PAUSE text
              DrawLine(6);
              return;
            }
          }

        }
      }

    }
  }
    
}

void GameLoop() {
  
  byte keyboard, joystick, btn1, btn2;
  byte lastJoystick_LeftRight = STCK_none, lastJoystick_UpDown = STCK_none;
  byte lastBtn1 = 0, lastBtn2 = 0;
  byte bgCounter = 0, bgColor= 0x00;

  while(!gameOver) {

    word lastJiffy = JIFFY;
    //d_value = 0;
    while (lastJiffy == JIFFY) {
      //d_value++;
    }
    // Game loop sync'ed at 60/50 Hz starts here
    
    
    
    
    // Clear piece before update position
    playfield[col][line] = EMPTY;
    playfield[col][line + 1] = EMPTY;
    playfield[col][line + 2] = EMPTY;

    // Read player input
    joystick = GTSTCK(STCK_Joy1);
    btn1 = GTTRIG(TRIG_Joy1_A);
    btn2 = GTTRIG(TRIG_Joy1_B);
    
    if(joystick == STCK_none) {
      joystick = GTSTCK(STCK_Cursors);
    }
    
    if(lastJoystick_LeftRight == STCK_none) {
    //if(lastJoystick_LeftRight != STCK_W && lastJoystick_LeftRight != STCK_E) {

      if (joystick == STCK_W && 
          col > 0 && 
          playfield[col - 1][line] == EMPTY && 
          playfield[col - 1][line + 2] == EMPTY) {
        col--;
      }
      else if (joystick == STCK_E && 
          col < COLS_PLAYFIELD - 1 &&
          playfield[col + 1][line] == EMPTY &&
          playfield[col + 1][line + 2] == EMPTY) {
        col++;
      }
    }
    
    if(lastJoystick_UpDown == STCK_none) {
    //if(lastJoystick_UpDown != STCK_W && lastJoystick_UpDown != STCK_E) {

      // Rotate piece
      if (joystick == STCK_N || (lastBtn1 == 0 && btn1 == 0xff) || (lastBtn2 == 0 && btn2 == 0xff)) {
        byte temp = bottomPiece;
        
        bottomPiece = midPiece;
        midPiece = topPiece;
        topPiece = temp;
      }
      
      // Fall piece until hit bottom or other piece
      if (joystick == STCK_S) {
        for(byte i = line; i < LINES_PLAYFIELD; i++) {
          if(i == LINES_PLAYFIELD - 3 || playfield[col][i + 3] != EMPTY) {
      	    
            // Clear current piece lines
            DrawPiece(line);
            
            line = i;
            
            UpdateAndDrawPieceStatic();
            break;
          }
        }
      }

    }

    //if(joystick == STCK_W || joystick == STCK_E) lastJoystick_LeftRight = joystick; else lastJoystick_LeftRight = STCK_none;
    //if(joystick == STCK_N || joystick == STCK_S) lastJoystick_UpDown = joystick; else lastJoystick_UpDown = STCK_none;
    lastJoystick_LeftRight = joystick;
    lastJoystick_UpDown = joystick;
    lastBtn1 = btn1;
    lastBtn2 = btn2;

    // Read keyboard
    // http://map.grauw.nl/articles/keymatrix.php
    /*
            bit 7	bit 6	bit 5	bit 4	bit 3	bit 2	bit 1	bit 0
    row 0	7 &	6 ^	5 %	4 $	3 #	2 @	1 !	0 )
    row 1	; :	] }	[ {	\ ¦	= +	- _	9 (	8 *
    row 2	B	A	DEAD	/ ?	. >	, <	` ~	' "
    row 3	J	I	H	G	F	E	D	C
    row 4	R	Q	P	O	N	M	L	K
    row 5	Z	Y	X	W	V	U	T	S
    row 6	F3	F2	F1	CODE	CAPS	GRAPH	CTRL	SHIFT
    row 7	RET	SELECT	BS	STOP	TAB	ESC	F5	F4
    row 8	→	↓	↑	←	DEL	INS	HOME	SPACE
    row 9	NUM4	NUM3	NUM2	NUM1	NUM0	NUM/	NUM+	NUM*
    row 10	NUM.	NUM,	NUM-	NUM9	NUM8	NUM7	NUM6	NUM5    

    SNSMAT
    Function : Returns the value of the specified line from the keyboard matrix
    Input    : A  - For the specified line
    Output   : A  - For data (the bit corresponding to the pressed key will be 0)
    Registers: AF
    */
    keyboard = SNSMAT(7);
    // Check if ESC key is pressed
    if((keyboard & 0b00000100) == 0) {
      Pause();
    }
    
    
    // Piece falling logic
    counter++;
    if(counter == speed) {
      
      counter = 0;

      // Draw piece before update position
      DrawPiece(line);
      
      
      // Check if piece hit bottom or other piece
      if(line == LINES_PLAYFIELD - 3 || playfield[col][line + 3] != EMPTY) {

        UpdateAndDrawPieceStatic();
      }
      
      line++;
      
    }

    

    //Set piece at updated position
    playfield[col][line] = topPiece;
    playfield[col][line + 1] = midPiece;
    playfield[col][line + 2] = bottomPiece;

    
    
    // Draw piece at current position
    DrawPiece(line);
    
    
    
    // Draw arrow sprite indicating where the piece will drop
    if(playfield[col][line + 3] != EMPTY) {
      HideArrowSprite();
    }
    else {
      for(byte i = line + 3; i < LINES_PLAYFIELD; i++) {
        if(i == LINES_PLAYFIELD - 1 && playfield[col][i] == EMPTY) {
          DrawArrowSprite((col * 16) + (PLAYFIELD_HORIZ_OFFSET * 8), (i) * 16);
          break;
        } 
        else if(playfield[col][i] != EMPTY) {
          DrawArrowSprite((col * 16) + (PLAYFIELD_HORIZ_OFFSET * 8), (i - 1) * 16);
          break;
        }
      }
    }
    
  }
  
  DrawString("GAME OVER", 12, 12);
  
  //while(1) { };
  
  // Wait 5 seconds
  Wait(60 * 5);
  
}

void TestCase() {
  // playfield[2][ 8] = TILE_GREEN;
  // playfield[2][ 9] = TILE_BLUE;

  // playfield[0][10] = TILE_BLUE;
  // playfield[1][10] = TILE_BLUE;
  // playfield[2][10] = TILE_RED;
  // playfield[4][10] = TILE_RED;
  // playfield[5][10] = TILE_BLUE;

  // playfield[0][11] = TILE_GREEN;
  // playfield[1][11] = TILE_GREEN;
  // playfield[2][11] = TILE_RED;
  // playfield[3][11] = TILE_BLUE;
  // playfield[4][11] = TILE_RED;
  // playfield[5][11] = TILE_RED;
  
  // topPiece = TILE_BLUE;
  // midPiece = TILE_RED;
  // bottomPiece = TILE_YELLOW;

  playfield[2][ 8] = TILE_GREEN;
  playfield[2][ 9] = TILE_BLUE;

  playfield[0][10] = TILE_BLUE;
  playfield[1][10] = TILE_BLUE;
  playfield[2][10] = TILE_RED;
  playfield[4][10] = TILE_RED;
  playfield[5][10] = TILE_BLUE;

  playfield[0][11] = TILE_GREEN;
  playfield[1][11] = TILE_GREEN;
  playfield[2][11] = TILE_RED;
  playfield[3][11] = EMPTY;
  playfield[4][11] = TILE_RED;
  playfield[5][11] = TILE_RED;
  
  topPiece = TILE_BLUE;
  midPiece = TILE_RED;
  bottomPiece = TILE_RED;
}

void InitGame() {
  
  gameOver = FALSE;
  line = INITIAL_LINE;
  col = INITIAL_COL;
  //score = 0;
  blocksRemoved = 0;
  level = 1;
  newLevel = FALSE;
  speed = 60;
  
  InitVRAM();
  
  // Using user input on title screen to seed random number generator
  InitRnd(rndSeed, JIFFY * rndSeed, JIFFY * rndSeed + 99);

  // Call RandomPiece twice, to populate current and next pieces
  RandomPiece();
  RandomPiece();
  
  // Reset playfield
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 0; col < COLS_PLAYFIELD; col++) {
      playfield[col][line] = EMPTY;
    }
  }
  
  // Testing code
  TestCase();

  //newLevel = TRUE;  //test
  
  DrawBackground();
  
  DrawPlayfield();
  
  DrawScore();

  DrawNextPiece();
  
  GameLoop();
}
