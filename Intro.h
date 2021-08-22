//#define A		TITLE_1

void ChangeFontColor(byte color) {
  FILVRM(MSX_modedata_screen2.color + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, color);
  FILVRM(MSX_modedata_screen2.color + (256 * 8)  + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, color);
  FILVRM(MSX_modedata_screen2.color + (512 * 8)  + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, color);
}

void ScrollDownFont() {
  // Loading font patterns (1st bank)
  LDIRVM(MSX_modedata_screen2.pattern + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);

}

void Intro() {
  
  byte counter = 0;
  
  InitVRAM();

  DrawString("A GAME BY", 11, 11);
  DrawString("ANDRE BAPTISTA", 9, 13);
  

  

  
  
  ChangeFontColor(0xf0);

  Wait(2 * 60);

  while(counter++ < 20) {
    byte lastJiffy = JIFFY;
    while (JIFFY == lastJiffy) {
    }
    
    if(counter == 15) {
      ChangeFontColor(0x40);
    }
    else if(counter == 10) {
      ChangeFontColor(0x50);
    }
    else if(counter == 5) {
      ChangeFontColor(0xe0);
    }
  }
  
  /*
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
      // parameter for GTTRIG
      //typedef enum GTTRIG_Param {
      //  TRIG_Spacebar,
      //  TRIG_Joy1_A,
      //  TRIG_Joy2_A,
      //  TRIG_Joy1_B,
      //  TRIG_Joy2_B
      //};
      spaceBar = GTTRIG(TRIG_Spacebar);
      btn1 = GTTRIG(TRIG_Joy1_A);
      btn2 = GTTRIG(TRIG_Joy1_B);
      
      if(spaceBar == 0xff || btn1 == 0xff || btn2 == 0xff) { 
        rndSeed = JIFFY;
        return;
      }
    }
  }
  */
}

