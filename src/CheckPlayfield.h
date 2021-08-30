
//#define POINTS_PER_BLOCK_REMOVED 	      10
//#define POINTS_PER_COMBO 	              5

// void CheckIfPlayfieldIsValid() {
//   bool found = FALSE;
//   for(byte line = 0; line < LINES_PLAYFIELD; line++) {
//     for(byte col = 0; col < COLS_PLAYFIELD; col++) {
//       for(byte item = 0; item < 5; item++) {
//         found = FALSE;
//       	if(playfieldTemp[col][line] == pieces[item] || playfieldTemp[col][line] == EMPTY) {
//           found = TRUE;
//           break;
//         }
//       }
//       if(!found) {
//         d_col = col;
//         d_line = line;
//         d_value = playfieldTemp[col][line];
        
//         while(1) { 
//           BEEP();
//         }
//       }
      
//     }
//   }
// }


void CheckPlayfield(byte iteration) {
  bool piecesRemoved = FALSE;
  
  // Save copy of playfield
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 0; col < COLS_PLAYFIELD; col++) {
      	playfieldTemp[col][line] = playfield[col][line];
    }
  }
  
  // Check lines
  for(byte line = 0; line < LINES_PLAYFIELD; line++) {
    for(byte col = 2; col < COLS_PLAYFIELD; col++) {
      if (playfieldTemp[col][line] != EMPTY &&
          playfieldTemp[col - 2][line] == playfieldTemp[col - 1][line] && 
          playfieldTemp[col - 1][line] == playfieldTemp[col][line]) {
        
        piecesRemoved = TRUE;
        
        // Set cells to removing status
        playfield[col - 2][line] = playfieldTemp[col - 2][line] | REMOVING_FLAG;
        playfield[col - 1][line] = playfieldTemp[col - 1][line] | REMOVING_FLAG;
        playfield[col][line] = 	   playfieldTemp[col][line] | REMOVING_FLAG;
      }
    }
  }

  // Check columns
  for(byte line = 2; line < LINES_PLAYFIELD; line++) {
    for(byte col = 0; col < COLS_PLAYFIELD; col++) {
      if (playfieldTemp[col][line] != EMPTY &&
          playfieldTemp[col][line - 2] == playfieldTemp[col][line - 1] && 
          playfieldTemp[col][line - 1] == playfieldTemp[col][line]) {
        
        piecesRemoved = TRUE;
        
        // Set cells to removing status
        playfield[col][line - 2] = playfieldTemp[col][line - 2] | REMOVING_FLAG;
        playfield[col][line - 1] = playfieldTemp[col][line - 1] | REMOVING_FLAG;
        playfield[col][line] = 	   playfieldTemp[col][line] | REMOVING_FLAG;
      }
    }
  }

  // Check diagonals
  for(byte line = 2; line < LINES_PLAYFIELD; line++) {
    for(byte col = 2; col < COLS_PLAYFIELD; col++) {
      if (playfieldTemp[col][line] != EMPTY &&
          playfieldTemp[col - 2][line - 2] == playfieldTemp[col - 1][line - 1] && 
          playfieldTemp[col - 1][line - 1] == playfieldTemp[col][line]) {
        
        piecesRemoved = TRUE;
        
        // Set cells to removing status
        playfield[col - 2][line - 2] = playfieldTemp[col - 2][line - 2] | REMOVING_FLAG;
        playfield[col - 1][line - 1] = playfieldTemp[col - 1][line - 1] | REMOVING_FLAG;
        playfield[col][line] = 	       playfieldTemp[col][line] | REMOVING_FLAG;
      }
      if (playfieldTemp[col][line - 2] != EMPTY &&
          playfieldTemp[col - 1][line - 1] == playfieldTemp[col - 2][line] && 
          playfieldTemp[col - 2][line] == playfieldTemp[col][line - 2]) {
        
        piecesRemoved = TRUE;
        
        // Set cells to removing status
        playfield[col][line - 2] =     playfieldTemp[col][line - 2] | REMOVING_FLAG;
        playfield[col - 1][line - 1] = playfieldTemp[col - 1][line - 1] | REMOVING_FLAG;
        playfield[col - 2][line] =     playfieldTemp[col - 2][line] | REMOVING_FLAG;
      }
    }
  }

  if(piecesRemoved) {
    byte numberPiecesRemoved;
    byte oldLevel;

    // Animation
    byte counter = 72;
    byte x = 255, y = 0;
    
    byte leftmostPieceRemoved = 5, rightmostPieceRemoved = 0;
    byte lowermostPieceRemoved = 11,   upmostPieceRemoved = 0;
    
    HideArrowSprite();
    
    SoundFx_2();
    
    // Count pieces removed
    numberPiecesRemoved = 0;
    for(byte line = 0; line < LINES_PLAYFIELD; line++) {
      for(byte col = 0; col < COLS_PLAYFIELD; col++) {
        if((playfield[col][line] & REMOVING_FLAG) != 0) {
          numberPiecesRemoved++;
          
          if(col < leftmostPieceRemoved) leftmostPieceRemoved = col;
          if(col > rightmostPieceRemoved) rightmostPieceRemoved = col;
          if(line < lowermostPieceRemoved) lowermostPieceRemoved = line;
          if(line > upmostPieceRemoved) upmostPieceRemoved = line;
        }
      }
    }
    
    // debug
    // DrawNumber(numberPiecesRemoved, 0, 0);//test
    // DrawNumber(iteration, 0, 1);//test
    // DrawNumber(leftmostPieceRemoved, 0, 13);//test
    // DrawNumber(rightmostPieceRemoved, 0, 14);//test
    // DrawNumber(lowermostPieceRemoved, 0, 16);//test
    // DrawNumber(upmostPieceRemoved, 0, 17);//test
    //Wait(60);
    
    while(counter-- > 0) {

      word lastJiffy = JIFFY;
      while (lastJiffy == JIFFY) {
      }
      // Animation loop sync'ed at 60/50 Hz starts here


      // "?x HIT" sprite logic
      if(numberPiecesRemoved >= 3) {

        if(numberPiecesRemoved >= 7) numberPiecesRemoved = 7;

        if(x == 255) { // do this expensive calculation only once
          x = (PLAYFIELD_HORIZ_OFFSET * 8) + (((rightmostPieceRemoved * 16) - (leftmostPieceRemoved * 16)) / 2) + (leftmostPieceRemoved * 16);
          //y = (((lowermostPieceRemoved * 16) - (upmostPieceRemoved * 16)) / 2) + (upmostPieceRemoved * 16) - (72 - counter);
          y = (((lowermostPieceRemoved * 16) - (upmostPieceRemoved * 16)) / 2) + (upmostPieceRemoved * 16);
          DrawHitSprite(numberPiecesRemoved, iteration, x, y, TRUE);
        }
        else {
          //y -= (72 - counter);
          // TODO: refactor here (line repeated; code expensive unnecessary)
          //y = (((lowermostPieceRemoved * 16) - (upmostPieceRemoved * 16)) / 2) + (upmostPieceRemoved * 16) - (72 - counter);
          DrawHitSprite(numberPiecesRemoved, iteration, x, y - (72 - counter), FALSE);
        }
      }

      for(byte line = 0; line < LINES_PLAYFIELD; line++) {
        for(byte col = 0; col < COLS_PLAYFIELD; col++) {

          if((playfield[col][line] & REMOVING_FLAG) != 0) {
            
    	      // Animation 1: blocks blinking
            if(counter > 12) {
              if(JIFFY & 0b00000011) {
                DrawBlock(col, line, playfield[col][line] & 0b01111111);
              }
              else {
                DrawBlock(col, line, EMPTY);
              }
            }
            else {
              // Animation 2: blocks turning into dust
              if(counter > 9) DrawBlock_SameTile(col, line, DUST_1);
              else if(counter > 6) DrawBlock_SameTile(col, line, DUST_1 + 1);
              else if(counter > 3) DrawBlock_SameTile(col, line, DUST_1 + 2);
              else DrawBlock_SameTile(col, line, DUST_1 + 3);
            }

          }
        }
      }
    }
    
    HideHitSprite();
    
    
    
    // After animation
    for(byte line = 0; line < LINES_PLAYFIELD; line++) {
      for(byte col = 0; col < COLS_PLAYFIELD; col++) {

        if((playfield[col][line] & REMOVING_FLAG) != 0) {
          
          blocksRemoved++;

          // Adjust the column above
          for(byte line1 = line; line1 > 0; line1--) {
            byte linesToBeRemoved = 1;
            if((playfield[col][line1 - 1] & REMOVING_FLAG) != 0) linesToBeRemoved++;
            if((playfield[col][line1 - 2] & REMOVING_FLAG) != 0) linesToBeRemoved++;
            
            //playfield[col][line1] = playfieldTemp[col][line1 - linesToBeRemoved];
            //playfield[col][line1] = playfield[col][(line1 - linesToBeRemoved >= 0) ? line1 - linesToBeRemoved : 0];
            playfield[col][line1] = (line1 - linesToBeRemoved >= 0) ? playfield[col][line1 - linesToBeRemoved] : EMPTY;
          }
        }
      }
    }

    // Wait(60);
    //score = score + numberPiecesRemoved + POINTS_PER_COMBO; // causing slowdown
    //score++;                                                  // works fine

    // Level logic
    oldLevel = level;
    if(blocksRemoved >= 90) {
      level = (blocksRemoved / 30) + 1;
      speed = 15;
      //DrawNumber(speed, 0, 0); // test
    }
    else if(blocksRemoved >= 60) { 
      level = 3;
      speed = 30;
    }
    else if(blocksRemoved >= 30) { 
      level = 2;
      speed = 45;
    }
    else { 
      level = 1;
      speed = 60;
    }
    
    if(oldLevel != level) {
      newLevel = TRUE;
    }
    
    
    DrawPlayfield();
    
    //Wait(90);
    
    //CheckIfPlayfieldIsValid(); // test
    
    DrawScore();

    iteration++;
    CheckPlayfield(iteration);  
  }
  else {
    //SoundFx_1();
    DrawScore();
  }
}

