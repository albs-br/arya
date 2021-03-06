#define A		TITLE_1
#define B		(TITLE_1 + 1)
#define C		(TITLE_1 + 2)
#define D		(TITLE_1 + 3)
#define E		(TITLE_1 + 4)
#define F		(TITLE_1 + 5)
#define G		(TITLE_1 + 6)






void SetBlock(byte col, byte line, byte tileNumber) {
  WRTVRM(NAMTBL + col + (line * 32), tileNumber);
}

void TitleScreen() {
  byte colorIndex = 0;
  
  // Title screen names table (32 x 24 chars)
  static const unsigned char title[] = {
      0, 0, 0, 0, A, A, A, A, 0, A, A, A, A, A, A, 0, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, 0, A, A, A, A, 
      0, 0, 0, A, A, A, A, A, 0, A, A, 0, 0, 0, A, A, 0, 0, A, A, 0, 0, A, A, 0, 0, 0, A, A, A, A, A, 
      0, 0, A, A, A, 0, A, A, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, A, A, 0, A, A, 0, 0, A, A, A, 0, A, A, 
      0, A, A, A, 0, 0, A, A, 0, A, A, 0, 0, A, A, 0, 0, 0, 0, 0, A, A, A, 0, 0, A, A, A, 0, 0, A, A, 
      0, A, A, 0, 0, 0, A, A, 0, A, A, A, A, A, 0, 0, 0, 0, 0, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, A, A, 
      0, A, A, 0, 0, 0, A, A, 0, A, A, A, A, A, 0, 0, 0, 0, 0, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, A, A, 
      0, A, A, A, A, A, A, A, 0, A, A, 0, 0, 0, A, 0, 0, 0, 0, 0, A, A, 0, 0, 0, A, A, A, A, A, A, A, 
      0, A, A, 0, 0, 0, A, A, 0, A, A, 0, 0, 0, A, 0, 0, 0, 0, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, A, A, 
    };
  
 
  const char blocks[] = {
    A, // yellow
    B, // yellow
    C, // magenta
    D, // white
    E, // cyan
    F, // blue
    G, // blue
  };
  
  const char colors[] = { A, C, E, G }; // last item will be ignored
  //const char colors[] = { A, C }; // test
  
  InitVRAM();

  LDIRVM(NAMTBL, title, sizeof(title));
  
  DrawString("PRESS TRIGGER TO START", 5, 13);
  DrawString("ANDREBAPTISTA.COM.BR", 0, 23);
  DrawString("v.1.0.0", 32-7, 23);
  
  while(TRUE) {
    byte index = 0, col_1, line_1; //, col_2, line_2, col_3, line_3;
    //byte rnd;
    byte spaceBar, btn1, btn2;
    byte value;
    word counter = 0;
    //byte currentColor, nextColor;
    
    //word lastJiffy = JIFFY;
    //while (JIFFY == lastJiffy) {
    //}
    
    // Title animation v-sync'ed starts here
    

    do {

      //currentColor = colors[0];
      //nextColor = colors[colorIndex];

      //DrawNumber(nextColor, 0, 15);

      col_1 = GetRandomInInterval(31, 0b00011111);
      line_1 = GetRandomInInterval(7, 0b00000111);
      //col_2 = GetRandomInInterval(31, 0b00011111);
      //line_2 = GetRandomInInterval(7, 0b00000111);
      value = RDVRM(NAMTBL + col_1 + (line_1 * 32));
      
      // Next color
      if(counter++ > 1000) {
        colorIndex++;
      	if(colorIndex >= sizeof(colors) - 1) colorIndex = 0;
        /*
      	if(colorIndex == sizeof(colors) - 1) {
          currentColor = colors[sizeof(colors) - 1];  // last color
          nextColor = colors[0];                      // first color
        }
        else {
          if(colorIndex == sizeof(colors)) {
            colorIndex = 0;
          }
          currentColor = colors[colorIndex];
          nextColor = colors[colorIndex + 1];
        }
        */
        
        counter = 0;
      }
    }
    while (value == EMPTY || value == colors[colorIndex + 1]);
    /*
    do {
      col_2 = GetRandomInInterval(31, 0b00011111);
      line_2 = GetRandomInInterval(7, 0b00000111);
    }
    while (RDVRM(NAMTBL + col_2 + (line_2 * 32)) == EMPTY);
    
    do {
      col_3 = GetRandomInInterval(31, 0b00011111);
      line_3 = GetRandomInInterval(7, 0b00000111);
    }
    while (RDVRM(NAMTBL + col_3 + (line_3 * 32)) == EMPTY);
    */
    //rnd = GetRandomInInterval(7, 0b00000111);
    
    for(byte i=0; i < 10 + 0; i++) {

      word lastJiffy = JIFFY;
      while (JIFFY == lastJiffy) {
      }
      
      // Animation v-sync'ed starts here
      
      SetBlock(col_1, line_1, blocks[index]);
      //SetBlock(col_2, line_2, blocks[index]);
      //SetBlock(col_3, line_3, blocks[index]);

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
    
    SetBlock(col_1, line_1, colors[colorIndex + 1]);
    
  }
}
