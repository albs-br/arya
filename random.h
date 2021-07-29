// From: https://www.electro-tech-online.com/threads/ultra-fast-pseudorandom-number-generator-for-8-bit.124249/


//X ABC Algorithm Random Number Generator for 8-Bit Devices:
//This is a small PRNG, experimentally verified to have at least a 50 million byte period
//by generating 50 million bytes and observing that there were no overapping sequences and repeats.
//This generator passes serial correlation, entropy , Monte Carlo Pi value, arithmetic mean,
//And many other statistical tests. This generator may have a period of up to 2^32, but this has
//not been verified.
//
// By XORing 3 bytes into the a,b, and c registers, you can add in entropy from 
//an external source easily.
//
//This generator is free to use, but is not suitable for cryptography due to its short period(by //cryptographic standards) and simple construction. No attempt was made to make this generator 
// suitable for cryptographic use.
//
//Due to the use of a constant counter, the generator should be resistant to latching up.
//A significant performance gain is had in that the x variable is nly ever incremented.
//
//Only 4 bytes of ram are needed for the internal state, and generating a byte requires 3 XORs , //2 ADDs, one bit shift right , and one increment. Difficult or slow operations like multiply, etc 
//were avoided for maximum speed on ultra low power devices.


char a, b, c, x;


//Can also be used to seed the rng with more entropy during use.
void InitRnd(char s1, char s2, char s3) {
  //XOR new entropy into key state
  a ^= s1;
  b ^= s2;
  c ^= s3;

  x++;
  a = (a^c^x);
  b = (b+a);
  c = (c+(b>>1)^a);
}

unsigned char Randomize() {
  x++;               //x is incremented every round and is not affected by any other variable
  a = (a^c^x);       //note the mix of addition and XOR
  b = (b+a);         //And the use of very few instructions
  c = (c+(b>>1)^a);  //the right shift is to ensure that high-order bits from b can affect  

  return(c);          //low order bits of other variables
}
