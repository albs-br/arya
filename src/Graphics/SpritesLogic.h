void DrawArrowSprite(byte x, byte y) {
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

void HideArrowSprite() {
  WRTVRM(SPRATT, 	192);
}

void DrawHitSprite(byte numberHit, byte numberCombo, byte x, byte y, bool firstTime) {
  const byte redColorRamp[] = {
    15,
    14,
    9,
    6,
    6,
    9,
    14,
    15,
  };

  // const byte blueColorRamp[] = {
  //   15,
  //   14,
  //   5,
  //   4,
  //   4,
  //   5,
  //   14,
  //   15,
  // };
  
  const byte greenColorRamp[] = {
    15,
    14,
    3,
    12,
    12,
    3,
    14,
    15,
  };
  
  byte colorIndex = (JIFFY & 0b00000111);
  byte currentColor_1 = redColorRamp[colorIndex];
  byte currentColor_2 = greenColorRamp[colorIndex];

  if(firstTime) {
    WRTVRM(SPRATT + 5, 	x - 8);
    WRTVRM(SPRATT + 6, 	SPRITE_PATTERN_3X + ((numberHit - 3) * 4));

    WRTVRM(SPRATT + 9, 	x + 8);
    WRTVRM(SPRATT + 10, 	SPRITE_PATTERN_HIT);

    WRTVRM(SPRATT + 13, 	x + 24);
    WRTVRM(SPRATT + 14, 	SPRITE_PATTERN_HIT + 4);

    if(numberCombo > 1) {
      WRTVRM(SPRATT + 17, 	x - 8);
      WRTVRM(SPRATT + 18, 	SPRITE_PATTERN_2X + ((numberCombo - 2) * 4));

      WRTVRM(SPRATT + 21, 	x + 8);
      WRTVRM(SPRATT + 22, 	SPRITE_PATTERN_COMBO);

      WRTVRM(SPRATT + 25, 	x + 24);
      WRTVRM(SPRATT + 26, 	SPRITE_PATTERN_COMBO + 4);
    }
  }

  // Hit sprite
  WRTVRM(SPRATT + 4, 	y);
  WRTVRM(SPRATT + 7, 	currentColor_1);

  WRTVRM(SPRATT + 8, 	y);
  WRTVRM(SPRATT + 11, 	currentColor_1);

  WRTVRM(SPRATT + 12, 	y);
  WRTVRM(SPRATT + 15, 	currentColor_1);

  if(numberCombo > 1) {
    // Combo sprite
    WRTVRM(SPRATT + 16, 	y + 16);
    WRTVRM(SPRATT + 19, 	currentColor_2);

    WRTVRM(SPRATT + 20, 	y + 16);
    WRTVRM(SPRATT + 23, 	currentColor_2);

    WRTVRM(SPRATT + 24, 	y + 16);
    WRTVRM(SPRATT + 27, 	currentColor_2);
  }
}

void HideHitSprite() {
  // Hit sprite
  WRTVRM(SPRATT + 4, 	192);
  WRTVRM(SPRATT + 8, 	192);
  WRTVRM(SPRATT + 12, 	192);

  // Combo sprite
  WRTVRM(SPRATT + 16, 	192);
  WRTVRM(SPRATT + 20, 	192);
  WRTVRM(SPRATT + 24, 	192);
}

void HideExplosionSprite() {
  WRTVRM(SPRATT + 28, 	192);
  WRTVRM(SPRATT + 32, 	192);
  WRTVRM(SPRATT + 36, 	192);
}

void DrawExplosionSprite(byte x, byte y, byte counter) {

  byte spriteNumber = (counter >> 2); // sprite number between 0 and 7

  if(spriteNumber > 7) {
      HideExplosionSprite();
  }
  else {
    spriteNumber = spriteNumber * 4;

    WRTVRM(SPRATT + 28, 	y - 16);
    WRTVRM(SPRATT + 29, 	x);
    WRTVRM(SPRATT + 30, 	SPRITE_PATTERN_EXPLOSION + spriteNumber);
    WRTVRM(SPRATT + 31, 	15);

    WRTVRM(SPRATT + 32, 	y - 16);
    WRTVRM(SPRATT + 33, 	x + 16);
    WRTVRM(SPRATT + 34, 	SPRITE_PATTERN_EXPLOSION + spriteNumber);
    WRTVRM(SPRATT + 35, 	10);

    WRTVRM(SPRATT + 36, 	y - 16);
    WRTVRM(SPRATT + 37, 	x + 32);
    WRTVRM(SPRATT + 38, 	SPRITE_PATTERN_EXPLOSION + spriteNumber);
    WRTVRM(SPRATT + 39, 	3);
  }
}
