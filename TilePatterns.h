#define NUMBER_OF_PATTERNS 9


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

// ---------------------------------------------

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

// bottom left
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

// ---------------------------------------------

// top left
static const unsigned char pattern_4[] = {
    0b01111111,
    0b10000001,
    0b10000011,
    0b10000111,
    0b10001111,
    0b10011111,
    0b10111111,
    0b11111111,
  };

// top right
static const unsigned char pattern_5[] = {
    0b11111110,
    0b10000001,
    0b11000001,
    0b11100001,
    0b11110001,
    0b11111001,
    0b11111101,
    0b11111111,
  };

// bottom left
static const unsigned char pattern_6[] = {
    0b11111111,
    0b10111111,
    0b10011111,
    0b10001111,
    0b10000111,
    0b10000011,
    0b10000001,
    0b01111111,
  };

// bottom right
static const unsigned char pattern_7[] = {
    0b11111111,
    0b11111101,
    0b11111001,
    0b11110001,
    0b11100001,
    0b11000001,
    0b10000001,
    0b11111110,
  };

