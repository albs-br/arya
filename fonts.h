// IBM font BIOS, normal, 8x8, y offset: 1
// made with https://8bitworkshop.com/bitmapfontgenerator/

/*

#define LOCHAR 32
#define HICHAR 127
#define FONT_BWIDTH 1
#define FONT_HEIGHT 8

const unsigned char FONT[HICHAR-LOCHAR+1][FONT_HEIGHT*FONT_BWIDTH] = {
{ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 },{ 0x0C,0x1E,0x1E,0x0C,0x0C,0x00,0x0C,0x00 },{ 0x36,0x36,0x36,0x00,0x00,0x00,0x00,0x00 },{ 0x36,0x36,0x7F,0x36,0x7F,0x36,0x36,0x00 },{ 0x0C,0x3E,0x03,0x1E,0x30,0x1F,0x0C,0x00 },{ 0x00,0x63,0x33,0x18,0x0C,0x66,0x63,0x00 },{ 0x1C,0x36,0x1C,0x6E,0x3B,0x33,0x6E,0x00 },{ 0x06,0x06,0x03,0x00,0x00,0x00,0x00,0x00 },{ 0x18,0x0C,0x06,0x06,0x06,0x0C,0x18,0x00 },{ 0x06,0x0C,0x18,0x18,0x18,0x0C,0x06,0x00 },{ 0x00,0x66,0x3C,0xFF,0x3C,0x66,0x00,0x00 },{ 0x00,0x0C,0x0C,0x3F,0x0C,0x0C,0x00,0x00 },{ 0x00,0x00,0x00,0x00,0x00,0x0C,0x0C,0x06 },{ 0x00,0x00,0x00,0x3F,0x00,0x00,0x00,0x00 },{ 0x00,0x00,0x00,0x00,0x00,0x0C,0x0C,0x00 },{ 0x60,0x30,0x18,0x0C,0x06,0x03,0x01,0x00 },{ 0x3E,0x63,0x73,0x7B,0x6F,0x67,0x3E,0x00 },{ 0x0C,0x0E,0x0C,0x0C,0x0C,0x0C,0x3F,0x00 },{ 0x1E,0x33,0x30,0x1C,0x06,0x23,0x3F,0x00 },{ 0x1E,0x33,0x30,0x1C,0x30,0x33,0x1E,0x00 },{ 0x38,0x3C,0x36,0x33,0x7F,0x30,0x78,0x00 },{ 0x3F,0x03,0x1F,0x30,0x30,0x33,0x1E,0x00 },{ 0x1C,0x06,0x03,0x1F,0x33,0x33,0x1E,0x00 },{ 0x3F,0x33,0x30,0x18,0x0C,0x0C,0x0C,0x00 },{ 0x1E,0x33,0x33,0x1E,0x33,0x33,0x1E,0x00 },{ 0x1E,0x33,0x33,0x3E,0x30,0x18,0x0E,0x00 },{ 0x00,0x0C,0x0C,0x00,0x00,0x0C,0x0C,0x00 },{ 0x00,0x0C,0x0C,0x00,0x0C,0x0C,0x06,0x00 },{ 0x18,0x0C,0x06,0x03,0x06,0x0C,0x18,0x00 },{ 0x00,0x00,0x3F,0x00,0x00,0x3F,0x00,0x00 },{ 0x06,0x0C,0x18,0x30,0x18,0x0C,0x06,0x00 },{ 0x1E,0x33,0x30,0x18,0x0C,0x00,0x0C,0x00 },{ 0x3E,0x63,0x7B,0x7B,0x7B,0x03,0x1E,0x00 },{ 0x0C,0x1E,0x33,0x33,0x3F,0x33,0x33,0x00 },{ 0x3F,0x66,0x66,0x3E,0x66,0x66,0x3F,0x00 },{ 0x3C,0x66,0x03,0x03,0x03,0x66,0x3C,0x00 },{ 0x1F,0x36,0x66,0x66,0x66,0x36,0x1F,0x00 },{ 0x7F,0x46,0x16,0x1E,0x16,0x46,0x7F,0x00 },{ 0x7F,0x46,0x16,0x1E,0x16,0x06,0x0F,0x00 },{ 0x3C,0x66,0x03,0x03,0x73,0x66,0x7C,0x00 },{ 0x33,0x33,0x33,0x3F,0x33,0x33,0x33,0x00 },{ 0x1E,0x0C,0x0C,0x0C,0x0C,0x0C,0x1E,0x00 },{ 0x78,0x30,0x30,0x30,0x33,0x33,0x1E,0x00 },{ 0x67,0x66,0x36,0x1E,0x36,0x66,0x67,0x00 },{ 0x0F,0x06,0x06,0x06,0x46,0x66,0x7F,0x00 },{ 0x63,0x77,0x7F,0x7F,0x6B,0x63,0x63,0x00 },{ 0x63,0x67,0x6F,0x7B,0x73,0x63,0x63,0x00 },{ 0x1C,0x36,0x63,0x63,0x63,0x36,0x1C,0x00 },{ 0x3F,0x66,0x66,0x3E,0x06,0x06,0x0F,0x00 },{ 0x1E,0x33,0x33,0x33,0x3B,0x1E,0x38,0x00 },{ 0x3F,0x66,0x66,0x3E,0x36,0x66,0x67,0x00 },{ 0x1E,0x33,0x07,0x0E,0x38,0x33,0x1E,0x00 },{ 0x3F,0x2D,0x0C,0x0C,0x0C,0x0C,0x1E,0x00 },{ 0x33,0x33,0x33,0x33,0x33,0x33,0x3F,0x00 },{ 0x33,0x33,0x33,0x33,0x33,0x1E,0x0C,0x00 },{ 0x63,0x63,0x63,0x6B,0x7F,0x77,0x63,0x00 },{ 0x63,0x63,0x36,0x1C,0x1C,0x36,0x63,0x00 },{ 0x33,0x33,0x33,0x1E,0x0C,0x0C,0x1E,0x00 },{ 0x7F,0x63,0x31,0x18,0x4C,0x66,0x7F,0x00 },{ 0x1E,0x06,0x06,0x06,0x06,0x06,0x1E,0x00 },{ 0x03,0x06,0x0C,0x18,0x30,0x60,0x40,0x00 },{ 0x1E,0x18,0x18,0x18,0x18,0x18,0x1E,0x00 },{ 0x08,0x1C,0x36,0x63,0x00,0x00,0x00,0x00 },{ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF },{ 0x0C,0x0C,0x18,0x00,0x00,0x00,0x00,0x00 },{ 0x00,0x00,0x1E,0x30,0x3E,0x33,0x6E,0x00 },{ 0x07,0x06,0x06,0x3E,0x66,0x66,0x3B,0x00 },{ 0x00,0x00,0x1E,0x33,0x03,0x33,0x1E,0x00 },{ 0x38,0x30,0x30,0x3E,0x33,0x33,0x6E,0x00 },{ 0x00,0x00,0x1E,0x33,0x3F,0x03,0x1E,0x00 },{ 0x1C,0x36,0x06,0x0F,0x06,0x06,0x0F,0x00 },{ 0x00,0x00,0x6E,0x33,0x33,0x3E,0x30,0x1F },{ 0x07,0x06,0x36,0x6E,0x66,0x66,0x67,0x00 },{ 0x0C,0x00,0x0E,0x0C,0x0C,0x0C,0x1E,0x00 },{ 0x30,0x00,0x30,0x30,0x30,0x33,0x33,0x1E },{ 0x07,0x06,0x66,0x36,0x1E,0x36,0x67,0x00 },{ 0x0E,0x0C,0x0C,0x0C,0x0C,0x0C,0x1E,0x00 },{ 0x00,0x00,0x33,0x7F,0x7F,0x6B,0x63,0x00 },{ 0x00,0x00,0x1F,0x33,0x33,0x33,0x33,0x00 },{ 0x00,0x00,0x1E,0x33,0x33,0x33,0x1E,0x00 },{ 0x00,0x00,0x3B,0x66,0x66,0x3E,0x06,0x0F },{ 0x00,0x00,0x6E,0x33,0x33,0x3E,0x30,0x78 },{ 0x00,0x00,0x3B,0x6E,0x66,0x06,0x0F,0x00 },{ 0x00,0x00,0x3E,0x03,0x1E,0x30,0x1F,0x00 },{ 0x08,0x0C,0x3E,0x0C,0x0C,0x2C,0x18,0x00 },{ 0x00,0x00,0x33,0x33,0x33,0x33,0x6E,0x00 },{ 0x00,0x00,0x33,0x33,0x33,0x1E,0x0C,0x00 },{ 0x00,0x00,0x63,0x6B,0x7F,0x7F,0x36,0x00 },{ 0x00,0x00,0x63,0x36,0x1C,0x36,0x63,0x00 },{ 0x00,0x00,0x33,0x33,0x33,0x3E,0x30,0x1F },{ 0x00,0x00,0x3F,0x19,0x0C,0x26,0x3F,0x00 },{ 0x38,0x0C,0x0C,0x07,0x0C,0x0C,0x38,0x00 },{ 0x18,0x18,0x18,0x00,0x18,0x18,0x18,0x00 },{ 0x07,0x0C,0x0C,0x38,0x0C,0x0C,0x07,0x00 },{ 0x6E,0x3B,0x00,0x00,0x00,0x00,0x00,0x00 },{ 0x00,0x08,0x1C,0x36,0x63,0x63,0x7F,0x00 },};

*/

