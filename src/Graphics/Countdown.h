void ShowCountdown() {
    byte counter = 60;
    byte x = 128-80, y = 0;

    while(counter-- > 0) {

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

        // top left
        WRTVRM(SPRATT, 	y); //96-16);
        WRTVRM(SPRATT + 1, 	256-x-16); //128-16);
        WRTVRM(SPRATT + 2, 	SPRITE_PATTERN_NUMBER_3_32X32);
        WRTVRM(SPRATT + 3, 	10);

        // top right
        WRTVRM(SPRATT + 4, 	y); //96-16);
        WRTVRM(SPRATT + 5, 	x);
        WRTVRM(SPRATT + 6, SPRITE_PATTERN_NUMBER_3_32X32 + 4);
        WRTVRM(SPRATT + 7, 10);

        // bottom left
        WRTVRM(SPRATT + 8, 	192-y-16); //96);
        WRTVRM(SPRATT + 9, 	256-x-16);
        WRTVRM(SPRATT + 10,	SPRITE_PATTERN_NUMBER_3_32X32 + 8);
        WRTVRM(SPRATT + 11,	10);

        // bottom right
        WRTVRM(SPRATT + 12,	192-y-16); //96);
        WRTVRM(SPRATT + 13,	x);
        WRTVRM(SPRATT + 14,	SPRITE_PATTERN_NUMBER_3_32X32 + 12);
        WRTVRM(SPRATT + 15,	10);

        if(x < 128) x += 4;
        if(y < 80) y += 4;
    }
    //Wait(180);

    while(1) {}
}