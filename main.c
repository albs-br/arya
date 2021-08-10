
#include <ctype.h>
#include <stdio.h>
#include <string.h>
//#include <math.h>

#include "msxbios.h"
//#link "msxbios.c"

#include "random.h"

#include "TilePatterns.h"
#include "TileColors.h"

#include "fonts.h"


typedef uint8_t 	byte;
typedef uint16_t 	word;
typedef uint8_t 	bool;

#define TRUE 	1
#define FALSE 	0

#define EMPTY		0
#define TILE_GREEN	4
#define TILE_RED	8
#define TILE_BLUE	12
#define TILE_PURPLE	16
#define TILE_YELLOW	20

#define REMOVING_FLAG	0b10000000

const byte pieces[5] = { 
  TILE_GREEN, 
  TILE_RED, 
  TILE_BLUE, 
  TILE_PURPLE, 
  TILE_YELLOW 
};


#define SPEED			60 // 15 // 30 // 60

#define LINES_PLAYFIELD 	12
#define COLS_PLAYFIELD 		6
#define INITIAL_LINE		0
#define INITIAL_COL		2
byte playfield[COLS_PLAYFIELD][LINES_PLAYFIELD];
byte playfieldTemp[COLS_PLAYFIELD][LINES_PLAYFIELD];

bool gameOver = FALSE;
byte col = 0, line = 0;
byte topPiece, midPiece, bottomPiece;
word blocksRemoved = 0;

// Debug variables
byte d_col = 0, d_line = 0, d_value = 0;



void DrawChar(byte character, byte col, byte line) {
  WRTVRM(MSX_modedata_screen2.name + (line * 32) + col, character);
}

void DrawString(const char* str, byte col, byte line) {
  while (*str) {
    //DrawChar((*str++) - (65 - CHAR_A), col++, line);
    DrawChar((*str++) - (65 - (CHAR_A)), col++, line);
  }
}

word Power(byte base, byte expoent) {
  word power = base;

  if (expoent == 0) return 1;

  for(byte j = 1; j < expoent; j++) {
    power = power * base;
  }
  
  return power;
}

void DrawNumber(word number, byte col, byte line) {

  word power;
  bool trailingZero = TRUE;
  for(byte i = 6; i > 0; i--) {
    
    power = Power(10, i - 1);

    if(trailingZero && (number / power) != 0) trailingZero = FALSE;
    
    if(!trailingZero || i == 1) {
      DrawChar((number / power) + CHAR_0, col, line);
      number = number % power;
    }
    
    col++;
  }
  
  // test
  d_value = Power(10, 2);
}

void DrawBackground() {
  // Write to names table
  for(int i = 0; i < 256 * 3; i++) {
    WRTVRM(MSX_modedata_screen2.name + i, 0); // test
  }
  
  // test font
  for(byte i=0; i<10; i++) {
    WRTVRM(MSX_modedata_screen2.name + i, CHAR_0 + i);
  }
  for(byte i=0; i<10; i++) {
    WRTVRM(MSX_modedata_screen2.name + 32 + i, CHAR_A + i);
  }
  for(byte i=0; i<10; i++) {
    WRTVRM(MSX_modedata_screen2.name + 64 + i, CHAR_A + 10 + i);
  }
  for(byte i=0; i<10; i++) {
    WRTVRM(MSX_modedata_screen2.name + 96 + i, CHAR_A + 20 + i);
  }
  
  DrawChar(CHAR_A, 30, 5);
  DrawChar(CHAR_A, 0, 10);
  DrawChar(CHAR_A, 0, 20);
  
  DrawString("ABC", 0, 6);
  DrawString(".,()", 0, 11);
  DrawNumber(1, 0, 12);
  DrawNumber(12, 0, 13);
  DrawNumber(123, 0, 14);
  DrawString("ABCabc123", 0, 23);
  
  for(byte i=0; i < 24; i++) {
    //DrawNumber(i * 10 + 1, 25, i);
  }
}

void Sound() {
  GICINI();
  
  //__asm__("HALT");

  
  /*
  WRTPSG
  Address  : #0093
  Function : Writes data to PSG register
  Input    : A  - PSG register number
             E  - Data write  
  */
  
  
  //uint16_t WRTPSG(uint16_t reg_data) __z88dk_fastcall;
  WRTPSG(0x0f08);
  
  for(byte i=0; i<255; i++) {
    WRTPSG((93 * 256) + 0);
    WRTPSG((0 * 256) + 1);
  }

  for(byte i=0; i<255; i++) {
    WRTPSG((45 * 256) + 0);
    WRTPSG((0 * 256) + 1);
  }

  WRTPSG((0 * 256) + 8);	// register 8, value 0
}

void Sound_Shot() {
  
  //BEEP();
  
  GICINI();

  WRTPSG((151 * 256) + 6);
  WRTPSG((0b10000001 * 256) + 7);
  WRTPSG((16 * 256) + 8);
  WRTPSG((19 * 256) + 12);
  WRTPSG((1 * 256) + 13);
}

