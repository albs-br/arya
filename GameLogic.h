
void CheckIfPlayfieldIsValid() {
  bool found = FALSE;
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 0; col < COLS_PLAYFIELD; col++) {
      for(byte item = 0; item < 5; item++) {
        found = FALSE;
      	if(playfieldTemp[col][line] == pieces[item] || playfieldTemp[col][line] == EMPTY) {
          found = TRUE;
          break;
        }
      }
      if(!found) {
        d_col = col;
        d_line = line;
        d_value = playfieldTemp[col][line];
        
        while(1) { 
          BEEP();
        }
      }
      
    }
  }
}

void CheckPlayfield() {
  bool piecesRemoved = FALSE;
  
  // Save copy of playfield
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 0; col < COLS_PLAYFIELD; col++) {
      	playfieldTemp[col][line] = playfield[col][line];
    }
  }
  
  // Check lines
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 2; col < COLS_PLAYFIELD; col++) {
      if (playfieldTemp[col][line] != EMPTY &&
          playfieldTemp[col - 2][line] == playfieldTemp[col - 1][line] && 
          playfieldTemp[col - 1][line] == playfieldTemp[col][line]) {
        
        piecesRemoved = TRUE;
        
        // Set cells to removing status
        playfield[col - 2][line] = playfieldTemp[col - 2][line] | REMOVING_FLAG;
        playfield[col - 1][line] = playfieldTemp[col - 1][line] | REMOVING_FLAG;
        playfield[col][line] = 	   playfieldTemp[col][line] | REMOVING_FLAG;
      }
    }
  }

  // Check columns
  for(byte line = 2; line < LINES_PLAYFIELD; line++) {
    for(byte col = 0; col < COLS_PLAYFIELD; col++) {
      if (playfieldTemp[col][line] != EMPTY &&
          playfieldTemp[col][line - 2] == playfieldTemp[col][line - 1] && 
          playfieldTemp[col][line - 1] == playfieldTemp[col][line]) {
        
        piecesRemoved = TRUE;
        
        // Set cells to removing status
        playfield[col][line - 2] = playfieldTemp[col][line - 2] | REMOVING_FLAG;
        playfield[col][line - 1] = playfieldTemp[col][line - 1] | REMOVING_FLAG;
        playfield[col][line] = 	   playfieldTemp[col][line] | REMOVING_FLAG;
      }
    }
  }

  // Check diagonals
  for(byte line = 2; line < LINES_PLAYFIELD; line++) {
    for(byte col = 2; col < COLS_PLAYFIELD; col++) {
      if (playfieldTemp[col][line] != EMPTY &&
          playfieldTemp[col - 2][line - 2] == playfieldTemp[col - 1][line - 1] && 
          playfieldTemp[col - 1][line - 1] == playfieldTemp[col][line]) {
        
        piecesRemoved = TRUE;
        
        // Set cells to removing status
        playfield[col - 2][line - 2] = playfieldTemp[col - 2][line - 2] | REMOVING_FLAG;
        playfield[col - 1][line - 1] = playfieldTemp[col - 1][line - 1] | REMOVING_FLAG;
        playfield[col][line] = 	       playfieldTemp[col][line] | REMOVING_FLAG;
      }
      if (playfieldTemp[col][line - 2] != EMPTY &&
          playfieldTemp[col - 1][line - 1] == playfieldTemp[col - 2][line] && 
          playfieldTemp[col - 2][line] == playfieldTemp[col][line - 2]) {
        
        piecesRemoved = TRUE;
        
        // Set cells to removing status
        playfield[col][line - 2] =     playfieldTemp[col][line - 2] | REMOVING_FLAG;
        playfield[col - 1][line - 1] = playfieldTemp[col - 1][line - 1] | REMOVING_FLAG;
        playfield[col - 2][line] = 	       playfieldTemp[col - 2][line] | REMOVING_FLAG;
      }
    }
  }

  if(piecesRemoved) {
    
    // Animation
    byte counter = 60;
    
    Sound();
    
    while(counter-- > 0) {
      word lastJiffy = JIFFY;
      while (lastJiffy == JIFFY) {
      }
      // Animation loop sync'ed at 60/50 Hz starts here

      for(byte line = 0; line < LINES_PLAYFIELD; line++) {
        for(byte col = 0; col < COLS_PLAYFIELD; col++) {

          if((playfield[col][line] & REMOVING_FLAG) != 0) {
    		
            if(JIFFY & 0b00000011) {
              DrawBlock(col, line, playfield[col][line] & 0b01111111);
            }
            else {
              DrawBlock(col, line, EMPTY);
            }

          }
        }
      }
    }
    
    
    // After animation
    for(byte line = 0; line < LINES_PLAYFIELD; line++) {
      for(byte col = 0; col < COLS_PLAYFIELD; col++) {

        if((playfield[col][line] & REMOVING_FLAG) != 0) {
          
          blocksRemoved++;

          // Adjust the column above
          for(byte line1 = line; line1 > 0; line1--) {
            byte linesToBeRemoved = 1;
            if((playfield[col][line1 - 1] & REMOVING_FLAG) != 0) linesToBeRemoved++;
            if((playfield[col][line1 - 2] & REMOVING_FLAG) != 0) linesToBeRemoved++;
            
            //playfield[col][line1] = playfieldTemp[col][line1 - linesToBeRemoved];
            //playfield[col][line1] = playfield[col][(line1 - linesToBeRemoved >= 0) ? line1 - linesToBeRemoved : 0];
            playfield[col][line1] = (line1 - linesToBeRemoved >= 0) ? playfield[col][line1 - linesToBeRemoved] : EMPTY;
          }
        }
      }
    }

    
    DrawPlayfield();
    
    //Wait(90);
    
    CheckIfPlayfieldIsValid(); // test
    
    DrawScore();

    CheckPlayfield();
    
  }
}

