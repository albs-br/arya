// Screen 2 VRAM mapping
#define NAMTBL  6144
#define CLRTBL  8192
#define PATTBL  2048
#define SPRATT  6912
#define SPRPAT  14336


#define PLAYFIELD_HORIZ_OFFSET		10


void DrawChar(byte character, byte col, byte line) {
  WRTVRM(NAMTBL + (line * 32) + col, character);
}

void DrawString(const char* str, byte col, byte line) {
  while (*str) {
    DrawChar((*str++) - (65 - CHAR_A), col++, line);
  }
}

void DrawNumber(word number, byte col, byte line) {

  word power;
  bool trailingZero = TRUE;

  DrawString("      ", col, line); // Clear space for number (6 digits)

  for(byte i = 6; i > 0; i--) { //  (6 digits)
    
    power = Power(10, i - 1);

    if(trailingZero && (number / power) != 0) trailingZero = FALSE;
    
    if(!trailingZero || i == 1) {
      DrawChar((number / power) + CHAR_0, col, line);
      number = number % power;
    }
    
    col++;
  }
  
  // test
  //d_value = Power(10, 2);
}

void DrawColumn(byte col) {
  WRTVRM(NAMTBL + col + 0, COLUMN_TOP_1);
  WRTVRM(NAMTBL + col + 1, COLUMN_TOP_1 + 1);
  WRTVRM(NAMTBL + col + 2, COLUMN_TOP_1 + 2);
  WRTVRM(NAMTBL + col + 32, COLUMN_TOP_1 + 3);
  WRTVRM(NAMTBL + col + 33, COLUMN_TOP_1 + 4);
  WRTVRM(NAMTBL + col + 34, COLUMN_TOP_1 + 5);

  for(byte i=0; i<20; i++) {
    WRTVRM(NAMTBL + col + 64 + (i*32), COLUMN_MIDDLE_1);
    WRTVRM(NAMTBL + col + 65 + (i*32), COLUMN_MIDDLE_1 + 1);
    WRTVRM(NAMTBL + col + 66 + (i*32), COLUMN_MIDDLE_1 + 2);
  }

  WRTVRM(NAMTBL + col + (32 * 8), COLUMN_MIDDLE_2);
  WRTVRM(NAMTBL + col + (32 * 8) + 1, COLUMN_MIDDLE_2 + 1);
  WRTVRM(NAMTBL + col + (32 * 8) + 2, COLUMN_MIDDLE_2 + 2);

  WRTVRM(NAMTBL + col + (32 * 16), COLUMN_MIDDLE_2);
  WRTVRM(NAMTBL + col + (32 * 16) + 1, COLUMN_MIDDLE_2 + 1);
  WRTVRM(NAMTBL + col + (32 * 16) + 2, COLUMN_MIDDLE_2 + 2);

  WRTVRM(NAMTBL + col + (32 * 22) + 0, COLUMN_BOTTOM_1);
  WRTVRM(NAMTBL + col + (32 * 22) + 1, COLUMN_BOTTOM_1 + 1);
  WRTVRM(NAMTBL + col + (32 * 22) + 2, COLUMN_BOTTOM_1 + 2);
  WRTVRM(NAMTBL + col + (32 * 22) + 32, COLUMN_BOTTOM_1 + 3);
  WRTVRM(NAMTBL + col + (32 * 22) + 33, COLUMN_BOTTOM_1 + 4);
  WRTVRM(NAMTBL + col + (32 * 22) + 34, COLUMN_BOTTOM_1 + 5);
}

