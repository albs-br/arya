void Wait(word numberOfFrames) {
  do {
    word lastJiffy = JIFFY;
    while (lastJiffy == JIFFY) {
    }
  }
  while (numberOfFrames-- > 0);
}

