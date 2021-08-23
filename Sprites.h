
#define NUMBER_OF_SPRITES		2


#define SPRITE_PATTERN_DOWN_ARROW	0
#define SPRITE_PATTERN_3X_HIT		4



// Down Arrow

// top left
static const unsigned char sprite_arrow_0[] = {
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
  };

// bottom left
static const unsigned char sprite_arrow_1[] = {
    0b11111111,
    0b00000000,
    0b00111111,
    0b00000000,
    0b00001111,
    0b00000000,
    0b00000011,
    0b00000000,
  };

// top right
static const unsigned char sprite_arrow_2[] = {
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
    0b00000000,
  };

// bottom right
static const unsigned char sprite_arrow_3[] = {
    0b11111111,
    0b00000000,
    0b11111100,
    0b00000000,
    0b11110000,
    0b00000000,
    0b11000000,
    0b00000000,
  };

//====================================

// 3x hit

static const unsigned char sprite_3x_hit[] = {
  0x0C,0x02,0x0C,0x02,0x0C,0x00,0x00,0x00,
  0x15,0x15,0x1D,0x15,0x15,0x00,0x00,0x00,
  0x00,0x00,0xA0,0x40,0xA0,0x00,0x00,0x00,
  0x70,0x20,0x20,0x20,0x20,0x00,0x00,0x00
  };