void DrawScore() {
  byte bgCounter = 0, bgColor;
  word lastJiffy;
  
  // Animation blinking Level number on scoreboard
  if(newLevel) {
    for(byte i=0; i < 60; i++) {
      lastJiffy = JIFFY;
      while(lastJiffy == JIFFY) { }
      

      if(JIFFY & 0b00000110) {
  	DrawString(" LEVEL", 26, 4);
      	DrawNumber(level, 26, 5);
        
        // Animate Bg
        //void FILVRM(uint16_t start, uint16_t len, uint8_t data);
        //if(JIFFY & 0b0000001100000000 == 0) {
        //if(JIFFY % 8 == 0) {
          switch(bgCounter++) {
            case 0:
              bgColor = 0x14;
              break;
            case 1:
              bgColor = 0x15;
              break;
            case 2:
              bgColor = 0x17;
              break;
            case 3:
              bgColor = 0x1e;
              break;
            case 4:
              bgColor = 0x1f;
              break;
            case 5:
              bgColor = 0x1e;
              break;
            case 6:
              bgColor = 0x17;
              break;
            case 7:
              bgColor = 0x15;
              bgCounter = 0;
              break;
            default:
              bgColor = 0x11;

          }
          FILVRM(CLRTBL, 8 * 4, bgColor);
          FILVRM(CLRTBL + (256 * 8), 8 * 4, bgColor);
          FILVRM(CLRTBL + (512 * 8), 8 * 4, bgColor);
        //}
        
      }
      else {
  	DrawString("      ", 26, 4);
      	DrawString("      ", 26, 5);
      }
      
    }
  }
  
  newLevel = FALSE;
  
  // Restore correct BG Color
  FILVRM(CLRTBL, 8 * 4, 0x14);
  FILVRM(CLRTBL + (256 * 8), 8 * 4, 0x14);
  FILVRM(CLRTBL + (512 * 8), 8 * 4, 0x14);
  
  DrawString(" LEVEL", 26, 4);
  DrawString("BLOCKS", 26, 9);
  
  DrawNumber(blocksRemoved, 26, 10);
  DrawNumber(level, 26, 5);
  
}

void DrawBackground() {
  // Write to names table
  for(int i = 0; i < 256 * 3; i++) {
    WRTVRM(NAMTBL + i, 0); // test
  }

  DrawColumn(7);
  DrawColumn(22);
  
  DrawScore();
  //DrawString(" LEVEL", 26, 4);
  //DrawString("BLOCKS", 26, 9);
  
  /*
  // test font
  for(byte i=0; i<10; i++) {
    WRTVRM(NAMTBL + i, CHAR_0 + i);
  }
  for(byte i=0; i<10; i++) {
    WRTVRM(NAMTBL + 32 + i, CHAR_A + i);
  }
  for(byte i=0; i<10; i++) {
    WRTVRM(NAMTBL + 64 + i, CHAR_A + 10 + i);
  }
  for(byte i=0; i<10; i++) {
    WRTVRM(NAMTBL + 96 + i, CHAR_A + 20 + i);
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
  */
}

void DrawArrow(byte x, byte y) {
  const byte colors[] = {
    15,
    14,
    5,
    4,
    4,
    5,
    14,
    15,
  };
  
  byte colorIndex = (JIFFY & 0b00001110) >> 1;
  
  
  //if(JIFFY & 0b00000001) color = 15;
  //else color = 4;
  
  // First sprite
  WRTVRM(SPRATT, 	y - 1);
  WRTVRM(SPRATT + 1, 	x);
  WRTVRM(SPRATT + 2, 	SPRITE_PATTERN_DOWN_ARROW);
  WRTVRM(SPRATT + 3, 	colors[colorIndex]);

  // Second sprite (offset to right/down by 1px)
  /*
  WRTVRM(SPRATT + 4,  	y);
  WRTVRM(SPRATT + 5, 	x + 1);
  WRTVRM(SPRATT + 6, 	0);
  WRTVRM(SPRATT + 7, 	4);
  */
}

void HideArrow() {
  WRTVRM(SPRATT, 	192);
}