byte RandomIndex() {
  byte random;
  do {
     random = GetRandom() & 0b00000111; // AND mask to get a value in the 0-7 range
  }
  while(random > 4); // Get a number between 0 and 4
  
  return random;
}

byte RandomPiece() {
  topPiece = pieces[RandomIndex()];
  midPiece = pieces[RandomIndex()];
  bottomPiece = pieces[RandomIndex()];
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

  // Check if initial place of piece is occupied
  if(playfield[col][line] != EMPTY ||
     playfield[col][line + 1] != EMPTY ||
     playfield[col][line + 2] != EMPTY) {
    gameOver = TRUE;
  }  
  else {
    RandomPiece();

    CheckPlayfield();
  }

  DrawPlayfield();
}

void GameLoop() {
  
  byte joystick, lastJoystick = STCK_none;
  byte counter = 0;
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
    joystick = GTSTCK(STCK_Cursors);
    //joystick = GTSTCK(STCK_Joy1);
    if(lastJoystick == STCK_none) {

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
      
      // Rotate piece
      if (joystick == STCK_N) {
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

    lastJoystick = joystick;

    // Piece falling logic
    counter++;
    if(counter == SPEED) {
      
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
    
    
    // Animate Bg
    //void FILVRM(uint16_t start, uint16_t len, uint8_t data);
    //if(JIFFY & 0b0000001100000000 == 0) {
    /*
    if(JIFFY % 8 == 0) {
      switch(bgCounter++) {
        case 0:
          bgColor = 0x14;
          break;
        case 1:
          bgColor = 0x14;
          break;
        case 2:
          bgColor = 0x15;
          break;
        case 3:
          bgColor = 0x14;
          break;
        case 4:
          bgColor = 0x14;
          bgCounter = 0;
          break;
        default:
          bgColor = 0x11;

      }
      FILVRM(MSX_modedata_screen2.color, 8 * 4, bgColor);
    }
    */

  }
  
  DrawString("GAME OVER", 12, 12);
  
  //while(1) { };
  
  // Wait 3 seconds
  Wait(60 * 3);
  
}

void TestCase() {
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
  playfield[3][11] = TILE_BLUE;
  playfield[4][11] = TILE_RED;
  playfield[5][11] = TILE_RED;
  
  topPiece = TILE_BLUE;
  midPiece = TILE_RED;
  bottomPiece = TILE_YELLOW;
}

void InitGame() {
  
  // TODO: use user input to seed random number generator
  InitRnd(JIFFY, JIFFY * 2, JIFFY * 3);
  
  gameOver = FALSE;
  line = INITIAL_LINE;
  col = INITIAL_COL;
  blocksRemoved = 0;
  
  RandomPiece();
  
  // Reset playfield
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 0; col < COLS_PLAYFIELD; col++) {
      playfield[col][line] = EMPTY;
    }
  }
  
  // Testing code
  //TestCase();

  DrawPlayfield();
  
  DrawScore();
  
  GameLoop();
}