#define LOCHAR 32
#define HICHAR 127
#define FONT_BWIDTH 1
#define FONT_HEIGHT 8
const char FONT[] = {
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x30,0x78,0x78,0x30,0x30,0x00,0x30,0x00,0x6C,0x6C,0x6C,0x00,0x00,0x00,0x00,0x00,0x6C,0x6C,0xFE,0x6C,0xFE,0x6C,0x6C,0x00,0x30,0x7C,0xC0,0x78,0x0C,0xF8,0x30,0x00,0x00,0xC6,0xCC,0x18,0x30,0x66,0xC6,0x00,0x38,0x6C,0x38,0x76,0xDC,0xCC,0x76,0x00,0x60,0x60,0xC0,0x00,0x00,0x00,0x00,0x00,0x18,0x30,0x60,0x60,0x60,0x30,0x18,0x00,0x60,0x30,0x18,0x18,0x18,0x30,0x60,0x00,0x00,0x66,0x3C,0xFF,0x3C,0x66,0x00,0x00,0x00,0x30,0x30,0xFC,0x30,0x30,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x30,0x30,0x60,0x00,0x00,0x00,0xFC,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x30,0x30,0x00,0x06,0x0C,0x18,0x30,0x60,0xC0,0x80,0x00,0x7C,0xC6,0xCE,0xDE,0xF6,0xE6,0x7C,0x00,0x30,0x70,0x30,0x30,0x30,0x30,0xFC,0x00,0x78,0xCC,0x0C,0x38,0x60,0xC4,0xFC,0x00,0x78,0xCC,0x0C,0x38,0x0C,0xCC,0x78,0x00,0x1C,0x3C,0x6C,0xCC,0xFE,0x0C,0x1E,0x00,0xFC,0xC0,0xF8,0x0C,0x0C,0xCC,0x78,0x00,0x38,0x60,0xC0,0xF8,0xCC,0xCC,0x78,0x00,0xFC,0xCC,0x0C,0x18,0x30,0x30,0x30,0x00,0x78,0xCC,0xCC,0x78,0xCC,0xCC,0x78,0x00,0x78,0xCC,0xCC,0x7C,0x0C,0x18,0x70,0x00,0x00,0x30,0x30,0x00,0x00,0x30,0x30,0x00,0x00,0x30,0x30,0x00,0x30,0x30,0x60,0x00,0x18,0x30,0x60,0xC0,0x60,0x30,0x18,0x00,0x00,0x00,0xFC,0x00,0x00,0xFC,0x00,0x00,0x60,0x30,0x18,0x0C,0x18,0x30,0x60,0x00,0x78,0xCC,0x0C,0x18,0x30,0x00,0x30,0x00,0x7C,0xC6,0xDE,0xDE,0xDE,0xC0,0x78,0x00,0x30,0x78,0xCC,0xCC,0xFC,0xCC,0xCC,0x00,0xFC,0x66,0x66,0x7C,0x66,0x66,0xFC,0x00,0x3C,0x66,0xC0,0xC0,0xC0,0x66,0x3C,0x00,0xF8,0x6C,0x66,0x66,0x66,0x6C,0xF8,0x00,0xFE,0x62,0x68,0x78,0x68,0x62,0xFE,0x00,0xFE,0x62,0x68,0x78,0x68,0x60,0xF0,0x00,0x3C,0x66,0xC0,0xC0,0xCE,0x66,0x3E,0x00,0xCC,0xCC,0xCC,0xFC,0xCC,0xCC,0xCC,0x00,0x78,0x30,0x30,0x30,0x30,0x30,0x78,0x00,0x1E,0x0C,0x0C,0x0C,0xCC,0xCC,0x78,0x00,0xE6,0x66,0x6C,0x78,0x6C,0x66,0xE6,0x00,0xF0,0x60,0x60,0x60,0x62,0x66,0xFE,0x00,0xC6,0xEE,0xFE,0xFE,0xD6,0xC6,0xC6,0x00,0xC6,0xE6,0xF6,0xDE,0xCE,0xC6,0xC6,0x00,0x38,0x6C,0xC6,0xC6,0xC6,0x6C,0x38,0x00,0xFC,0x66,0x66,0x7C,0x60,0x60,0xF0,0x00,0x78,0xCC,0xCC,0xCC,0xDC,0x78,0x1C,0x00,0xFC,0x66,0x66,0x7C,0x6C,0x66,0xE6,0x00,0x78,0xCC,0xE0,0x70,0x1C,0xCC,0x78,0x00,0xFC,0xB4,0x30,0x30,0x30,0x30,0x78,0x00,0xCC,0xCC,0xCC,0xCC,0xCC,0xCC,0xFC,0x00,0xCC,0xCC,0xCC,0xCC,0xCC,0x78,0x30,0x00,0xC6,0xC6,0xC6,0xD6,0xFE,0xEE,0xC6,0x00,0xC6,0xC6,0x6C,0x38,0x38,0x6C,0xC6,0x00,0xCC,0xCC,0xCC,0x78,0x30,0x30,0x78,0x00,0xFE,0xC6,0x8C,0x18,0x32,0x66,0xFE,0x00,0x78,0x60,0x60,0x60,0x60,0x60,0x78,0x00,0xC0,0x60,0x30,0x18,0x0C,0x06,0x02,0x00,0x78,0x18,0x18,0x18,0x18,0x18,0x78,0x00,0x10,0x38,0x6C,0xC6,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF,0x30,0x30,0x18,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x78,0x0C,0x7C,0xCC,0x76,0x00,0xE0,0x60,0x60,0x7C,0x66,0x66,0xDC,0x00,0x00,0x00,0x78,0xCC,0xC0,0xCC,0x78,0x00,0x1C,0x0C,0x0C,0x7C,0xCC,0xCC,0x76,0x00,0x00,0x00,0x78,0xCC,0xFC,0xC0,0x78,0x00,0x38,0x6C,0x60,0xF0,0x60,0x60,0xF0,0x00,0x00,0x00,0x76,0xCC,0xCC,0x7C,0x0C,0xF8,0xE0,0x60,0x6C,0x76,0x66,0x66,0xE6,0x00,0x30,0x00,0x70,0x30,0x30,0x30,0x78,0x00,0x0C,0x00,0x0C,0x0C,0x0C,0xCC,0xCC,0x78,0xE0,0x60,0x66,0x6C,0x78,0x6C,0xE6,0x00,0x70,0x30,0x30,0x30,0x30,0x30,0x78,0x00,0x00,0x00,0xCC,0xFE,0xFE,0xD6,0xC6,0x00,0x00,0x00,0xF8,0xCC,0xCC,0xCC,0xCC,0x00,0x00,0x00,0x78,0xCC,0xCC,0xCC,0x78,0x00,0x00,0x00,0xDC,0x66,0x66,0x7C,0x60,0xF0,0x00,0x00,0x76,0xCC,0xCC,0x7C,0x0C,0x1E,0x00,0x00,0xDC,0x76,0x66,0x60,0xF0,0x00,0x00,0x00,0x7C,0xC0,0x78,0x0C,0xF8,0x00,0x10,0x30,0x7C,0x30,0x30,0x34,0x18,0x00,0x00,0x00,0xCC,0xCC,0xCC,0xCC,0x76,0x00,0x00,0x00,0xCC,0xCC,0xCC,0x78,0x30,0x00,0x00,0x00,0xC6,0xD6,0xFE,0xFE,0x6C,0x00,0x00,0x00,0xC6,0x6C,0x38,0x6C,0xC6,0x00,0x00,0x00,0xCC,0xCC,0xCC,0x7C,0x0C,0xF8,0x00,0x00,0xFC,0x98,0x30,0x64,0xFC,0x00,0x1C,0x30,0x30,0xE0,0x30,0x30,0x1C,0x00,0x18,0x18,0x18,0x00,0x18,0x18,0x18,0x00,0xE0,0x30,0x30,0x1C,0x30,0x30,0xE0,0x00,0x76,0xDC,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x10,0x38,0x6C,0xC6,0xC6,0xFE,0x00};



#define CHAR_A		NUMBER_OF_PATTERNS + 33
#define CHAR_0		NUMBER_OF_PATTERNS + 16