void DrawHitSprite(byte x, byte y, bool firstTime) {
  //TODO: refactor (code repeated)
  const byte colors[] = {
    15,
    14,
    5,
    4,
    4,
    5,
    14,
    15,
  };
  
  byte colorIndex = (JIFFY & 0b00000111) >> 1;

  if(firstTime) {
    WRTVRM(SPRATT + 5, 	x - 8);
    WRTVRM(SPRATT + 6, 	SPRITE_PATTERN_3X);

    WRTVRM(SPRATT + 9, 	x + 8);
    WRTVRM(SPRATT + 10, 	SPRITE_PATTERN_HIT_1 + 4);

    WRTVRM(SPRATT + 13, 	x + 24);
    WRTVRM(SPRATT + 14, 	SPRITE_PATTERN_HIT_2 + 8);
  }

  WRTVRM(SPRATT + 4, 	y);
  WRTVRM(SPRATT + 7, 	colors[colorIndex]);

  WRTVRM(SPRATT + 8, 	y);
  WRTVRM(SPRATT + 11, 	colors[colorIndex]);

  WRTVRM(SPRATT + 12, 	y);
  WRTVRM(SPRATT + 15, 	colors[colorIndex]);
}

void HideHitSprite() {
  WRTVRM(SPRATT + 4, 	192);
  WRTVRM(SPRATT + 8, 	192);
  WRTVRM(SPRATT + 12, 	192);
}

