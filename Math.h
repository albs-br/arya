word Power(byte base, byte expoent) {
  word power = base;

  if (expoent == 0) return 1;

  for(byte j = 1; j < expoent; j++) {
    power = power * base;
  }
  
  return power;
}
