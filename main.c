
#include <ctype.h>
#include <stdio.h>
#include <string.h>

#include "msxbios.h"
//#link "msxbios.c"

#include "TilePatterns.h"
#include "TileColors.h"


typedef uint8_t 	byte;
typedef uint16_t 	word;
typedef uint8_t 	bool;

#define TRUE 	1
#define FALSE 	0

int blackTile = 0;
int exampleTile = 5;
int exampleTile_green = 1;
int exampleTile_blue = 9;

#define SPEED			30 // 30 // 60

#define LINES_PLAYFIELD 	12
#define COLS_PLAYFIELD 		6
#define INITIAL_LINE		0
#define INITIAL_COL		2
byte playfield[COLS_PLAYFIELD][LINES_PLAYFIELD];

bool gameOver = FALSE;
byte col = 0, line = 0;
byte topPiece, midPiece, bottomPiece;

#define EMPTY	0


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
  LDIRVM(MSX_modedata_screen2.pattern, pattern_black, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading patterns (2nd bank)
  LDIRVM(MSX_modedata_screen2.pattern + (256 * 8), pattern_black, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading patterns (3rd bank)
  LDIRVM(MSX_modedata_screen2.pattern + (512 * 8), pattern_black, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  

  
  // Write to colors table
  //for(int i = 0; i < 8; i++) {
  //	WRTVRM(MSX_modedata_screen2.color + (exampleChar * 8) + i, 0x8a);
  //}
  
  // Loading colors (1st bank)
  LDIRVM(MSX_modedata_screen2.color, color_black, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading colors (2nd bank)
  LDIRVM(MSX_modedata_screen2.color + (256 * 8), color_black, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  // Loading colors (3rd bank)
  LDIRVM(MSX_modedata_screen2.color + (512 * 8), color_black, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  
  
  // Write to names table
  for(int i = 0; i < 256 * 3; i++) {
  	WRTVRM(MSX_modedata_screen2.name + i, blackTile);
  }
  
  ENASCR();	// Enable screen
}

void DrawBlock(byte col, byte line, byte tile) {
  word baseAddr = MSX_modedata_screen2.name + (col * 2) + (line * 2 * 32);
  
  if (tile == EMPTY) {
    WRTVRM(baseAddr, tile);
    WRTVRM(baseAddr + 1, tile);
    WRTVRM(baseAddr + 32, tile);
    WRTVRM(baseAddr + 33, tile);
    
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

void CheckPlayfield() {
  // Check lines
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 2; col < COLS_PLAYFIELD; col++) {
      if (playfield[col - 2][line] == playfield[col - 1][line] && 
          playfield[col - 1][line] == playfield[col][line]) {
        playfield[col - 2][line] = EMPTY;
        playfield[col - 1][line] = EMPTY;
        playfield[col][line] = EMPTY;
      }
    }
  }
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
        
        if(line == 0) {
          gameOver = TRUE;
        }
        
    	// Update and draw piece static
        playfield[col][line] = topPiece;
        playfield[col][line + 1] = midPiece;
        playfield[col][line + 2] = bottomPiece;
      	DrawPiece(line);

        // Set piece to next
        col = INITIAL_COL;
        line = INITIAL_LINE;
        
    	CheckPlayfield();
        
        DrawPlayfield();
      }
      else {
      	line++;
      }
    }
    
    //Set piece at updated position
    playfield[col][line] = topPiece;
    playfield[col][line + 1] = midPiece;
    playfield[col][line + 2] = bottomPiece;
    
    // Draw piece at current position
    DrawPiece(line);
  }
  
  //InitGame();
}

void InitGame() {
  
  gameOver = FALSE;
  line = INITIAL_LINE;
  col = INITIAL_COL;
  
  topPiece = exampleTile_green;
  midPiece = exampleTile;
  bottomPiece = exampleTile_blue;
  
  // Reset playfield
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 0; col < COLS_PLAYFIELD; col++) {
      playfield[col][line] = EMPTY;
    }
  }
  
  GameLoop();
}

void main() {
  int counter=0;
  
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
