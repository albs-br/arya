
#include <ctype.h>
#include <stdio.h>
#include <string.h>
//#include <math.h>

#include "msxbios.h"
//#link "msxbios.c"

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


#include "Common.h"

#include "Math.h"

#include "Random.h"

#include "Fonts.h"
#include "TilePatterns.h"
#include "TileColors.h"
#include "Graphics.h"


#include "Sound.h"


#include "GameLogic.h"

#include "Title.h"




void main() {
  
  while(TRUE) {
    InitVRAM();

    TitleScreen();

    InitVRAM();

    InitGame();
    
    //while(1) {}
  }
}