/*
void Sound() {
  GICINI();
  
  __asm__("ld a, 8");
  __asm__("ld e, 15");
  __asm__("call 0x0093");
}
*/

void InitVRAM() {
 
  CLIKSW = 0;	// disable keyboard sound
  SCNCNT = 1; 	// set keyboard scan counter
  
  FORCLR = COLOR_WHITE;
  BAKCLR = COLOR_BLACK;
  BDRCLR = COLOR_BLACK;
  
  INIGRP();	// Set screen 2
 
  DISSCR();	// Disable screen (faster to write)
  
  
  // Clear all VRAM (16Kb)
  FILVRM(0x0000, 0x4000, 0x00); //void FILVRM(uint16_t start, uint16_t len, uint8_t data);

  
  
  // Write to patterns table
  //for(int i = 0; i < 8; i++) {
  //	WRTVRM(MSX_modedata_screen2.pattern + (exampleChar * 8) + i, 0b10110011);
  //}
  
  // Loading patterns (1st bank)
  LDIRVM(MSX_modedata_screen2.pattern, pattern_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading patterns (2nd bank)
  LDIRVM(MSX_modedata_screen2.pattern + (256 * 8), pattern_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading patterns (3rd bank)
  LDIRVM(MSX_modedata_screen2.pattern + (512 * 8), pattern_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  // Loading font patterns (1st bank)
  LDIRVM(MSX_modedata_screen2.pattern + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  // Loading font patterns (2nd bank)
  LDIRVM(MSX_modedata_screen2.pattern + (256 * 8) + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  // Loading font patterns (3rd bank)
  LDIRVM(MSX_modedata_screen2.pattern + (512 * 8) + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  
  
  // Write to colors table
  //for(int i = 0; i < 8; i++) {
  //	WRTVRM(MSX_modedata_screen2.color + (exampleChar * 8) + i, 0x8a);
  //}
  
  // Loading colors (1st bank)
  LDIRVM(MSX_modedata_screen2.color, color_black_0, NUMBER_OF_PATTERNS * 8);

  // Loading colors (2nd bank)
  LDIRVM(MSX_modedata_screen2.color + (256 * 8), color_black_0, NUMBER_OF_PATTERNS * 8);
  
  // Loading colors (3rd bank)
  LDIRVM(MSX_modedata_screen2.color + (512 * 8), color_black_0, NUMBER_OF_PATTERNS * 8);
  
  // Loading font colors
  // Single color
  //FILVRM(MSX_modedata_screen2.color + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, 0xf0);
  // Gradient pattern (1st bank)
  for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
    LDIRVM(MSX_modedata_screen2.color + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font, 8);
  }
  
  // Gradient pattern (2nd bank)
  for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
    LDIRVM(MSX_modedata_screen2.color + (256 * 8) + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font, 8);
  }
  
  // Gradient pattern (3rd bank)
  for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
    LDIRVM(MSX_modedata_screen2.color + (512 * 8) + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font, 8);
  }
  
  
  DrawBackground();
  
  
  
  ENASCR();	// Enable screen
}

void DrawBlock(byte col, byte line, byte tile) {
  const byte horizOffset = 10;	// playfield offset from screen left border
  word baseAddr = MSX_modedata_screen2.name + (col * 2) + (line * 2 * 32) + horizOffset;
  
  /*
  if (tile == EMPTY) {
    WRTVRM(baseAddr, EMPTY);
    WRTVRM(baseAddr + 1, EMPTY + 1);
    WRTVRM(baseAddr + 32, EMPTY + 2);
    WRTVRM(baseAddr + 33, EMPTY + 3);
    
    return;
  }
  */
  
  //WRTVRM(baseAddr - 2, blackTile);
  //WRTVRM(baseAddr - 1, blackTile);
  WRTVRM(baseAddr, tile);
  WRTVRM(baseAddr + 1, tile + 1);
  WRTVRM(baseAddr + 32, tile + 2);
  WRTVRM(baseAddr + 33, tile + 3);
  //WRTVRM(baseAddr + 2, blackTile);
  //WRTVRM(baseAddr + 3, blackTile);
}

void DrawLine(byte line) {
  for(byte col = 0; col < COLS_PLAYFIELD; col++) {
    DrawBlock(col, line, playfield[col][line]);
  }
}

void DrawPiece(byte line) {
  DrawLine(line);
  DrawLine(line + 1);
  DrawLine(line + 2);
}

void DrawPlayfield() {
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    DrawLine(line);
  }
}

void DrawScore() {
  DrawNumber(blocksRemoved, 25, 10);
}

void Wait(word numberOfFrames) {
  do {
    word lastJiffy = JIFFY;
    while (lastJiffy == JIFFY) {
    }
  }
  while (numberOfFrames-- > 0);
}

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

void main() {

  InitVRAM();
 
  InitGame();
}
