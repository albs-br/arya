#define NUMBER_OF_PATTERNS 	43
#define CHAR_A			(NUMBER_OF_PATTERNS + 33)	// ALWAYS use parenthesis when defining pre-compilation constants with expressions
#define CHAR_0			(NUMBER_OF_PATTERNS + 16)
#define TITLE_1			(NUMBER_OF_PATTERNS + (HICHAR - LOCHAR))
#define NUMBER_OF_TITLE_BLOCKS 	7
#define COLUMN_TOP_1		24
#define COLUMN_MIDDLE_1		30
#define COLUMN_MIDDLE_2		33
#define COLUMN_BOTTOM_1		36

// Empty spaces

// top left
static const unsigned char pattern_black_0[] = {
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
  };

// top right
static const unsigned char pattern_black_1[] = {
    0b11111110,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111110,
    0b11111111,
    0b11111111,
    0b11111110,
  };

// bottom left
static const unsigned char pattern_black_2[] = {
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111011,
    0b11111111,
    0b10111011,
  };

// bottom right
static const unsigned char pattern_black_3[] = {
    0b11111011,
    0b11111110,
    0b11111101,
    0b11111110,
    0b11110111,
    0b11111010,
    0b10101111,
    0b01010101,
  };

// ---------------------------------------------

// Green

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

// Red

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

// ---------------------------------------------

// Blue

// top left
static const unsigned char pattern_8[] = {
    0b01111111,
    0b10101110,
    0b11111111,
    0b01011011,
    0b11111111,
    0b10101110,
    0b11111111,
    0b11011111,
  };

// top right
static const unsigned char pattern_9[] = {
    0b11111110,
    0b10111101,
    0b11011111,
    0b01111111,
    0b11111011,
    0b11011111,
    0b11111110,
    0b11101111,
  };

// bottom left
static const unsigned char pattern_10[] = {
    0b01111111,
    0b11111111,
    0b11101101,
    0b11111111,
    0b10110110,
    0b11111110,
    0b11011011,
    0b01111101,
  };

// bottom right
static const unsigned char pattern_11[] = {
    0b11111110,
    0b11111111,
    0b11111110,
    0b01110111,
    0b11111110,
    0b11011101,
    0b11101111,
    0b01011010,
  };

// ---------------------------------------------

// Purple

// top left
static const unsigned char pattern_12[] = {
    0b01111111,
    0b11010101,
    0b10111111,
    0b11101101,
    0b10111111,
    0b11110101,
    0b10111111,
    0b11111111,
  };

// top right
static const unsigned char pattern_13[] = {
    0b11111110,
    0b01011111,
    0b11110101,
    0b11011111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11111111,
  };

// bottom left
static const unsigned char pattern_14[] = {
    0b11101111,
    0b10111111,
    0b01111111,
    0b11111111,
    0b11111111,
    0b11111111,
    0b11011011,
    0b01111111,
  };

// bottom right
static const unsigned char pattern_15[] = {
    0b11111111,
    0b11111101,
    0b11111111,
    0b11011011,
    0b11111101,
    0b01111011,
    0b11010111,
    0b11111110,
  };

// ---------------------------------------------

// Yellow

// top left
static const unsigned char pattern_16[] = {
    0b01111111,
    0b11111111,
    0b11101010,
    0b11011111,
    0b11111111,
    0b11011111,
    0b11111111,
    0b11011111,
  };

// top right
static const unsigned char pattern_17[] = {
    0b11111110,
    0b11111111,
    0b10101111,
    0b11111010,
    0b11111111,
    0b11111010,
    0b11111111,
    0b11111010,
  };

// bottom left
static const unsigned char pattern_18[] = {
    0b11111111,
    0b11011111,
    0b11111111,
    0b11011111,
    0b11111111,
    0b11101010,
    0b11111111,
    0b01010101,
  };

// bottom right
static const unsigned char pattern_19[] = {
    0b11111111,
    0b11111010,
    0b11111111,
    0b11111010,
    0b11110111,
    0b10101010,
    0b11111111,
    0b01010110,
  };

// -----------------------------------


// Column top

// top left
static const unsigned char pattern_20[] = {
    0b00111111,
    0b01111111,
    0b11100000,
    0b11001110,
    0b11100110,
    0b01111100,
    0b00111001,
    0b00000011,
  };