void InitVRAM() {

  //const byte SPRATT = SPRATT;

  
  CLIKSW = 0;	// disable keyboard sound
  SCNCNT = 1; 	// set keyboard scan counter
  
  FORCLR = COLOR_WHITE;
  BAKCLR = COLOR_BLACK;
  BDRCLR = COLOR_BLACK;
  
 
  /*
  ; Write to VDP register 1 (Set Screen mode, sprites size, Vblank, Display, VRAM mode setting)
  ; Set it to 225 (‭1110 0001‬ b)
  ; bit 7: 4/16K selects VRAM configuration. Write 1 if the VDP is not a V9938 nor V9958.
  ; bit 6: BL disables the screen display when reseted.VDP's commands work a bit faster as well. Screen display is displayed by default.
  ; bit 5: IE0 enables (1) or disable (0) the vertical retrace interrupts that occur at just after each display of the screen (foreground).
  ; bit 4: M2 is one of bits that defines the screen mode. (Write 1 to set the SCREEN 3)
  ; bit 3: M1 is one of bits that defines the screen mode. (Write 1 to set the SCREEN 0)
  ; bit 2: not used (always 0)
  ; bit 1: SI defines the sprite size. Write 1 to use 16x16 sprites, 0 to use 8x8 sprites.
  ; bit 0: MAG enlarges the sprites when 1 is written. (0 by default)
  ; https://www.msx.org/wiki/VDP_Mode_Registers#Control_Register_1
          ld		c, 1	               		; VDP Register Number (0..27, 32..46)
          ld		b, 1110 0010 b   	        ; Data To Write
      call 	BIOS_WRTVDP        		    ; 
  */
  
  /*
  reg_data;
  __asm__("ld b,l");
  __asm__("ld c,h");
  MSXUSR(0x0047);  
  */
  
  // Initialize some VDP parameters, such as sprite size
  WRTVDP(0b0000000111100010);

  INIGRP();	// Set screen 2

  DISSCR();	// Disable screen (faster to write)
  
  
  // Clear all VRAM (16Kb)
  FILVRM(0x0000, 0x4000, 0x00); //void FILVRM(uint16_t start, uint16_t len, uint8_t data);

  
  
  // Test - clear names table
  //FILVRM(NAMTBL, 768, EMPTY); //void FILVRM(uint16_t start, uint16_t len, uint8_t data);
  
  
  // Loading sprites
  LDIRVM(SPRPAT, sprite_arrow_0, NUMBER_OF_SPRITES * 32);

  // Testing sprite
  //SetArrow(0, 0);
  
  // Placing all sprites off screen
  for(byte i=0; i<32; i++) {
    WRTVRM(SPRATT + (i * 4), 	192);
  }
    
  // Write to patterns table
  //for(int i = 0; i < 8; i++) {
  //	WRTVRM(PATTBL + (exampleChar * 8) + i, 0b10110011);
  //}
  
  // Loading patterns (1st bank)
  LDIRVM(PATTBL, pattern_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading patterns (2nd bank)
  LDIRVM(PATTBL + (256 * 8), pattern_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

  // Loading patterns (3rd bank)
  LDIRVM(PATTBL + (512 * 8), pattern_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  // Loading font patterns (1st bank)
  LDIRVM(PATTBL + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  // Loading font patterns (2nd bank)
  LDIRVM(PATTBL + (256 * 8) + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  
  // Loading font patterns (3rd bank)
  LDIRVM(PATTBL + (512 * 8) + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
  

  // Title blocks
  for(byte i=0; i < NUMBER_OF_TITLE_BLOCKS; i++) {
    LDIRVM(PATTBL + (TITLE_1 * 8) + (i * 8), pattern_title, NUMBER_OF_TITLE_BLOCKS * 8);
  }
  
  
  // Write to colors table
  //for(int i = 0; i < 8; i++) {
  //	WRTVRM(CLRTBL + (exampleChar * 8) + i, 0x8a);
  //}
  
  // Loading colors (1st bank)
  LDIRVM(CLRTBL, color_black_0, NUMBER_OF_PATTERNS * 8);
  // Loading colors (2nd bank)
  LDIRVM(CLRTBL + (256 * 8), color_black_0, NUMBER_OF_PATTERNS * 8);
  // Loading colors (3rd bank)
  LDIRVM(CLRTBL + (512 * 8), color_black_0, NUMBER_OF_PATTERNS * 8);

  
  // Loading font colors
  // Single color
  //FILVRM(CLRTBL + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, 0xf0);
  // Gradient pattern (1st bank)
  for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
    LDIRVM(CLRTBL + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font_2, 8);
  }
  // Gradient pattern (2nd bank)
  for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
    LDIRVM(CLRTBL + (256 * 8) + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font_2, 8);
  }
  // Gradient pattern (3rd bank)
  for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
    LDIRVM(CLRTBL + (512 * 8) + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font_2, 8);
  }
  

  // Loading font colors (digits)
  // Single color
  //FILVRM(CLRTBL + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, 0xf0);
  // Gradient pattern (1st bank)
  for(byte i = 0; i < 10; i++) {
    LDIRVM(CLRTBL + (CHAR_0 * 8) + (i * 8), color_font_1, 8);
  }
  // Gradient pattern (2nd bank)
  for(byte i = 0; i < 10; i++) {
    LDIRVM(CLRTBL + (256 * 8) + (CHAR_0 * 8) + (i * 8), color_font_1, 8);
  }
  // Gradient pattern (3rd bank)
  for(byte i = 0; i < 10; i++) {
    LDIRVM(CLRTBL + (512 * 8) + (CHAR_0 * 8) + (i * 8), color_font_1, 8);
  }
  
  // Title blocks
  LDIRVM(CLRTBL + (TITLE_1 * 8), color_title_1, NUMBER_OF_TITLE_BLOCKS * 8);
  
  
  
  //DrawBackground();
  
  
  
  ENASCR();	// Enable screen
}

void DrawBlock(byte col, byte line, byte tile) {
  //const byte horizOffset = 10;	// playfield offset from screen left border
  word baseAddr = NAMTBL + (col * 2) + (line * 2 * 32) + PLAYFIELD_HORIZ_OFFSET;
  
  WRTVRM(baseAddr, tile);
  WRTVRM(baseAddr + 1, tile + 1);
  WRTVRM(baseAddr + 32, tile + 2);
  WRTVRM(baseAddr + 33, tile + 3);
}

void DrawBlock_SameTile(byte col, byte line, byte tile) {
  //const byte horizOffset = 10;	// playfield offset from screen left border
  word baseAddr = NAMTBL + (col * 2) + (line * 2 * 32) + PLAYFIELD_HORIZ_OFFSET;
  
  WRTVRM(baseAddr, tile);
  WRTVRM(baseAddr + 1, tile);
  WRTVRM(baseAddr + 32, tile);
  WRTVRM(baseAddr + 33, tile);
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


