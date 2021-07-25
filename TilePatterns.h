#define NUMBER_OF_PATTERNS 5


static const unsigned char pattern_black[] = {
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
  };

// top left
static const unsigned char pattern_0[] = {
    0b10011111,
    0b10010000,
    0b10010000,
    0b10010011,
    0b10010010,
    0b10010010,
    0b10010010,
    0b10010010,
  };

// top right
static const unsigned char pattern_1[] = {
    0b11111111,
    0b00000001,
    0b00000001,
    0b11111001,
    0b00001001,
    0b00001001,
    0b01001001,
    0b01001001,
  };

// top left
static const unsigned char pattern_2[] = {
    0b10010010,
    0b10010011,
    0b10010000,
    0b10010000,
    0b10011111,
    0b10000000,
    0b10000000,
    0b11111111,
  };

// bottom right
static const unsigned char pattern_3[] = {
    0b01001001,
    0b11001001,
    0b00001001,
    0b00001001,
    0b11111001,
    0b00000001,
    0b00000001,
    0b11111111,
  };

