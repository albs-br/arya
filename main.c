
#include <ctype.h>
#include <stdio.h>
#include <string.h>

#include "msxbios.h"
//#link "msxbios.c"

#include "random.h"


#include "TilePatterns.h"
#include "TileColors.h"


typedef uint8_t 	byte;
typedef uint16_t 	word;
typedef uint8_t 	bool;

#define TRUE 	1
#define FALSE 	0

#define EMPTY		0
#define REMOVING_FLAG	0b10000000
//#define REMOVING_STATUS	255
const byte blackTile = 0;
const byte exampleTile = 8;
const byte exampleTile_green = 4;
const byte exampleTile_blue = 12;
const byte exampleTile_purple = 16;
const byte exampleTile_yellow = 20;

// TODO: refactor here
const byte pieces[5] = { 4, 8, 12, 16, 20 };


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

byte d_col, d_line;




void DrawBackground() {
  // Write to names table
  for(int i = 0; i < 256 * 3; i++) {
  	WRTVRM(MSX_modedata_screen2.name + i, 0); // test
  }
}


void InitVRAM() {
 
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
  

  
  // Write to colors table
  //for(int i = 0; i < 8; i++) {
  //	WRTVRM(MSX_modedata_screen2.color + (exampleChar * 8) + i, 0x8a);
  //}
  
  // Loading colors (1st bank)
  LDIRVM(MSX_modedata_screen2.color, color_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading colors (2nd bank)
  LDIRVM(MSX_modedata_screen2.color + (256 * 8), color_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  // Loading colors (3rd bank)
  LDIRVM(MSX_modedata_screen2.color + (512 * 8), color_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  
  
  DrawBackground();
  
  
  
  ENASCR();	// Enable screen
}

void DrawBlock(byte col, byte line, byte tile) {
  const byte horizOffset = 10;	// playfield offset from screen left border
  word baseAddr = MSX_modedata_screen2.name + (col * 2) + (line * 2 * 32) + horizOffset;
  
  if (tile == EMPTY) {
    WRTVRM(baseAddr, EMPTY);
    WRTVRM(baseAddr + 1, EMPTY + 1);
    WRTVRM(baseAddr + 32, EMPTY + 2);
    WRTVRM(baseAddr + 33, EMPTY + 3);
    
    return;
  }
  
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

void Wait(word numberOfFrames) {
  do {
    word lastJiffy = JIFFY;
    while (lastJiffy == JIFFY) {
    }
  }
  while (numberOfFrames-- > 0);
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
        
        //playfield[col - 2][line] = REMOVING_STATUS;
        //playfield[col - 1][line] = REMOVING_STATUS;
        //playfield[col][line] = REMOVING_STATUS;
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
        
        //playfield[col][line - 2] = REMOVING_STATUS;
        //playfield[col][line - 1] = REMOVING_STATUS;
        //playfield[col][line] = REMOVING_STATUS;
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
        
        //playfield[col - 2][line - 2] = REMOVING_STATUS;
        //playfield[col - 1][line - 1] = REMOVING_STATUS;
        //playfield[col][line] = REMOVING_STATUS;
      }
      if (playfieldTemp[col][line - 2] != EMPTY &&
          playfieldTemp[col - 1][line - 1] == playfieldTemp[col - 2][line] && 
          playfieldTemp[col - 2][line] == playfieldTemp[col][line - 2]) {
        
        piecesRemoved = TRUE;
        
        // Set cells to removing status
        playfield[col][line - 2] =     playfieldTemp[col][line - 2] | REMOVING_FLAG;
        playfield[col - 1][line - 1] = playfieldTemp[col - 1][line - 1] | REMOVING_FLAG;
        playfield[col - 2][line] = 	       playfieldTemp[col - 2][line] | REMOVING_FLAG;
        
        //playfield[col][line - 2] = REMOVING_STATUS;
        //playfield[col - 1][line - 1] = REMOVING_STATUS;
        //playfield[col - 2][line] = REMOVING_STATUS;
      }
    }
  }

  if(piecesRemoved) {
    
    // Animation
    byte counter = 60;
    
    while(counter-- > 0) {
      word lastJiffy = JIFFY;
      while (lastJiffy == JIFFY) {
      }
      // Animation loop sync'ed at 60/50 Hz starts here

      for(byte line = 0; line < LINES_PLAYFIELD; line++) {
        for(byte col = 0; col < COLS_PLAYFIELD; col++) {

          if((playfield[col][line] & REMOVING_FLAG) != 0) {
          //if(playfield[col][line] == REMOVING_STATUS) {
    		
            d_col = col;
            d_line = line; //[debug]
            
            //while(1) {}
            
            if(JIFFY & 0b00000011) {
              DrawBlock(col, line, playfield[col][line] & 0b01111111);
              //DrawBlock(col, line, exampleTile_green);
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
        //if(playfield[col][line] == REMOVING_STATUS) {

          //playfieldTemp[col][line] = EMPTY;

          // Adjust the column above
          for(byte line1 = line; line1 > 0; line1--) {
            byte linesToBeRemoved = 1;
            if((playfield[col][line1 - 1] & REMOVING_FLAG) != 0) linesToBeRemoved++;
            if((playfield[col][line1 - 2] & REMOVING_FLAG) != 0) linesToBeRemoved++;
            //if(playfield[col][line1 - 1] == REMOVING_STATUS) linesToBeRemoved++;
            //if(playfield[col][line1 - 2] == REMOVING_STATUS) linesToBeRemoved++;
            
            //playfield[col][line1] = playfieldTemp[col][line1 - linesToBeRemoved];
            playfield[col][line1] = playfield[col][line1 - linesToBeRemoved];
          }
        }
      }
    }

    
    DrawPlayfield();
    
    //Wait(90);
    
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
  
  RandomPiece();

  CheckPlayfield();

  DrawPlayfield();
}

void GameLoop() {
  
  byte joystick, lastJoystick = STCK_none;
  byte counter = 0;

  while(!gameOver) {

    word lastJiffy = JIFFY;
    while (lastJiffy == JIFFY) {
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

  }
  
}

void TestCase() {
  playfield[2][ 8] = exampleTile_green;
  playfield[2][ 9] = exampleTile_blue;

  playfield[0][10] = exampleTile_blue;
  playfield[1][10] = exampleTile_blue;
  playfield[2][10] = exampleTile;
  playfield[4][10] = exampleTile;
  playfield[5][10] = exampleTile_blue;

  playfield[0][11] = exampleTile_green;
  playfield[1][11] = exampleTile_green;
  playfield[2][11] = exampleTile;
  playfield[3][11] = exampleTile_blue;
  playfield[4][11] = exampleTile;
  playfield[5][11] = exampleTile;
  
  topPiece = exampleTile_blue;
  midPiece = exampleTile;
  bottomPiece = exampleTile_yellow;
}

void InitGame() {
  
  InitRnd(JIFFY, JIFFY * 2, JIFFY * 3);
  
  gameOver = FALSE;
  line = INITIAL_LINE;
  col = INITIAL_COL;
  
  RandomPiece();
  
  // Reset playfield
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 0; col < COLS_PLAYFIELD; col++) {
      playfield[col][line] = EMPTY;
    }
  }
  
  // Testing code
  TestCase();

  DrawPlayfield();
  
  GameLoop();
}

void main() {

  int counter=0;
  
  //pieces[0] = exampleTile;
  //pieces[1] = exampleTile_green;
  //pieces[2] = exampleTile_blue;

  //INITXT();
  SCNCNT = 1; // set keyboard scan counter
  
  InitVRAM();
 
  
  /*
  while (1) {
    BEEP();
    //counter++;
    //printf("Hello, World!    %04x\n", counter);
    //printf("%04x\n", MSX_modedata_screen1.name);
  }
  */
  InitGame();
  
  //while (1) {}
}
