
#include <ctype.h>
#include <stdio.h>
#include <string.h>

#include "msxbios.h"
//#link "msxbios.c"

#include "TilePatterns.h"
#include "TileColors.h"


typedef uint8_t byte;
typedef uint16_t word;
typedef uint8_t bool;

#define TRUE 1
#define FALSE 0



void InitVRAM() {
  byte * nameTable = (byte *)MSX_modedata_screen2.name;
  int exampleChar = 0;
  //void * p = (void *)0x28ff44;
  //int* nt;
  
  //nt = 6144;
  //*nameTable = 6144;

   //int  *ip;        /* pointer variable declaration */
  
   //int  var = 20;   /* actual variable declaration */
   //int  *ip;        /* pointer variable declaration */

   //ip = &var;  /* store address of var in pointer variable*/
  
  
   //printf("Address of var variable: %x\n", &var  );

   /* address stored in pointer variable */
   //printf("Address stored in ip variable: %x\n", ip );

   /* access the value using the pointer */
   //printf("Value of *ip variable: %d\n", *ip );
  
  FORCLR = COLOR_GREEN;
  BAKCLR = COLOR_MAGENTA;
  BDRCLR = COLOR_WHITE;
  
  INIGRP();	// Set screen 2
  //INIT32();	// Set screen 1
  //INITXT();	// Set screen 0
  
  
  //nameTable = 65;
  //*nameTable = 65;
  
  DISSCR();	// Disable screen (faster to write)
  
  //*nameTable = 0xc100;
  
  
  //void WRTVRM(uint16_t addr, uint8_t data);  

  
  // Clear all VRAM
  
  // fill VRAM with value
  //void FILVRM(uint16_t start, uint16_t len, uint8_t data);
  FILVRM(0x0000, 0x4000, 0x00); //void FILVRM(uint16_t start, uint16_t len, uint8_t data);

  
  
  // Write to patterns table
  for(int i = 0; i < 8; i++) {
  	WRTVRM(MSX_modedata_screen2.pattern + (exampleChar * 8) + i, 0b10110011);
  }
  
  // Loading patterns (1st bank)
  LDIRVM(MSX_modedata_screen2.pattern + (exampleChar * 8), pattern_0, 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading patterns (2nd bank)
  LDIRVM(MSX_modedata_screen2.pattern + (256 * 8) + (exampleChar * 8), pattern_0, 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading patterns (3rd bank)
  LDIRVM(MSX_modedata_screen2.pattern + (512 * 8)  + (exampleChar * 8), pattern_0, 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  

  
  // Write to colors table
  for(int i = 0; i < 8; i++) {
  	WRTVRM(MSX_modedata_screen2.color + (exampleChar * 8) + i, 0x8a);
  }
  
  // Loading colors (1st bank)
  LDIRVM(MSX_modedata_screen2.color + (exampleChar * 8), color_0, 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading colors (2nd bank)
  LDIRVM(MSX_modedata_screen2.color + (256 * 8) + (exampleChar * 8), color_0, 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  // Loading colors (3rd bank)
  LDIRVM(MSX_modedata_screen2.color + (512 * 8) + (exampleChar * 8), color_0, 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  
  
  // Write to names table
  for(int i = 0; i < 256 * 3; i++) {
  	WRTVRM(MSX_modedata_screen2.name + i, exampleChar);
  }
  
  //*nameTable = 60;
  //*nameTable++ = 65;
  //*nameTable++ = 65;

  //int i =  1;  
  /*
  
  typedef struct {
    uint16_t name;
    uint16_t color;
    uint16_t pattern;
    uint16_t sprite_attribute;
    uint16_t sprite_pattern;
  } MSXVDPModeData;


  MSXVDPModeData __at(0xf3c7) MSX_modedata_screen2;
  */
  //printf("%04x\n", nameTable);
  
  
  ENASCR();	// Enable screen
}


void gameLoop() {
  
  bool gameOver = FALSE;

  while(!gameOver) {

    word lastJiffy = JIFFY;

    while (lastJiffy == JIFFY) {
    }

    // Game loop sync'ed at 60/50 Hz starts here
  }
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
  
  gameLoop();
  
  //while (1) {}
}

