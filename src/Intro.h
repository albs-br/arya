void ChangeFontColor(byte color) {
  //FILVRM(CLRTBL + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, color);
  FILVRM(CLRTBL + (256 * 8) + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, color);
  //FILVRM(CLRTBL + (512 * 8) + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, color);
}

// void ScrollDownFont() {
//   word startVRAMAddr = PATTBL + (256 * 8) + (NUMBER_OF_PATTERNS * 8);
//   word size = (HICHAR-LOCHAR+1) * 8;
//   byte value;
  
//   // Loading font patterns (1st bank)
//   	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
//   //LDIRVM(PATTBL + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);

//   //uint8_t RDVRM(uint16_t addr) __z88dk_fastcall;

//   //void WRTVRM(uint16_t addr, uint8_t data);
  
  
//   for(word i=startVRAMAddr; i < (startVRAMAddr + size); i+=8) {
//     for(word j=i+7; j>0; j--) {
//       value = RDVRM(j-1);
//       //WRTVRM(j, value);
//       WRTVRM(j, 0);
//     }
//     WRTVRM(i, 0);
    
//   }
  
// }

void FadeOut() {
  byte counter = 0;

  //Wait(60);

  ChangeFontColor(0x40);
  //ScrollDownFont();
  //ChangeFontColor(0x80);
  //ScrollDownFont();

  // f e 5 4

  while(counter++ < 105) {
    byte lastJiffy = JIFFY;
    while (JIFFY == lastJiffy) {
    }
    
    if(counter == 90) {
      ChangeFontColor(0x40);
      Wait(5);
    }
    else if(counter == 75) {
      ChangeFontColor(0x50);
      Wait(5);
    }
    else if(counter == 60) {
      ChangeFontColor(0xe0);
      Wait(5);
    }
    else if(counter == 45) {
      ChangeFontColor(0xf0);
      Wait(180);
    }
    else if(counter == 30) {
      ChangeFontColor(0xe0);
      Wait(5);
    }
    else if(counter == 15) {
      //ScrollDownFont();
      ChangeFontColor(0x50);
      Wait(5);
    }
  }

  ChangeFontColor(0x10); // Hide text
  Wait(60);

}

void Intro() {
  
  InitVRAM();

  ChangeFontColor(0x10); // Hide text

  DrawString("A game by ", 11, 9);
  DrawString("ANDRE BAPTISTA  ", 9, 11);
  FadeOut();

  ClearNamesTable();
  DrawString("Powered by", 11, 9);
  DrawString("8 BIT WORKSHOP  ", 9, 11);
  FadeOut();
  
  ClearNamesTable();
  DrawString("Powered by", 11, 9);
  DrawString(" MSX TEMPLATES  ", 9, 11);
  DrawString("by DANILO ANGELO", 8, 13);
  FadeOut();
  
  ClearNamesTable();
  DrawString("Beta tester", 11, 9);
  DrawString("BIANCA BAPTISTA ", 9, 11);
  FadeOut();
  
}

