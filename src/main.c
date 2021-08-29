
#include <ctype.h>
#include <stdio.h>
#include <string.h>
//#include <math.h>

#include "msxbios.h"
//#link "msxbios.c"

typedef uint8_t 	byte;
typedef uint16_t 	word;
typedef uint8_t 	bool;

#define TRUE 	      1
#define FALSE 	    0

#define EMPTY		    0
#define TILE_GREEN	4
#define TILE_RED	  8
#define TILE_BLUE	  12
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


//#define SPEED			60 // 15 // 30 // 60

#define LINES_PLAYFIELD 	12
#define COLS_PLAYFIELD 		6
#define INITIAL_LINE		0
#define INITIAL_COL		2
byte playfield[COLS_PLAYFIELD][LINES_PLAYFIELD];
byte playfieldTemp[COLS_PLAYFIELD][LINES_PLAYFIELD];

bool gameOver = FALSE;
byte col = 0, line = 0;
byte counter = 0;
byte topPiece, midPiece, bottomPiece;
// word score = 0;
word blocksRemoved = 0;
byte level = 1;
bool newLevel = FALSE;
byte speed, rndSeed = 0;


// Debug variables
byte d_col = 0, d_line = 0, d_value = 0;


#include "Common.h"

#include "Math.h"

#include "Random.h"

#include "Data\Fonts.h"
#include "Data\TilePatterns.h"
#include "Data\TileColors.h"
#include "Data\Sprites.h"

#include "Graphics\GraphicsConstants.h"
#include "Graphics\SpritesLogic.h"
#include "Graphics\Graphics.h"

#include "Sound.h"


#include "CheckPlayfield.h"

#include "GameLogic.h"

#include "Intro.h"
#include "Title.h"




void main() {
  
  while(TRUE) {
    
    Intro();
    
    TitleScreen();

    InitGame();
    
  }
}
