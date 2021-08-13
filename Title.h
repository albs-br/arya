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
      0, 0, 0, 0, A, A, A, A, 0, A, A, A, A, A, A, 0, 0, A, A, 0, 0, 0, A, A, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, 0, A, A, A, A, A, 0, B, A, 0, 0, 0, A, A, 0, 0, A, A, 0, 0, A, A, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, 0, A, A, A, 0, A, A, 0, C, A, 0, 0, 0, A, A, 0, 0, 0, A, A, 0, A, A, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, A, A, A, 0, 0, A, A, 0, D, A, 0, 0, A, A, 0, 0, 0, 0, 0, A, A, A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, A, A, 0, 0, 0, A, A, 0, A, A, A, A, A, 0, 0, 0, 0, 0, 0, A, A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, A, A, 0, 0, 0, A, A, 0, A, A, A, A, A, 0, 0, 0, 0, 0, 0, A, A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, A, A, A, A, A, A, A, 0, A, A, 0, 0, 0, A, 0, 0, 0, 0, 0, A, A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
      0, A, A, 0, 0, 0, A, A, 0, A, A, 0, 0, 0, A, 0, 0, 0, 0, 0, A, A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
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
  
  // Write to names table
  /*
  for(int i = 0; i < 256 * 3; i++) {
    WRTVRM(MSX_modedata_screen2.name + i, EMPTY); // test
  }
  */

  LDIRVM(MSX_modedata_screen2.name, title, 32 * 24);
  
  
  /*
    word lastJiffy = JIFFY;
    while (lastJiffy == JIFFY) {
    }
  */
  
  /*
  byte random;
  do {
     random = GetRandom() & 0b00000111; // AND mask to get a value in the 0-7 range
  }
  while(random > 4); // Get a number between 0 and 4  
  */
  
  while(1) {
    byte index = 0, col, line, rnd;
    word lastJiffy = JIFFY;
    while (JIFFY == lastJiffy) {
    }
    
    // Title animation v-sync'ed starts here
    do {
      col = GetRandomInInterval(31, 0b00011111);
      line = GetRandomInInterval(7, 0b00000111);
    }
    while (RDVRM(MSX_modedata_screen2.name + col + (line * 32)) == EMPTY);
    
    rnd = GetRandomInInterval(7, 0b00000111);
    
    for(byte i=0; i < 13 + rnd; i++) {

      lastJiffy = JIFFY;
      while (JIFFY == lastJiffy) {
      }
      
      BlinkBlock(col, line, blocks[index++]);

      if(index >= sizeof(blocks)) index = 0;
    }
  }
}
