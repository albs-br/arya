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

void AnimateSprites(byte x, byte y, byte pattern) {
    // top left
    WRTVRM(SPRATT, 	    y); //96-16);
    WRTVRM(SPRATT + 1, 	256-x-16); //128-16);
    WRTVRM(SPRATT + 2, 	pattern);
    WRTVRM(SPRATT + 3, 	10);

    // top right
    WRTVRM(SPRATT + 4, 	y); //96-16);
    WRTVRM(SPRATT + 5, 	x);
    WRTVRM(SPRATT + 6,  pattern + 4);
    WRTVRM(SPRATT + 7,  10);

    // bottom left
    WRTVRM(SPRATT + 8, 	192-y-16); //96);
    WRTVRM(SPRATT + 9, 	256-x-16);
    WRTVRM(SPRATT + 10,	pattern + 8);
    WRTVRM(SPRATT + 11,	10);

    // bottom right
    WRTVRM(SPRATT + 12,	192-y-16); //96);
    WRTVRM(SPRATT + 13,	x);
    WRTVRM(SPRATT + 14,	pattern + 12);
    WRTVRM(SPRATT + 15,	10);
}

void BlinkNumber(byte colorIndex) {
   
    // Blinking number
    WRTVRM(SPRATT + 3, 	colors[colorIndex]);
    WRTVRM(SPRATT + 7, 	colors[colorIndex]);
    WRTVRM(SPRATT + 11,	colors[colorIndex]);
    WRTVRM(SPRATT + 15, colors[colorIndex]);    
}

void ShowCountdown() {
    byte counter = 0;
    byte x = 128-80, y = 0, colorIndex = 0;
    
    while(counter++ < 240) {

        /*
        numFrames = 32
        xFinal = 128
        xInitial = 0
        step = 4
        */


        word lastJiffy = JIFFY;
        while (lastJiffy == JIFFY) {
        }
        // Animation loop sync'ed at 60/50 Hz starts here

        if(counter < 30) {
            colorIndex = 0;

            AnimateSprites(x, y, SPRITE_PATTERN_NUMBER_3_32X32);

            if(x < 128) x += 4;
            if(y < 80) y += 4;
        }
        else if(counter >= 60 && counter < 90) {
            colorIndex = 0;

            AnimateSprites(x, y, SPRITE_PATTERN_NUMBER_2_32X32);

            if(x < 128) x += 4;
            if(y < 80) y += 4;
        }
        else if(counter >= 120 && counter < 150) {
            colorIndex = 0;

            AnimateSprites(x, y, SPRITE_PATTERN_NUMBER_1_32X32);

            if(x < 128) x += 4;
            if(y < 80) y += 4;
        }
        else if(counter >= 180 && counter < 210) {
            colorIndex = 0;

            AnimateSprites(x, y, SPRITE_PATTERN_GO_32X32);

            if(x < 128) x += 4;
            if(y < 80) y += 4;
        }
        else {
            x = 128-80;
            y = 0;

            BlinkNumber(colorIndex);

            colorIndex++;
            if(colorIndex >= sizeof(colors)) colorIndex = 0;
        }    
    }

    // Hiding all sprites
    WRTVRM(SPRATT, 	        192);
    WRTVRM(SPRATT + 4, 	    192);
    WRTVRM(SPRATT + 8, 	    192);
    WRTVRM(SPRATT + 12,	    192);
}