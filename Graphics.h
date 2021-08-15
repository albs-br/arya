
void DrawChar(byte character, byte col, byte line) {
  WRTVRM(MSX_modedata_screen2.name + (line * 32) + col, character);
}

void DrawString(const char* str, byte col, byte line) {
  while (*str) {
    DrawChar((*str++) - (65 - CHAR_A), col++, line);
  }
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
  //d_value = Power(10, 2);
}

void DrawColumn(byte col) {
  WRTVRM(MSX_modedata_screen2.name + col + 0, COLUMN_TOP_1);
  WRTVRM(MSX_modedata_screen2.name + col + 1, COLUMN_TOP_1 + 1);
  WRTVRM(MSX_modedata_screen2.name + col + 2, COLUMN_TOP_1 + 2);
  WRTVRM(MSX_modedata_screen2.name + col + 32, COLUMN_TOP_1 + 3);
  WRTVRM(MSX_modedata_screen2.name + col + 33, COLUMN_TOP_1 + 4);
  WRTVRM(MSX_modedata_screen2.name + col + 34, COLUMN_TOP_1 + 5);

  for(byte i=0; i<20; i++) {
    WRTVRM(MSX_modedata_screen2.name + col + 64 + (i*32), COLUMN_MIDDLE_1);
    WRTVRM(MSX_modedata_screen2.name + col + 65 + (i*32), COLUMN_MIDDLE_1 + 1);
    WRTVRM(MSX_modedata_screen2.name + col + 66 + (i*32), COLUMN_MIDDLE_1 + 2);
  }
}

void DrawBackground() {
  // Write to names table
  for(int i = 0; i < 256 * 3; i++) {
    WRTVRM(MSX_modedata_screen2.name + i, 0); // test
  }

  DrawColumn(7);
  DrawColumn(22);
  
  DrawString(" LEVEL", 26, 4);
  DrawString("BLOCKS", 26, 9);
  
  /*
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
  */
}

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
  

  // Title blocks
  for(byte i=0; i < NUMBER_OF_TITLE_BLOCKS; i++) {
    LDIRVM(MSX_modedata_screen2.pattern + (TITLE_1 * 8) + (i * 8), pattern_title, NUMBER_OF_TITLE_BLOCKS * 8);
  }
  
  
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
    LDIRVM(MSX_modedata_screen2.color + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font_2, 8);
  }
  // Gradient pattern (2nd bank)
  for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
    LDIRVM(MSX_modedata_screen2.color + (256 * 8) + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font_2, 8);
  }
  // Gradient pattern (3rd bank)
  for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
    LDIRVM(MSX_modedata_screen2.color + (512 * 8) + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font_2, 8);
  }
  

  // Loading font colors (digits)
  // Single color
  //FILVRM(MSX_modedata_screen2.color + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, 0xf0);
  // Gradient pattern (1st bank)
  for(byte i = 0; i < 10; i++) {
    LDIRVM(MSX_modedata_screen2.color + (CHAR_0 * 8) + (i * 8), color_font_1, 8);
  }
  // Gradient pattern (2nd bank)
  for(byte i = 0; i < 10; i++) {
    LDIRVM(MSX_modedata_screen2.color + (256 * 8) + (CHAR_0 * 8) + (i * 8), color_font_1, 8);
  }
  // Gradient pattern (3rd bank)
  for(byte i = 0; i < 10; i++) {
    LDIRVM(MSX_modedata_screen2.color + (512 * 8) + (CHAR_0 * 8) + (i * 8), color_font_1, 8);
  }
  
  // Title blocks
  LDIRVM(MSX_modedata_screen2.color + (TITLE_1 * 8), color_title_1, NUMBER_OF_TITLE_BLOCKS * 8);
  
  
  
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
  DrawNumber(level, 26, 5);
  DrawNumber(blocksRemoved, 26, 10);
}