// top center
static const unsigned char pattern_21[] = {
    0b11111111,
    0b11111111,
    0b00000000,
    0b11011011,
    0b11011011,
    0b00000000,
    0b11111111,
    0b11111111,
  };

// top right
static const unsigned char pattern_22[] = {
    0b11111100,
    0b11111110,
    0b00000111,
    0b01110011,
    0b01100111,
    0b00111110,
    0b10011100,
    0b11000000,
  };

// bottom left
static const unsigned char pattern_23[] = {
    0b00000110,
    0b00000000,
    0b00000011,
    0b00000100,
    0b00000101,
    0b00000101,
    0b00000101,
    0b00000101,
  };

// bottom center
static const unsigned char pattern_24[] = {
    0b00000000,
    0b00000000,
    0b00110011,
    0b01000100,
    0b01010101,
    0b01010101,
    0b01010101,
    0b01010101,
  };

// bottom right
static const unsigned char pattern_25[] = {
    0b01100000,
    0b00000000,
    0b01000000,
    0b00100000,
    0b00100000,
    0b00100000,
    0b00100000,
    0b00100000,
  };

// -----------------------------------

// Column middle

// left
static const unsigned char pattern_26[] = {
    0b00000101,
    0b00000101,
    0b00000101,
    0b00000101,
    0b00000101,
    0b00000101,
    0b00000101,
    0b00000101,
  };

// center
static const unsigned char pattern_27[] = {
    0b01010101,
    0b01010101,
    0b01010101,
    0b01010101,
    0b01010101,
    0b01010101,
    0b01010101,
    0b01010101,
  };

// right
static const unsigned char pattern_28[] = {
    0b00100000,
    0b00100000,
    0b00100000,
    0b00100000,
    0b00100000,
    0b00100000,
    0b00100000,
    0b00100000,
  };

// -----------------------------------

// Column middle w/ stripe

// left
static const unsigned char pattern_29[] = {
    0b00000101,
    0b00000101,
    0b00000111,
    0b00000111,
    0b00000111,
    0b00000101,
    0b00000101,
    0b00000101,
  };

// center
static const unsigned char pattern_30[] = {
    0b01010101,
    0b01010101,
    0b11111111,
    0b11111111,
    0b11111111,
    0b01010101,
    0b01010101,
    0b01010101,
  };

// right
static const unsigned char pattern_31[] = {
    0b00100000,
    0b00100000,
    0b11100000,
    0b11100000,
    0b11100000,
    0b00100000,
    0b00100000,
    0b00100000,
  };

// -----------------------------------

// Column bottom

// bottom left
static const unsigned char pattern_37[] = {
    0b00000101,
    0b00000101,
    0b00000101,
    0b00000101,
    0b00000100,
    0b00000011,
    0b00000000,
    0b00000110,
  };

// bottom center
static const unsigned char pattern_38[] = {
    0b01010101,
    0b01010101,
    0b01010101,
    0b01010101,
    0b01000100,
    0b00110011,
    0b00000000,
    0b00000000,
  };

// bottom right
static const unsigned char pattern_39[] = {
    0b00100000,
    0b00100000,
    0b00100000,
    0b00100000,
    0b00100000,
    0b01000000,
    0b00000000,
    0b01100000,
  };

// top left
static const unsigned char pattern_32[] = {
    0b00000011,
    0b00111001,
    0b01111100,
    0b11100110,
    0b11001110,
    0b11100000,
    0b01111111,
    0b00111111,
  };

// top center
static const unsigned char pattern_33[] = {
    0b11111111,
    0b11111111,
    0b00000000,
    0b11011011,
    0b11011011,
    0b00000000,
    0b11111111,
    0b11111111,
  };

// top right
static const unsigned char pattern_34[] = {
    0b11000000,
    0b10011100,
    0b00111110,
    0b01100111,
    0b01110011,
    0b00000111,
    0b11111110,
    0b11111100,
  };

// -----------------------------------


// Title block
static const unsigned char pattern_title[] = {
    0b11111110,
    0b11111110,
    0b11111110,
    0b11111110,
    0b11111110,
    0b11111110,
    0b11111110,
    0b00000000,
  };

// ---------------------------------------------
