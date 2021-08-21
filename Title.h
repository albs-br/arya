#define A		TITLE_1
#define B		(TITLE_1 + 1)
#define C		(TITLE_1 + 2)
#define D		(TITLE_1 + 3)
#define E		(TITLE_1 + 4)
#define F		(TITLE_1 + 5)
#define G		(TITLE_1 + 6)






void BlinkBlock(byte col, byte line, byte tileNumber) {
  WRTVRM(MSX_modedata_screen2.name + col + (line * 32), tileNumber);
}

void TitleScreen() {
  
  // Title screen names table (32 x 24 chars)
  static const unsigned char title[] = {
      0, 0, 0, 0, A, A, A, A, 0, A, A, A, A, A, A, 0, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, 0, A, A, A, A, 
      0, 0, 0, A, A, A, A, A, 0, B, A, 0, 0, 0, A, A, 0, 0, A, A, 0, 0, A, A, 0, 0, 0, A, A, A, A, A, 
      0, 0, A, A, A, 0, A, A, 0, C, A, 0, 0, 0, A, A, 0, 0, 0, A, A, 0, A, A, 0, 0, A, A, A, 0, A, A, 
      0, A, A, A, 0, 0, A, A, 0, D, A, 0, 0, A, A, 0, 0, 0, 0, 0, A, A, A, 0, 0, A, A, A, 0, 0, A, A, 
      0, A, A, 0, 0, 0, A, A, 0, A, A, A, A, A, 0, 0, 0, 0, 0, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, A, A, 
      0, A, A, 0, 0, 0, A, A, 0, A, A, A, A, A, 0, 0, 0, 0, 0, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, A, A, 
      0, A, A, A, A, A, A, A, 0, A, A, 0, 0, 0, A, 0, 0, 0, 0, 0, A, A, 0, 0, 0, A, A, A, A, A, A, A, 
      0, A, A, 0, 0, 0, A, A, 0, A, A, 0, 0, 0, A, 0, 0, 0, 0, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, A, A, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    };
  
 
  const char blocks[] = {
    A,
    B,
    C,
    D,
    E,
    F,
    G,
  };
  
  InitVRAM();

  LDIRVM(MSX_modedata_screen2.name, title, 32 * 24);
  
  DrawString("PRESS TRIGGER TO START", 6, 13);
  
  while(TRUE) {
    byte index = 0, col_1, line_1, col_2, line_2, col_3, line_3;
    byte rnd;
    byte spaceBar, btn1, btn2;
    
    word lastJiffy = JIFFY;
    while (JIFFY == lastJiffy) {
    }
    
    // Title animation v-sync'ed starts here
    do {
      col_1 = GetRandomInInterval(31, 0b00011111);
      line_1 = GetRandomInInterval(7, 0b00000111);
      //col_2 = GetRandomInInterval(31, 0b00011111);
      //line_2 = GetRandomInInterval(7, 0b00000111);
    }
    while (RDVRM(MSX_modedata_screen2.name + col_1 + (line_1 * 32)) == EMPTY);
    
    do {
      col_2 = GetRandomInInterval(31, 0b00011111);
      line_2 = GetRandomInInterval(7, 0b00000111);
    }
    while (RDVRM(MSX_modedata_screen2.name + col_2 + (line_2 * 32)) == EMPTY);
    
    do {
      col_3 = GetRandomInInterval(31, 0b00011111);
      line_3 = GetRandomInInterval(7, 0b00000111);
    }
    while (RDVRM(MSX_modedata_screen2.name + col_3 + (line_3 * 32)) == EMPTY);
    
    rnd = GetRandomInInterval(7, 0b00000111);
    
    for(byte i=0; i < 0 + rnd; i++) {

      lastJiffy = JIFFY;
      while (JIFFY == lastJiffy) {
      }
      
      BlinkBlock(col_1, line_1, blocks[index]);
      BlinkBlock(col_2, line_2, blocks[index]);
      BlinkBlock(col_3, line_3, blocks[index]);

      if(index++ >= sizeof(blocks)) index = 0;
      
      //uint8_t GTTRIG(uint8_t index) __z88dk_fastcall;
      /*
      // parameter for GTTRIG
      typedef enum GTTRIG_Param {
        TRIG_Spacebar,
        TRIG_Joy1_A,
        TRIG_Joy2_A,
        TRIG_Joy1_B,
        TRIG_Joy2_B
      };      
      */
      spaceBar = GTTRIG(TRIG_Spacebar);
      btn1 = GTTRIG(TRIG_Joy1_A);
      btn2 = GTTRIG(TRIG_Joy1_B);
      
      if(spaceBar == 0xff || btn1 == 0xff || btn2 == 0xff) { 
        rndSeed = JIFFY;
        return;
      }
    }
  }
}
