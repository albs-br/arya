void SoundFx_2() {
  GICINI();
  
  //__asm__("HALT");

  
  /*
  WRTPSG
  Address  : #0093
  Function : Writes data to PSG register
  Input    : A  - PSG register number
             E  - Data write  
  */
  
  
  //uint16_t WRTPSG(uint16_t reg_data) __z88dk_fastcall;
  WRTPSG(0x0f08);
  
  for(byte i=0; i<255; i++) {
    WRTPSG((93 * 256) + 0);
    WRTPSG((0 * 256) + 1);
  }

  for(byte i=0; i<255; i++) {
    WRTPSG((45 * 256) + 0);
    WRTPSG((0 * 256) + 1);
  }

  WRTPSG((0 * 256) + 8);	// register 8, value 0
}

void SoundFx_1() {
  
  GICINI();

  WRTPSG((151 * 256) + 6);
  
  // Bits 7 and 6 serves to specify the direction of PSG I/O ports. 
  // Always set bit 7 and reset bit 6. Otherwise some devices connected to the joystick ports may malfunction.
  WRTPSG((0b10000001 * 256) + 7);
  
  WRTPSG((16 * 256) + 8);
  WRTPSG((19 * 256) + 12);
  WRTPSG((1 * 256) + 13);
  
  //for(word i=0; i<65000; i++) { }
  //Wait(180);
  //while(1) {}
}

/*
void Sound() {
  GICINI();
  
  __asm__("ld a, 8");
  __asm__("ld e, 15");
  __asm__("call 0x0093");
}
*/
