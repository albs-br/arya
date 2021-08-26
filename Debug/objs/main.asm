;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _TitleScreen
	.globl _SetBlock
	.globl _Intro
	.globl _ScrollDownFont
	.globl _ChangeFontColor
	.globl _InitGame
	.globl _TestCase
	.globl _GameLoop
	.globl _Pause
	.globl _BlinkPauseText
	.globl _UpdateAndDrawPieceStatic
	.globl _RandomPiece
	.globl _RandomIndex
	.globl _CheckPlayfield
	.globl _CheckIfPlayfieldIsValid
	.globl _SoundFx_1
	.globl _SoundFx_2
	.globl _DrawPlayfield
	.globl _DrawPiece
	.globl _DrawLine
	.globl _DrawBlock_SameTile
	.globl _DrawBlock
	.globl _InitVRAM
	.globl _HideHitSprite
	.globl _DrawHitSprite
	.globl _HideArrow
	.globl _DrawArrow
	.globl _DrawBackground
	.globl _DrawScore
	.globl _DrawColumn
	.globl _DrawNumber
	.globl _DrawString
	.globl _DrawChar
	.globl _GetRandomInInterval
	.globl _GetRandom
	.globl _InitRnd
	.globl _Power
	.globl _Wait
	.globl _SNSMAT
	.globl _GTTRIG
	.globl _GTSTCK
	.globl _BEEP
	.globl _WRTPSG
	.globl _GICINI
	.globl _INIGRP
	.globl _LDIRVM
	.globl _FILVRM
	.globl _WRTVRM
	.globl _RDVRM
	.globl _WRTVDP
	.globl _ENASCR
	.globl _DISSCR
	.globl _d_value
	.globl _d_line
	.globl _d_col
	.globl _rndSeed
	.globl _newLevel
	.globl _level
	.globl _blocksRemoved
	.globl _counter
	.globl _line
	.globl _col
	.globl _gameOver
	.globl _Rand_x
	.globl _Rand_c
	.globl _Rand_b
	.globl _Rand_a
	.globl _speed
	.globl _bottomPiece
	.globl _midPiece
	.globl _topPiece
	.globl _playfieldTemp
	.globl _playfield
	.globl _GETPNT
	.globl _PUTPNT
	.globl _REPCNT
	.globl _SCNCNT
	.globl _ATRBYT
	.globl _CMASK
	.globl _CLOC
	.globl _BDRCLR
	.globl _BAKCLR
	.globl _FORCLR
	.globl _TRGFLG
	.globl _STATFL
	.globl _MSX_vdp_regs
	.globl _CNSDFG
	.globl _CSRX
	.globl _CSRY
	.globl _MSX_modedata_screen3
	.globl _MSX_modedata_screen2
	.globl _MSX_modedata_screen1
	.globl _MSX_modedata_screen0
	.globl _CLIKSW
	.globl _JIFFY
	.globl _CLMLST
	.globl _CRTCNT
	.globl _LINLEN
	.globl _LINL32
	.globl _LINL40
	.globl _MSX_charset
	.globl _FONT
	.globl _pieces
	.globl _MSX_version
	.globl _MSX_vdp_port_write
	.globl _MSX_vdp_port_read
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_MSX_charset	=	0x0004
_LINL40	=	0xf3ae
_LINL32	=	0xf3af
_LINLEN	=	0xf3b0
_CRTCNT	=	0xf3b1
_CLMLST	=	0xf3b1
_JIFFY	=	0xfc9e
_CLIKSW	=	0xf3db
_MSX_modedata_screen0	=	0xf3b3
_MSX_modedata_screen1	=	0xf3bd
_MSX_modedata_screen2	=	0xf3c7
_MSX_modedata_screen3	=	0xf3d1
_CSRY	=	0xf3dc
_CSRX	=	0xf3dd
_CNSDFG	=	0xf3de
_MSX_vdp_regs	=	0xf3df
_STATFL	=	0xf3e7
_TRGFLG	=	0xf3e8
_FORCLR	=	0xf3e9
_BAKCLR	=	0xf3ea
_BDRCLR	=	0xf3eb
_CLOC	=	0xf92a
_CMASK	=	0xf92c
_ATRBYT	=	0xf3f2
_SCNCNT	=	0xf3f6
_REPCNT	=	0xf3f7
_PUTPNT	=	0xf3f8
_GETPNT	=	0xf3fa
_playfield::
	.ds 72
_playfieldTemp::
	.ds 72
_topPiece::
	.ds 1
_midPiece::
	.ds 1
_bottomPiece::
	.ds 1
_speed::
	.ds 1
_Rand_a::
	.ds 1
_Rand_b::
	.ds 1
_Rand_c::
	.ds 1
_Rand_x::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_gameOver::
	.ds 1
_col::
	.ds 1
_line::
	.ds 1
_counter::
	.ds 1
_blocksRemoved::
	.ds 2
_level::
	.ds 1
_newLevel::
	.ds 1
_rndSeed::
	.ds 1
_d_col::
	.ds 1
_d_line::
	.ds 1
_d_value::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src\/Common.h:1: void Wait(word numberOfFrames) {
;	---------------------------------
; Function Wait
; ---------------------------------
_Wait::
;src\/Common.h:2: do {
	pop	de
	pop	bc
	push	bc
	push	de
00104$:
;src\/Common.h:3: word lastJiffy = JIFFY;
	ld	de, (_JIFFY)
;src\/Common.h:4: while (lastJiffy == JIFFY) {
00101$:
	ld	hl, (_JIFFY)
	cp	a, a
	sbc	hl, de
	jr	Z, 00101$
;src\/Common.h:7: while (numberOfFrames-- > 0);
	ld	e, c
	ld	d, b
	dec	bc
	ld	a, d
	or	a, e
	jr	NZ, 00104$
;src\/Common.h:8: }
	ret
_MSX_vdp_port_read	=	0x0006
_MSX_vdp_port_write	=	0x0007
_MSX_version	=	0x002d
_pieces:
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x0c	; 12
	.db #0x10	; 16
	.db #0x14	; 20
;src\/Math.h:1: word Power(byte base, byte expoent) {
;	---------------------------------
; Function Power
; ---------------------------------
_Power::
	push	ix
	ld	ix,#0
	add	ix,sp
;src\/Math.h:2: word power = base;
	ld	c, 4 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
;src\/Math.h:4: if (expoent == 0) return 1;
	ld	a, 5 (ix)
	or	a, a
	jr	NZ, 00111$
	ld	hl, #0x0001
	jr	00107$
;src\/Math.h:6: for(byte j = 1; j < expoent; j++) {
00111$:
	ld	e, #0x01
00105$:
	ld	a, e
	sub	a, 5 (ix)
	jr	NC, 00103$
;src\/Math.h:7: power = power * base;
	push	bc
	push	de
	push	bc
	push	hl
	call	__mulint
	pop	af
	pop	af
	pop	de
	pop	bc
;src\/Math.h:6: for(byte j = 1; j < expoent; j++) {
	inc	e
	jr	00105$
00103$:
;src\/Math.h:10: return power;
00107$:
;src\/Math.h:11: }
	pop	ix
	ret
;src\/Random.h:28: void InitRnd(char s1, char s2, char s3) {
;	---------------------------------
; Function InitRnd
; ---------------------------------
_InitRnd::
;src\/Random.h:30: Rand_a ^= s1;
	ld	a,(#_Rand_a + 0)
	ld	hl, #2
	add	hl, sp
	xor	a, (hl)
	ld	(_Rand_a+0), a
;src\/Random.h:31: Rand_b ^= s2;
	ld	a,(#_Rand_b + 0)
	ld	hl, #3
	add	hl, sp
	xor	a, (hl)
	ld	(_Rand_b+0), a
;src\/Random.h:32: Rand_c ^= s3;
	ld	a,(#_Rand_c + 0)
	ld	hl, #4
	add	hl, sp
	xor	a, (hl)
	ld	(_Rand_c+0), a
;src\/Random.h:34: Rand_x++;
	ld	hl, #_Rand_x
	inc	(hl)
;src\/Random.h:35: Rand_a = (Rand_a ^ Rand_c ^ Rand_x);
	ld	a,(#_Rand_a + 0)
	ld	hl, #_Rand_c
	xor	a, (hl)
	ld	hl, #_Rand_x
	xor	a, (hl)
	ld	(_Rand_a+0), a
;src\/Random.h:36: Rand_b = (Rand_b + Rand_a);
	ld	hl, #_Rand_b
	ld	a, (hl)
	ld	iy, #_Rand_a
	add	a, 0 (iy)
	ld	(hl), a
;src\/Random.h:37: Rand_c = (Rand_c + (Rand_b >> 1) ^ Rand_a);
	ld	a,(#_Rand_b + 0)
	srl	a
	ld	hl, #_Rand_c
	add	a, (hl)
	ld	iy, #_Rand_a
	xor	a, 0 (iy)
	ld	(_Rand_c+0), a
;src\/Random.h:38: }
	ret
;src\/Random.h:40: unsigned char GetRandom() {
;	---------------------------------
; Function GetRandom
; ---------------------------------
_GetRandom::
;src\/Random.h:41: Rand_x++;               			//x is incremented every round and is not affected by any other variable
	ld	hl, #_Rand_x
	inc	(hl)
;src\/Random.h:42: Rand_a = (Rand_a ^ Rand_c ^ Rand_x);       	//note the mix of addition and XOR
	ld	a,(#_Rand_a + 0)
	ld	hl, #_Rand_c
	xor	a, (hl)
	ld	hl, #_Rand_x
	xor	a, (hl)
	ld	(_Rand_a+0), a
;src\/Random.h:43: Rand_b = (Rand_b + Rand_a);         		//And the use of very few instructions
	ld	hl, #_Rand_b
	ld	a, (hl)
	ld	iy, #_Rand_a
	add	a, 0 (iy)
	ld	(hl), a
;src\/Random.h:44: Rand_c = (Rand_c + (Rand_b >> 1) ^ Rand_a);  	//the right shift is to ensure that high-order bits from b can affect  
	ld	a,(#_Rand_b + 0)
	srl	a
	ld	hl, #_Rand_c
	add	a, (hl)
	ld	iy, #_Rand_a
	xor	a, 0 (iy)
	ld	(_Rand_c+0), a
;src\/Random.h:46: return (Rand_c);          //low order bits of other variables
	ld	a, (#_Rand_c + 0)
	ld	l, a
;src\/Random.h:47: }
	ret
;src\/Random.h:51: byte GetRandomInInterval(byte max, byte mask) {
;	---------------------------------
; Function GetRandomInInterval
; ---------------------------------
_GetRandomInInterval::
;src\/Random.h:53: do {
00101$:
;src\/Random.h:54: random = GetRandom() & mask; // AND mask to get a value in the range passed by mask. E.g. 0b00000011, range 0-3
	call	_GetRandom
	ld	a, l
	ld	hl, #3
	add	hl, sp
	and	a, (hl)
	ld	c, a
;src\/Random.h:56: while(random > max); // Get a number between 0 and max
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	sub	a, c
	jr	C, 00101$
;src\/Random.h:58: return random;
	ld	l, c
;src\/Random.h:59: }
	ret
;src\/Graphics.h:4: void DrawChar(byte character, byte col, byte line) {
;	---------------------------------
; Function DrawChar
; ---------------------------------
_DrawChar::
	push	ix
	ld	ix,#0
	add	ix,sp
;src\/Graphics.h:5: WRTVRM(MSX_modedata_screen2.name + (line * 32) + col, character);
	ld	bc, (#_MSX_modedata_screen2 + 0)
	ld	l, 6 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, 5 (ix)
	ld	b, #0x00
	add	hl, bc
	ld	a, 4 (ix)
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
;src\/Graphics.h:6: }
	pop	ix
	ret
_FONT:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0xfe	; 254
	.db #0x6c	; 108	'l'
	.db #0xfe	; 254
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x7c	; 124
	.db #0xc0	; 192
	.db #0x78	; 120	'x'
	.db #0x0c	; 12
	.db #0xf8	; 248
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0xcc	; 204
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x66	; 102	'f'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x6c	; 108	'l'
	.db #0x38	; 56	'8'
	.db #0x76	; 118	'v'
	.db #0xdc	; 220
	.db #0xcc	; 204
	.db #0x76	; 118	'v'
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xfc	; 252
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0xc6	; 198
	.db #0xce	; 206
	.db #0xde	; 222
	.db #0xf6	; 246
	.db #0xe6	; 230
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0x0c	; 12
	.db #0x38	; 56	'8'
	.db #0x60	; 96
	.db #0xc4	; 196
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0x0c	; 12
	.db #0x38	; 56	'8'
	.db #0x0c	; 12
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x3c	; 60
	.db #0x6c	; 108	'l'
	.db #0xcc	; 204
	.db #0xfe	; 254
	.db #0x0c	; 12
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xc0	; 192
	.db #0xf8	; 248
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0xf8	; 248
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xcc	; 204
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x7c	; 124
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0xc6	; 198
	.db #0xde	; 222
	.db #0xde	; 222
	.db #0xde	; 222
	.db #0xc0	; 192
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xfc	; 252
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x7c	; 124
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x66	; 102	'f'
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x6c	; 108	'l'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x6c	; 108	'l'
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x62	; 98	'b'
	.db #0x68	; 104	'h'
	.db #0x78	; 120	'x'
	.db #0x68	; 104	'h'
	.db #0x62	; 98	'b'
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x62	; 98	'b'
	.db #0x68	; 104	'h'
	.db #0x78	; 120	'x'
	.db #0x68	; 104	'h'
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xce	; 206
	.db #0x66	; 102	'f'
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xfc	; 252
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x66	; 102	'f'
	.db #0x6c	; 108	'l'
	.db #0x78	; 120	'x'
	.db #0x6c	; 108	'l'
	.db #0x66	; 102	'f'
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x62	; 98	'b'
	.db #0x66	; 102	'f'
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0xee	; 238
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xd6	; 214
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0xe6	; 230
	.db #0xf6	; 246
	.db #0xde	; 222
	.db #0xce	; 206
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x6c	; 108	'l'
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0x6c	; 108	'l'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x7c	; 124
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xdc	; 220
	.db #0x78	; 120	'x'
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x7c	; 124
	.db #0x6c	; 108	'l'
	.db #0x66	; 102	'f'
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0xe0	; 224
	.db #0x70	; 112	'p'
	.db #0x1c	; 28
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xb4	; 180
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0xd6	; 214
	.db #0xfe	; 254
	.db #0xee	; 238
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0x6c	; 108	'l'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x6c	; 108	'l'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xc6	; 198
	.db #0x8c	; 140
	.db #0x18	; 24
	.db #0x32	; 50	'2'
	.db #0x66	; 102	'f'
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x0c	; 12
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x6c	; 108	'l'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x0c	; 12
	.db #0x7c	; 124
	.db #0xcc	; 204
	.db #0x76	; 118	'v'
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7c	; 124
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0xdc	; 220
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0xc0	; 192
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x7c	; 124
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x76	; 118	'v'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0xfc	; 252
	.db #0xc0	; 192
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x6c	; 108	'l'
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x76	; 118	'v'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x7c	; 124
	.db #0x0c	; 12
	.db #0xf8	; 248
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0x6c	; 108	'l'
	.db #0x76	; 118	'v'
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0x66	; 102	'f'
	.db #0x6c	; 108	'l'
	.db #0x78	; 120	'x'
	.db #0x6c	; 108	'l'
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xd6	; 214
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xdc	; 220
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x7c	; 124
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x76	; 118	'v'
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x7c	; 124
	.db #0x0c	; 12
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xdc	; 220
	.db #0x76	; 118	'v'
	.db #0x66	; 102	'f'
	.db #0x60	; 96
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0xc0	; 192
	.db #0x78	; 120	'x'
	.db #0x0c	; 12
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x7c	; 124
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x34	; 52	'4'
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x76	; 118	'v'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x78	; 120	'x'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0xd6	; 214
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0x6c	; 108	'l'
	.db #0x38	; 56	'8'
	.db #0x6c	; 108	'l'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0x7c	; 124
	.db #0x0c	; 12
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x98	; 152
	.db #0x30	; 48	'0'
	.db #0x64	; 100	'd'
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xe0	; 224
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x1c	; 28
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x76	; 118	'v'
	.db #0xdc	; 220
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x6c	; 108	'l'
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0xfe	; 254
	.db #0x00	; 0
_pattern_black_0:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
_pattern_black_1:
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
_pattern_black_2:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0xff	; 255
	.db #0xbb	; 187
_pattern_black_3:
	.db #0xfb	; 251
	.db #0xfe	; 254
	.db #0xfd	; 253
	.db #0xfe	; 254
	.db #0xf7	; 247
	.db #0xfa	; 250
	.db #0xaf	; 175
	.db #0x55	; 85	'U'
_pattern_0:
	.db #0x9f	; 159
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x93	; 147
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x92	; 146
_pattern_1:
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xf9	; 249
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x49	; 73	'I'
	.db #0x49	; 73	'I'
_pattern_2:
	.db #0x92	; 146
	.db #0x93	; 147
	.db #0x90	; 144
	.db #0x90	; 144
	.db #0x9f	; 159
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
_pattern_3:
	.db #0x49	; 73	'I'
	.db #0xc9	; 201
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0xf9	; 249
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
_pattern_4:
	.db #0x7f	; 127
	.db #0x81	; 129
	.db #0x83	; 131
	.db #0x87	; 135
	.db #0x8f	; 143
	.db #0x9f	; 159
	.db #0xbf	; 191
	.db #0xff	; 255
_pattern_5:
	.db #0xfe	; 254
	.db #0x81	; 129
	.db #0xc1	; 193
	.db #0xe1	; 225
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xfd	; 253
	.db #0xff	; 255
_pattern_6:
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0x9f	; 159
	.db #0x8f	; 143
	.db #0x87	; 135
	.db #0x83	; 131
	.db #0x81	; 129
	.db #0x7f	; 127
_pattern_7:
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0xc1	; 193
	.db #0x81	; 129
	.db #0xfe	; 254
_pattern_8:
	.db #0x7f	; 127
	.db #0xae	; 174
	.db #0xff	; 255
	.db #0x5b	; 91
	.db #0xff	; 255
	.db #0xae	; 174
	.db #0xff	; 255
	.db #0xdf	; 223
_pattern_9:
	.db #0xfe	; 254
	.db #0xbd	; 189
	.db #0xdf	; 223
	.db #0x7f	; 127
	.db #0xfb	; 251
	.db #0xdf	; 223
	.db #0xfe	; 254
	.db #0xef	; 239
_pattern_10:
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xed	; 237
	.db #0xff	; 255
	.db #0xb6	; 182
	.db #0xfe	; 254
	.db #0xdb	; 219
	.db #0x7d	; 125
_pattern_11:
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x77	; 119	'w'
	.db #0xfe	; 254
	.db #0xdd	; 221
	.db #0xef	; 239
	.db #0x5a	; 90	'Z'
_pattern_12:
	.db #0x7f	; 127
	.db #0xd5	; 213
	.db #0xbf	; 191
	.db #0xed	; 237
	.db #0xbf	; 191
	.db #0xf5	; 245
	.db #0xbf	; 191
	.db #0xff	; 255
_pattern_13:
	.db #0xfe	; 254
	.db #0x5f	; 95
	.db #0xf5	; 245
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
_pattern_14:
	.db #0xef	; 239
	.db #0xbf	; 191
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdb	; 219
	.db #0x7f	; 127
_pattern_15:
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0xdb	; 219
	.db #0xfd	; 253
	.db #0x7b	; 123
	.db #0xd7	; 215
	.db #0xfe	; 254
_pattern_16:
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0xdf	; 223
_pattern_17:
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xfa	; 250
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0xff	; 255
	.db #0xfa	; 250
_pattern_18:
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xff	; 255
	.db #0x55	; 85	'U'
_pattern_19:
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0xff	; 255
	.db #0xfa	; 250
	.db #0xf7	; 247
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x56	; 86	'V'
_pattern_20:
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0xce	; 206
	.db #0xe6	; 230
	.db #0x7c	; 124
	.db #0x39	; 57	'9'
	.db #0x03	; 3
_pattern_21:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0xdb	; 219
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
_pattern_22:
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0x07	; 7
	.db #0x73	; 115	's'
	.db #0x67	; 103	'g'
	.db #0x3e	; 62
	.db #0x9c	; 156
	.db #0xc0	; 192
_pattern_23:
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
_pattern_24:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x44	; 68	'D'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
_pattern_25:
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
_pattern_26:
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
_pattern_27:
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
_pattern_28:
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
_pattern_29:
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
_pattern_30:
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
_pattern_31:
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
_pattern_37:
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x06	; 6
_pattern_38:
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x55	; 85	'U'
	.db #0x44	; 68	'D'
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x00	; 0
_pattern_39:
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x60	; 96
_pattern_32:
	.db #0x03	; 3
	.db #0x39	; 57	'9'
	.db #0x7c	; 124
	.db #0xe6	; 230
	.db #0xce	; 206
	.db #0xe0	; 224
	.db #0x7f	; 127
	.db #0x3f	; 63
_pattern_33:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0xdb	; 219
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
_pattern_34:
	.db #0xc0	; 192
	.db #0x9c	; 156
	.db #0x3e	; 62
	.db #0x67	; 103	'g'
	.db #0x73	; 115	's'
	.db #0x07	; 7
	.db #0xfe	; 254
	.db #0xfc	; 252
_sprite_dust_0:
	.db #0x10	; 16
	.db #0x42	; 66	'B'
	.db #0x10	; 16
	.db #0x45	; 69	'E'
	.db #0x20	; 32
	.db #0x89	; 137
	.db #0x20	; 32
	.db #0x88	; 136
_sprite_dust_1:
	.db #0x10	; 16
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x20	; 32
	.db #0x81	; 129
	.db #0x20	; 32
	.db #0x08	; 8
_sprite_dust_2:
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x20	; 32
	.db #0x80	; 128
	.db #0x20	; 32
	.db #0x00	; 0
_sprite_dust_3:
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
_pattern_title:
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
_color_black_0:
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
_color_black_1:
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
_color_black_2:
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
_color_black_3:
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x14	; 20
_color_0:
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
_color_1:
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
_color_2:
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
_color_3:
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
_color_4:
	.db #0x96	; 150
	.db #0x96	; 150
	.db #0x96	; 150
	.db #0x96	; 150
	.db #0x96	; 150
	.db #0x96	; 150
	.db #0x96	; 150
	.db #0x96	; 150
_color_5:
	.db #0x98	; 152
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
_color_6:
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
_color_7:
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x86	; 134
_color_8:
	.db #0x41	; 65	'A'
	.db #0x47	; 71	'G'
	.db #0x47	; 71	'G'
	.db #0x47	; 71	'G'
	.db #0x47	; 71	'G'
	.db #0x47	; 71	'G'
	.db #0x47	; 71	'G'
	.db #0x47	; 71	'G'
_color_9:
	.db #0x41	; 65	'A'
	.db #0x45	; 69	'E'
	.db #0x47	; 71	'G'
	.db #0x47	; 71	'G'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x41	; 65	'A'
	.db #0x45	; 69	'E'
_color_10:
	.db #0x47	; 71	'G'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x45	; 69	'E'
	.db #0x41	; 65	'A'
	.db #0x45	; 69	'E'
	.db #0x41	; 65	'A'
_color_11:
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
_color_12:
	.db #0xd1	; 209
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
_color_13:
	.db #0xd1	; 209
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
_color_14:
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
_color_15:
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
_color_16:
	.db #0xa1	; 161
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xbf	; 191
_color_17:
	.db #0xa1	; 161
	.db #0xaf	; 175
	.db #0xaf	; 175
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
_color_18:
	.db #0xaf	; 175
	.db #0xaf	; 175
	.db #0xaf	; 175
	.db #0xaf	; 175
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
_color_19:
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
_color_column_1:
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
_color_column_2:
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
_color_column_3:
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
_color_column_4:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
_color_column_5:
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
_color_column_6:
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
_color_column_7:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
_color_column_8:
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
_color_column_9:
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0xf1	; 241
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
_color_column_10:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
_color_column_11:
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
_color_column_12:
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
_color_column_16:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
_color_column_17:
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
_color_column_18:
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
_color_column_13:
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xf1	; 241
_color_column_14:
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xf1	; 241
_color_column_15:
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0xf1	; 241
_color_dust_0:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
_color_dust_1:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
_color_dust_2:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
_color_dust_3:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
_color_font_1:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x41	; 65	'A'
_color_font_2:
	.db #0x61	; 97	'a'
	.db #0x61	; 97	'a'
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x91	; 145
	.db #0x91	; 145
	.db #0xe1	; 225
	.db #0xe1	; 225
_color_title_1:
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
	.db #0xa1	; 161
_color_title_2:
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
_color_title_3:
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
	.db #0xd1	; 209
_color_title_4:
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
_color_title_5:
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
	.db #0x71	; 113	'q'
_color_title_6:
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
	.db #0x51	; 81	'Q'
_color_title_7:
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
_sprite_arrow_0:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_sprite_arrow_1:
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
_sprite_arrow_2:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_sprite_arrow_3:
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
_sprite_3x_hit_1:
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x63	; 99	'c'
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x1e	; 30
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x63	; 99	'c'
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x36	; 54	'6'
	.db #0x1c	; 28
	.db #0x08	; 8
	.db #0x1c	; 28
	.db #0x36	; 54	'6'
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_sprite_3x_hit_2:
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x25	; 37
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x73	; 115	's'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_sprite_3x_hit_3:
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
;src\/Graphics.h:8: void DrawString(const char* str, byte col, byte line) {
;	---------------------------------
; Function DrawString
; ---------------------------------
_DrawString::
	push	ix
	ld	ix,#0
	add	ix,sp
;src\/Graphics.h:9: while (*str) {
	ld	l, 6 (ix)
	ld	c, 4 (ix)
	ld	b, 5 (ix)
00101$:
	ld	a, (bc)
	or	a, a
	jr	Z, 00104$
;src\/Graphics.h:10: DrawChar((*str++) - (65 - CHAR_A), col++, line);
	ld	d, l
	inc	l
	ld	6 (ix), l
	inc	bc
	add	a, #0x0f
	push	hl
	push	bc
	ld	h, 7 (ix)
	ld	l, d
	push	hl
	push	af
	inc	sp
	call	_DrawChar
	pop	af
	inc	sp
	pop	bc
	pop	hl
	jr	00101$
00104$:
;src\/Graphics.h:12: }
	pop	ix
	ret
;src\/Graphics.h:14: void DrawNumber(word number, byte col, byte line) {
;	---------------------------------
; Function DrawNumber
; ---------------------------------
_DrawNumber::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:17: bool trailingZero = TRUE;
	ld	-6 (ix), #0x01
;src\/Graphics.h:19: DrawString("      ", col, line); // Clear space for number (6 digits)
	ld	h, 7 (ix)
	ld	l, 6 (ix)
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_DrawString
	pop	af
	pop	af
;src\/Graphics.h:21: for(byte i = 6; i > 0; i--) { //  (6 digits)
	ld	a, 6 (ix)
	ld	-1 (ix), a
	ld	e, #0x06
00109$:
	ld	a, e
	or	a, a
	jp	Z, 00111$
;src\/Graphics.h:23: power = Power(10, i - 1);
	ld	a, e
	dec	a
	push	de
	ld	d,a
	ld	e,#0x0a
	push	de
	call	_Power
	pop	af
	pop	de
	ld	-5 (ix), l
	ld	-4 (ix), h
;src\/Graphics.h:25: if(trailingZero && (number / power) != 0) trailingZero = FALSE;
	push	de
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	__divuint
	pop	af
	pop	af
	ld	-3 (ix), l
	ld	-2 (ix), h
	pop	de
	ld	a, -6 (ix)
	or	a, a
	jr	Z, 00102$
	ld	a, -2 (ix)
	or	a, -3 (ix)
	jr	Z, 00102$
	ld	-6 (ix), #0
00102$:
;src\/Graphics.h:27: if(!trailingZero || i == 1) {
	ld	a, -6 (ix)
	or	a, a
	jr	Z, 00104$
	ld	a, e
	dec	a
	jr	NZ, 00105$
00104$:
;src\/Graphics.h:28: DrawChar((number / power) + CHAR_0, col, line);
	ld	a, -3 (ix)
	add	a, #0x3f
	push	de
	ld	h, 7 (ix)
	push	hl
	inc	sp
	ld	h, -1 (ix)
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_DrawChar
	pop	af
	inc	sp
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	call	__moduint
	pop	af
	pop	af
	pop	de
	ld	4 (ix), l
	ld	5 (ix), h
00105$:
;src\/Graphics.h:32: col++;
	inc	-1 (ix)
;src\/Graphics.h:21: for(byte i = 6; i > 0; i--) { //  (6 digits)
	dec	e
	jp	00109$
00111$:
;src\/Graphics.h:37: }
	ld	sp, ix
	pop	ix
	ret
___str_0:
	.ascii "      "
	.db 0x00
;src\/Graphics.h:39: void DrawColumn(byte col) {
;	---------------------------------
; Function DrawColumn
; ---------------------------------
_DrawColumn::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;src\/Graphics.h:40: WRTVRM(MSX_modedata_screen2.name + col + 0, COLUMN_TOP_1);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	ld	c, 4 (ix)
	ld	b, #0x00
	add	hl, bc
	push	bc
	ld	a, #0x18
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:41: WRTVRM(MSX_modedata_screen2.name + col + 1, COLUMN_TOP_1 + 1);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	inc	hl
	push	bc
	ld	a, #0x19
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:42: WRTVRM(MSX_modedata_screen2.name + col + 2, COLUMN_TOP_1 + 2);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	inc	hl
	inc	hl
	push	bc
	ld	a, #0x1a
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:43: WRTVRM(MSX_modedata_screen2.name + col + 32, COLUMN_TOP_1 + 3);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x0020
	add	hl, de
	push	bc
	ld	a, #0x1b
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:44: WRTVRM(MSX_modedata_screen2.name + col + 33, COLUMN_TOP_1 + 4);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x0021
	add	hl, de
	push	bc
	ld	a, #0x1c
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:45: WRTVRM(MSX_modedata_screen2.name + col + 34, COLUMN_TOP_1 + 5);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x0022
	add	hl, de
	push	bc
	ld	a, #0x1d
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
;src\/Graphics.h:47: for(byte i=0; i<20; i++) {
	ld	-1 (ix), #0
	inc	sp
	pop	bc
00103$:
	ld	a, -1 (ix)
	sub	a, #0x14
	jr	NC, 00101$
;src\/Graphics.h:48: WRTVRM(MSX_modedata_screen2.name + col + 64 + (i*32), COLUMN_MIDDLE_1);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x0040
	add	hl, de
	ld	e, -1 (ix)
	ld	d, #0x00
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	add	hl, de
	push	bc
	push	de
	ld	a, #0x1e
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
	pop	bc
;src\/Graphics.h:49: WRTVRM(MSX_modedata_screen2.name + col + 65 + (i*32), COLUMN_MIDDLE_1 + 1);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	push	de
	ld	de, #0x0041
	add	hl, de
	pop	de
	add	hl, de
	push	bc
	push	de
	ld	a, #0x1f
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
	pop	bc
;src\/Graphics.h:50: WRTVRM(MSX_modedata_screen2.name + col + 66 + (i*32), COLUMN_MIDDLE_1 + 2);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	push	de
	ld	de, #0x0042
	add	hl, de
	pop	de
	add	hl, de
	push	bc
	ld	a, #0x20
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:47: for(byte i=0; i<20; i++) {
	inc	-1 (ix)
	jr	00103$
00101$:
;src\/Graphics.h:53: WRTVRM(MSX_modedata_screen2.name + col + (32 * 8), COLUMN_MIDDLE_2);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	a, h
	inc	a
	ld	h, a
	push	bc
	ld	a, #0x21
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:54: WRTVRM(MSX_modedata_screen2.name + col + (32 * 8) + 1, COLUMN_MIDDLE_2 + 1);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x0101
	add	hl, de
	push	bc
	ld	a, #0x22
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:55: WRTVRM(MSX_modedata_screen2.name + col + (32 * 8) + 2, COLUMN_MIDDLE_2 + 2);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x0102
	add	hl, de
	push	bc
	ld	a, #0x23
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:57: WRTVRM(MSX_modedata_screen2.name + col + (32 * 16), COLUMN_MIDDLE_2);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	a, h
	add	a, #0x02
	ld	h, a
	push	bc
	ld	a, #0x21
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:58: WRTVRM(MSX_modedata_screen2.name + col + (32 * 16) + 1, COLUMN_MIDDLE_2 + 1);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x0201
	add	hl, de
	push	bc
	ld	a, #0x22
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:59: WRTVRM(MSX_modedata_screen2.name + col + (32 * 16) + 2, COLUMN_MIDDLE_2 + 2);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x0202
	add	hl, de
	push	bc
	ld	a, #0x23
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:61: WRTVRM(MSX_modedata_screen2.name + col + (32 * 22) + 0, COLUMN_BOTTOM_1);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x02c0
	add	hl, de
	push	bc
	ld	a, #0x24
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:62: WRTVRM(MSX_modedata_screen2.name + col + (32 * 22) + 1, COLUMN_BOTTOM_1 + 1);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x02c1
	add	hl, de
	push	bc
	ld	a, #0x25
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:63: WRTVRM(MSX_modedata_screen2.name + col + (32 * 22) + 2, COLUMN_BOTTOM_1 + 2);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x02c2
	add	hl, de
	push	bc
	ld	a, #0x26
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:64: WRTVRM(MSX_modedata_screen2.name + col + (32 * 22) + 32, COLUMN_BOTTOM_1 + 3);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x02e0
	add	hl, de
	push	bc
	ld	a, #0x27
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:65: WRTVRM(MSX_modedata_screen2.name + col + (32 * 22) + 33, COLUMN_BOTTOM_1 + 4);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	de, #0x02e1
	add	hl, de
	push	bc
	ld	a, #0x28
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:66: WRTVRM(MSX_modedata_screen2.name + col + (32 * 22) + 34, COLUMN_BOTTOM_1 + 5);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	add	hl, bc
	ld	bc, #0x02e2
	add	hl, bc
	ld	a, #0x29
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
;src\/Graphics.h:67: }
	inc	sp
	pop	ix
	ret
;src\/Graphics.h:69: void DrawScore() {
;	---------------------------------
; Function DrawScore
; ---------------------------------
_DrawScore::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src\/Graphics.h:70: byte bgCounter = 0, bgColor;
	ld	-2 (ix), #0
;src\/Graphics.h:74: if(newLevel) {
	ld	a,(#_newLevel + 0)
	or	a, a
	jp	Z, 00119$
;src\/Graphics.h:75: for(byte i=0; i < 60; i++) {
	ld	-1 (ix), #0
00121$:
	ld	a, -1 (ix)
	sub	a, #0x3c
	jp	NC, 00119$
;src\/Graphics.h:76: lastJiffy = JIFFY;
	ld	bc, (_JIFFY)
;src\/Graphics.h:77: while(lastJiffy == JIFFY) { }
00101$:
	ld	hl, (_JIFFY)
	cp	a, a
	sbc	hl, bc
	jr	Z, 00101$
;src\/Graphics.h:80: if(JIFFY & 0b00000110) {
	ld	hl, (_JIFFY)
	ld	a, l
	and	a, #0x06
	jp	Z,00115$
;src\/Graphics.h:81: DrawString(" LEVEL", 26, 4);
	ld	de, #0x041a
	push	de
	ld	hl, #___str_1
	push	hl
	call	_DrawString
	pop	af
	pop	af
;src\/Graphics.h:82: DrawNumber(level, 26, 5);
	ld	a, (#_level + 0)
	ld	c, a
	ld	b, #0x00
	ld	de, #0x051a
	push	de
	push	bc
	call	_DrawNumber
	pop	af
	pop	af
;src\/Graphics.h:88: switch(bgCounter++) {
	ld	c, -2 (ix)
	inc	-2 (ix)
	ld	a, #0x07
	sub	a, c
	jr	C, 00112$
	ld	b, #0x00
	ld	hl, #00163$
	add	hl, bc
	add	hl, bc
	add	hl, bc
	jp	(hl)
00163$:
	jp	00104$
	jp	00105$
	jp	00106$
	jp	00107$
	jp	00108$
	jp	00109$
	jp	00110$
	jp	00111$
;src\/Graphics.h:89: case 0:
00104$:
;src\/Graphics.h:90: bgColor = 0x14;
	ld	c, #0x14
;src\/Graphics.h:91: break;
	jr	00113$
;src\/Graphics.h:92: case 1:
00105$:
;src\/Graphics.h:93: bgColor = 0x15;
	ld	c, #0x15
;src\/Graphics.h:94: break;
	jr	00113$
;src\/Graphics.h:95: case 2:
00106$:
;src\/Graphics.h:96: bgColor = 0x17;
	ld	c, #0x17
;src\/Graphics.h:97: break;
	jr	00113$
;src\/Graphics.h:98: case 3:
00107$:
;src\/Graphics.h:99: bgColor = 0x1e;
	ld	c, #0x1e
;src\/Graphics.h:100: break;
	jr	00113$
;src\/Graphics.h:101: case 4:
00108$:
;src\/Graphics.h:102: bgColor = 0x1f;
	ld	c, #0x1f
;src\/Graphics.h:103: break;
	jr	00113$
;src\/Graphics.h:104: case 5:
00109$:
;src\/Graphics.h:105: bgColor = 0x1e;
	ld	c, #0x1e
;src\/Graphics.h:106: break;
	jr	00113$
;src\/Graphics.h:107: case 6:
00110$:
;src\/Graphics.h:108: bgColor = 0x17;
	ld	c, #0x17
;src\/Graphics.h:109: break;
	jr	00113$
;src\/Graphics.h:110: case 7:
00111$:
;src\/Graphics.h:111: bgColor = 0x15;
	ld	c, #0x15
;src\/Graphics.h:112: bgCounter = 0;
	ld	-2 (ix), #0
;src\/Graphics.h:113: break;
	jr	00113$
;src\/Graphics.h:114: default:
00112$:
;src\/Graphics.h:115: bgColor = 0x11;
	ld	c, #0x11
;src\/Graphics.h:117: }
00113$:
;src\/Graphics.h:118: FILVRM(MSX_modedata_screen2.color, 8 * 4, bgColor);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	push	bc
	ld	a, c
	push	af
	inc	sp
	ld	de, #0x0020
	push	de
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:119: FILVRM(MSX_modedata_screen2.color + (256 * 8), 8 * 4, bgColor);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	a, h
	add	a, #0x08
	ld	h, a
	push	bc
	ld	a, c
	push	af
	inc	sp
	ld	de, #0x0020
	push	de
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:120: FILVRM(MSX_modedata_screen2.color + (512 * 8), 8 * 4, bgColor);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	a, h
	add	a, #0x10
	ld	h, a
	ld	a, c
	push	af
	inc	sp
	ld	de, #0x0020
	push	de
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
	jr	00122$
00115$:
;src\/Graphics.h:125: DrawString("      ", 26, 4);
	ld	de, #0x041a
	push	de
	ld	hl, #___str_2
	push	hl
	call	_DrawString
	pop	af
	pop	af
;src\/Graphics.h:126: DrawString("      ", 26, 5);
	ld	de, #0x051a
	push	de
	ld	hl, #___str_2
	push	hl
	call	_DrawString
	pop	af
	pop	af
00122$:
;src\/Graphics.h:75: for(byte i=0; i < 60; i++) {
	inc	-1 (ix)
	jp	00121$
00119$:
;src\/Graphics.h:132: newLevel = FALSE;
	ld	hl, #_newLevel
	ld	(hl), #0x00
;src\/Graphics.h:135: FILVRM(MSX_modedata_screen2.color, 8 * 4, 0x14);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	a, #0x14
	push	af
	inc	sp
	ld	de, #0x0020
	push	de
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
;src\/Graphics.h:136: FILVRM(MSX_modedata_screen2.color + (256 * 8), 8 * 4, 0x14);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	a, h
	add	a, #0x08
	ld	h, a
	ld	a, #0x14
	push	af
	inc	sp
	ld	de, #0x0020
	push	de
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
;src\/Graphics.h:137: FILVRM(MSX_modedata_screen2.color + (512 * 8), 8 * 4, 0x14);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	a, h
	add	a, #0x10
	ld	h, a
	ld	a, #0x14
	push	af
	inc	sp
	ld	de, #0x0020
	push	de
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
;src\/Graphics.h:139: DrawString(" LEVEL", 26, 4);
	ld	de, #0x041a
	push	de
	ld	hl, #___str_1
	push	hl
	call	_DrawString
	pop	af
	pop	af
;src\/Graphics.h:140: DrawString("BLOCKS", 26, 9);
	ld	de, #0x091a
	push	de
	ld	hl, #___str_3
	push	hl
	call	_DrawString
	pop	af
	pop	af
;src\/Graphics.h:142: DrawNumber(blocksRemoved, 26, 10);
	ld	de, #0x0a1a
	push	de
	ld	hl, (_blocksRemoved)
	push	hl
	call	_DrawNumber
	pop	af
	pop	af
;src\/Graphics.h:143: DrawNumber(level, 26, 5);
	ld	a, (#_level + 0)
	ld	c, a
	ld	b, #0x00
	ld	de, #0x051a
	push	de
	push	bc
	call	_DrawNumber
;src\/Graphics.h:145: }
	ld	sp,ix
	pop	ix
	ret
___str_1:
	.ascii " LEVEL"
	.db 0x00
___str_2:
	.ascii "      "
	.db 0x00
___str_3:
	.ascii "BLOCKS"
	.db 0x00
;src\/Graphics.h:147: void DrawBackground() {
;	---------------------------------
; Function DrawBackground
; ---------------------------------
_DrawBackground::
;src\/Graphics.h:149: for(int i = 0; i < 256 * 3; i++) {
	ld	bc, #0x0000
00103$:
	ld	a, b
	xor	a, #0x80
	sub	a, #0x83
	jr	NC, 00101$
;src\/Graphics.h:150: WRTVRM(MSX_modedata_screen2.name + i, 0); // test
	ld	hl, (#_MSX_modedata_screen2 + 0)
	ld	e, c
	ld	d, b
	add	hl, de
	push	bc
	xor	a, a
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:149: for(int i = 0; i < 256 * 3; i++) {
	inc	bc
	jr	00103$
00101$:
;src\/Graphics.h:153: DrawColumn(7);
	ld	a, #0x07
	push	af
	inc	sp
	call	_DrawColumn
	inc	sp
;src\/Graphics.h:154: DrawColumn(22);
	ld	a, #0x16
	push	af
	inc	sp
	call	_DrawColumn
	inc	sp
;src\/Graphics.h:156: DrawScore();
;src\/Graphics.h:192: }
	jp	_DrawScore
;src\/Graphics.h:194: void DrawArrow(byte x, byte y) {
;	---------------------------------
; Function DrawArrow
; ---------------------------------
_DrawArrow::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-8
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:195: const byte colors[] = {
	ld	hl, #0
	add	hl, sp
	ex	de, hl
	ld	a, #0x0f
	ld	(de), a
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x0e
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	(hl), #0x05
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x04
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x04
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x05
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x0e
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x0f
;src\/Graphics.h:206: byte colorIndex = (JIFFY & 0b00001110) >> 1;
	ld	hl, (_JIFFY)
	ld	a, l
	and	a, #0x0e
	ld	c, a
	ld	b, #0x00
	srl	b
	rr	c
;src\/Graphics.h:213: WRTVRM(MSX_modedata_screen2.sprite_attribute, 	y - 1);
	ld	b, 5 (ix)
	dec	b
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	push	bc
	push	de
	push	bc
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
	pop	bc
;src\/Graphics.h:214: WRTVRM(MSX_modedata_screen2.sprite_attribute + 1, 	x);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	inc	hl
	push	bc
	push	de
	ld	a, 4 (ix)
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
	pop	bc
;src\/Graphics.h:215: WRTVRM(MSX_modedata_screen2.sprite_attribute + 2, 	SPRITE_PATTERN_DOWN_ARROW);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	inc	hl
	inc	hl
	push	bc
	push	de
	xor	a, a
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
	pop	bc
;src\/Graphics.h:216: WRTVRM(MSX_modedata_screen2.sprite_attribute + 3, 	colors[colorIndex]);
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	c, (hl)
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	inc	hl
	inc	hl
	inc	hl
	ld	a, c
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
;src\/Graphics.h:225: }
	ld	sp,ix
	pop	ix
	ret
;src\/Graphics.h:227: void HideArrow() {
;	---------------------------------
; Function HideArrow
; ---------------------------------
_HideArrow::
;src\/Graphics.h:228: WRTVRM(MSX_modedata_screen2.sprite_attribute, 	192);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	a, #0xc0
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
;src\/Graphics.h:229: }
	ret
;src\/Graphics.h:231: void DrawHitSprite(byte x, byte y) {
;	---------------------------------
; Function DrawHitSprite
; ---------------------------------
_DrawHitSprite::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-10
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:233: const byte colors[] = {
	ld	hl, #0
	add	hl, sp
	ex	de, hl
	ld	a, #0x0f
	ld	(de), a
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x0e
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	(hl), #0x05
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x04
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x04
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x05
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x0e
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x0f
;src\/Graphics.h:244: byte colorIndex = (JIFFY & 0b00000111) >> 1;
	ld	hl, (_JIFFY)
	ld	a, l
	and	a, #0x07
	ld	c, a
	ld	b, #0x00
	srl	b
	rr	c
	ld	-2 (ix), c
;src\/Graphics.h:246: WRTVRM(MSX_modedata_screen2.sprite_attribute + 4, 	y - 1);
	ld	a, 5 (ix)
	add	a, #0xff
	ld	-1 (ix), a
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	bc, #0x0004
	add	hl, bc
	push	de
	ld	a, -1 (ix)
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
;src\/Graphics.h:247: WRTVRM(MSX_modedata_screen2.sprite_attribute + 5, 	x - 16);
	ld	a, 4 (ix)
	add	a, #0xf0
	ld	b, a
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	push	de
	push	bc
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
;src\/Graphics.h:248: WRTVRM(MSX_modedata_screen2.sprite_attribute + 6, 	SPRITE_PATTERN_3X_HIT);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	bc, #0x0006
	add	hl, bc
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
;src\/Graphics.h:249: WRTVRM(MSX_modedata_screen2.sprite_attribute + 7, 	colors[colorIndex]);
	ld	a, e
	add	a, -2 (ix)
	ld	e, a
	jr	NC, 00103$
	inc	d
00103$:
	ld	a, (de)
	ld	b, a
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	push	de
	ld	de, #0x0007
	add	hl, de
	push	bc
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
;src\/Graphics.h:251: WRTVRM(MSX_modedata_screen2.sprite_attribute + 8, 	y - 1);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	bc, #0x0008
	add	hl, bc
	push	de
	ld	a, -1 (ix)
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
;src\/Graphics.h:252: WRTVRM(MSX_modedata_screen2.sprite_attribute + 9, 	x);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	bc, #0x0009
	add	hl, bc
	push	de
	ld	a, 4 (ix)
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
;src\/Graphics.h:253: WRTVRM(MSX_modedata_screen2.sprite_attribute + 10, 	SPRITE_PATTERN_3X_HIT + 4);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	bc, #0x000a
	add	hl, bc
	push	de
	ld	a, #0x08
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
;src\/Graphics.h:254: WRTVRM(MSX_modedata_screen2.sprite_attribute + 11, 	colors[colorIndex]);
	ld	a, (de)
	ld	b, a
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	de, #0x000b
	add	hl, de
	push	bc
	inc	sp
	push	hl
	call	_WRTVRM
;src\/Graphics.h:260: }
	ld	sp,ix
	pop	ix
	ret
;src\/Graphics.h:262: void HideHitSprite() {
;	---------------------------------
; Function HideHitSprite
; ---------------------------------
_HideHitSprite::
;src\/Graphics.h:263: WRTVRM(MSX_modedata_screen2.sprite_attribute + 4, 	192);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	bc, #0x0004
	add	hl, bc
	ld	a, #0xc0
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
;src\/Graphics.h:264: WRTVRM(MSX_modedata_screen2.sprite_attribute + 8, 	192);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	bc, #0x0008
	add	hl, bc
	ld	a, #0xc0
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
;src\/Graphics.h:265: WRTVRM(MSX_modedata_screen2.sprite_attribute + 12, 	192);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	bc, #0x000c
	add	hl, bc
	ld	a, #0xc0
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
;src\/Graphics.h:266: }
	ret
;src\/Graphics.h:268: void InitVRAM() {
;	---------------------------------
; Function InitVRAM
; ---------------------------------
_InitVRAM::
;src\/Graphics.h:273: CLIKSW = 0;	// disable keyboard sound
	ld	hl, #0x0000
	ld	(_CLIKSW), hl
;src\/Graphics.h:274: SCNCNT = 1; 	// set keyboard scan counter
	ld	hl, #_SCNCNT
	ld	(hl), #0x01
;src\/Graphics.h:276: FORCLR = COLOR_WHITE;
	ld	hl, #_FORCLR
	ld	(hl), #0x0f
;src\/Graphics.h:277: BAKCLR = COLOR_BLACK;
	ld	hl, #_BAKCLR
	ld	(hl), #0x01
;src\/Graphics.h:278: BDRCLR = COLOR_BLACK;
	ld	hl, #_BDRCLR
	ld	(hl), #0x01
;src\/Graphics.h:306: WRTVDP(0b0000000111100010);
	ld	hl, #0x01e2
	call	_WRTVDP
;src\/Graphics.h:308: INIGRP();	// Set screen 2
	call	_INIGRP
;src\/Graphics.h:310: DISSCR();	// Disable screen (faster to write)
	call	_DISSCR
;src\/Graphics.h:314: FILVRM(0x0000, 0x4000, 0x00); //void FILVRM(uint16_t start, uint16_t len, uint8_t data);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #0x4000
	push	hl
	ld	h, l
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
;src\/Graphics.h:323: LDIRVM(MSX_modedata_screen2.sprite_pattern, sprite_arrow_0, NUMBER_OF_SPRITES * 32);
	ld	bc, #_sprite_arrow_0+0
	ld	hl, (#(_MSX_modedata_screen2 + 0x0008) + 0)
	ld	de, #0x0080
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:329: for(byte i=0; i<32; i++) {
	ld	c, #0x00
00110$:
	ld	a, c
	sub	a, #0x20
	jr	NC, 00101$
;src\/Graphics.h:330: WRTVRM(MSX_modedata_screen2.sprite_attribute + (i * 4), 	192);
	ld	de, (#(_MSX_modedata_screen2 + 0x0006) + 0)
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, de
	push	bc
	ld	a, #0xc0
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:329: for(byte i=0; i<32; i++) {
	inc	c
	jr	00110$
00101$:
;src\/Graphics.h:339: LDIRVM(MSX_modedata_screen2.pattern, pattern_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
	ld	bc, #_pattern_black_0
	ld	hl, (#(_MSX_modedata_screen2 + 0x0004) + 0)
	ld	de, #0x0178
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:342: LDIRVM(MSX_modedata_screen2.pattern + (256 * 8), pattern_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
	ld	bc, #_pattern_black_0
	ld	hl, (#(_MSX_modedata_screen2 + 0x0004) + 0)
	ld	a, h
	add	a, #0x08
	ld	h, a
	ld	de, #0x0178
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:345: LDIRVM(MSX_modedata_screen2.pattern + (512 * 8), pattern_black_0, NUMBER_OF_PATTERNS * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
	ld	bc, #_pattern_black_0
	ld	hl, (#(_MSX_modedata_screen2 + 0x0004) + 0)
	ld	a, h
	add	a, #0x10
	ld	h, a
	ld	de, #0x0178
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:348: LDIRVM(MSX_modedata_screen2.pattern + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
	ld	bc, #_FONT
	ld	hl, (#(_MSX_modedata_screen2 + 0x0004) + 0)
	ld	de, #0x0178
	add	hl, de
	ld	de, #0x0300
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:351: LDIRVM(MSX_modedata_screen2.pattern + (256 * 8) + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
	ld	bc, #_FONT
	ld	hl, (#(_MSX_modedata_screen2 + 0x0004) + 0)
	ld	de, #0x0978
	add	hl, de
	ld	de, #0x0300
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:354: LDIRVM(MSX_modedata_screen2.pattern + (512 * 8) + (NUMBER_OF_PATTERNS * 8), FONT, (HICHAR-LOCHAR+1) * 8);	//void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count);
	ld	bc, #_FONT
	ld	hl, (#(_MSX_modedata_screen2 + 0x0004) + 0)
	ld	de, #0x1178
	add	hl, de
	ld	de, #0x0300
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:358: for(byte i=0; i < NUMBER_OF_TITLE_BLOCKS; i++) {
	ld	c, #0x00
00113$:
	ld	a, c
	sub	a, #0x07
	jr	NC, 00102$
;src\/Graphics.h:359: LDIRVM(MSX_modedata_screen2.pattern + (TITLE_1 * 8) + (i * 8), pattern_title, NUMBER_OF_TITLE_BLOCKS * 8);
	ld	de, (#(_MSX_modedata_screen2 + 0x0004) + 0)
	ld	hl, #0x0470
	add	hl, de
	ex	de, hl
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	push	bc
	ld	de, #0x0038
	push	de
	ld	de, #_pattern_title
	push	de
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	bc
;src\/Graphics.h:358: for(byte i=0; i < NUMBER_OF_TITLE_BLOCKS; i++) {
	inc	c
	jr	00113$
00102$:
;src\/Graphics.h:369: LDIRVM(MSX_modedata_screen2.color, color_black_0, NUMBER_OF_PATTERNS * 8);
	ld	bc, #_color_black_0
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	de, #0x0178
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:371: LDIRVM(MSX_modedata_screen2.color + (256 * 8), color_black_0, NUMBER_OF_PATTERNS * 8);
	ld	bc, #_color_black_0
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	a, h
	add	a, #0x08
	ld	h, a
	ld	de, #0x0178
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:373: LDIRVM(MSX_modedata_screen2.color + (512 * 8), color_black_0, NUMBER_OF_PATTERNS * 8);
	ld	bc, #_color_black_0
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	a, h
	add	a, #0x10
	ld	h, a
	ld	de, #0x0178
	push	de
	push	bc
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:380: for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
	ld	c, #0x00
00116$:
	ld	a, c
	sub	a, #0x60
	jr	NC, 00103$
;src\/Graphics.h:381: LDIRVM(MSX_modedata_screen2.color + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font_2, 8);
	ld	de, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	hl, #0x0178
	add	hl, de
	ex	de, hl
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	push	bc
	ld	de, #0x0008
	push	de
	ld	de, #_color_font_2
	push	de
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	bc
;src\/Graphics.h:380: for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
	inc	c
	jr	00116$
00103$:
;src\/Graphics.h:384: for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
	ld	c, #0x00
00119$:
	ld	a, c
	sub	a, #0x60
	jr	NC, 00104$
;src\/Graphics.h:385: LDIRVM(MSX_modedata_screen2.color + (256 * 8) + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font_2, 8);
	ld	de, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	hl, #0x0978
	add	hl, de
	ex	de, hl
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	push	bc
	ld	de, #0x0008
	push	de
	ld	de, #_color_font_2
	push	de
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	bc
;src\/Graphics.h:384: for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
	inc	c
	jr	00119$
00104$:
;src\/Graphics.h:388: for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
	ld	c, #0x00
00122$:
	ld	a, c
	sub	a, #0x60
	jr	NC, 00105$
;src\/Graphics.h:389: LDIRVM(MSX_modedata_screen2.color + (512 * 8) + (NUMBER_OF_PATTERNS * 8) + (i * 8), color_font_2, 8);
	ld	de, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	hl, #0x1178
	add	hl, de
	ex	de, hl
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	push	bc
	ld	de, #0x0008
	push	de
	ld	de, #_color_font_2
	push	de
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	bc
;src\/Graphics.h:388: for(byte i = 0; i < (HICHAR - LOCHAR + 1); i++) {
	inc	c
	jr	00122$
00105$:
;src\/Graphics.h:397: for(byte i = 0; i < 10; i++) {
	ld	c, #0x00
00125$:
	ld	a, c
	sub	a, #0x0a
	jr	NC, 00106$
;src\/Graphics.h:398: LDIRVM(MSX_modedata_screen2.color + (CHAR_0 * 8) + (i * 8), color_font_1, 8);
	ld	de, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	hl, #0x01f8
	add	hl, de
	ex	de, hl
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	push	bc
	ld	de, #0x0008
	push	de
	ld	de, #_color_font_1
	push	de
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	bc
;src\/Graphics.h:397: for(byte i = 0; i < 10; i++) {
	inc	c
	jr	00125$
00106$:
;src\/Graphics.h:401: for(byte i = 0; i < 10; i++) {
	ld	c, #0x00
00128$:
	ld	a, c
	sub	a, #0x0a
	jr	NC, 00107$
;src\/Graphics.h:402: LDIRVM(MSX_modedata_screen2.color + (256 * 8) + (CHAR_0 * 8) + (i * 8), color_font_1, 8);
	ld	de, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	hl, #0x09f8
	add	hl, de
	ex	de, hl
	ld	a, c
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	push	bc
	ld	de, #0x0008
	push	de
	ld	de, #_color_font_1
	push	de
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	bc
;src\/Graphics.h:401: for(byte i = 0; i < 10; i++) {
	inc	c
	jr	00128$
00107$:
;src\/Graphics.h:405: for(byte i = 0; i < 10; i++) {
	ld	c, #0x00
00131$:
	ld	a, c
	sub	a, #0x0a
	jr	NC, 00108$
;src\/Graphics.h:406: LDIRVM(MSX_modedata_screen2.color + (512 * 8) + (CHAR_0 * 8) + (i * 8), color_font_1, 8);
	ld	de, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	hl, #0x11f8
	add	hl, de
	ex	de, hl
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	push	bc
	ld	de, #0x0008
	push	de
	ld	de, #_color_font_1
	push	de
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	pop	bc
;src\/Graphics.h:405: for(byte i = 0; i < 10; i++) {
	inc	c
	jr	00131$
00108$:
;src\/Graphics.h:410: LDIRVM(MSX_modedata_screen2.color + (TITLE_1 * 8), color_title_1, NUMBER_OF_TITLE_BLOCKS * 8);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	bc, #0x0470
	add	hl, bc
	ld	de, #0x0038
	push	de
	ld	de, #_color_title_1
	push	de
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
;src\/Graphics.h:418: ENASCR();	// Enable screen
;src\/Graphics.h:419: }
	jp	_ENASCR
;src\/Graphics.h:421: void DrawBlock(byte col, byte line, byte tile) {
;	---------------------------------
; Function DrawBlock
; ---------------------------------
_DrawBlock::
	push	ix
	ld	ix,#0
	add	ix,sp
;src\/Graphics.h:423: word baseAddr = MSX_modedata_screen2.name + (col * 2) + (line * 2 * 32) + PLAYFIELD_HORIZ_OFFSET;
	ld	bc, (#_MSX_modedata_screen2 + 0)
	ld	l, 4 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ex	de, hl
	ld	l, 5 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ex	de, hl
	ld	hl, #0x000a
	add	hl, de
	ex	de, hl
;src\/Graphics.h:425: WRTVRM(baseAddr, tile);
	push	de
	ld	a, 6 (ix)
	push	af
	inc	sp
	push	de
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
;src\/Graphics.h:426: WRTVRM(baseAddr + 1, tile + 1);
	ld	c, 6 (ix)
	ld	a, c
	inc	a
	ld	l, e
	ld	h, d
	inc	hl
	push	bc
	push	de
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
	pop	bc
;src\/Graphics.h:427: WRTVRM(baseAddr + 32, tile + 2);
	ld	b, c
	inc	b
	inc	b
	ld	hl, #0x0020
	add	hl, de
	push	bc
	push	de
	push	bc
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
	pop	bc
;src\/Graphics.h:428: WRTVRM(baseAddr + 33, tile + 3);
	inc	c
	inc	c
	inc	c
	ld	hl, #0x0021
	add	hl, de
	ld	a, c
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
;src\/Graphics.h:429: }
	pop	ix
	ret
;src\/Graphics.h:431: void DrawBlock_SameTile(byte col, byte line, byte tile) {
;	---------------------------------
; Function DrawBlock_SameTile
; ---------------------------------
_DrawBlock_SameTile::
	push	ix
	ld	ix,#0
	add	ix,sp
;src\/Graphics.h:433: word baseAddr = MSX_modedata_screen2.name + (col * 2) + (line * 2 * 32) + PLAYFIELD_HORIZ_OFFSET;
	ld	bc, (#_MSX_modedata_screen2 + 0)
	ld	l, 4 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ex	de, hl
	ld	l, 5 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	bc, #0x000a
	add	hl, bc
	ld	c, l
	ld	b, h
;src\/Graphics.h:435: WRTVRM(baseAddr, tile);
	push	bc
	ld	a, 6 (ix)
	push	af
	inc	sp
	push	bc
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:436: WRTVRM(baseAddr + 1, tile);
	ld	e, c
	ld	d, b
	inc	de
	push	bc
	ld	a, 6 (ix)
	push	af
	inc	sp
	push	de
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:437: WRTVRM(baseAddr + 32, tile);
	ld	hl, #0x0020
	add	hl, bc
	push	bc
	ld	a, 6 (ix)
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:438: WRTVRM(baseAddr + 33, tile);
	ld	hl, #0x0021
	add	hl, bc
	ld	a, 6 (ix)
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
;src\/Graphics.h:439: }
	pop	ix
	ret
;src\/Graphics.h:441: void DrawLine(byte line) {
;	---------------------------------
; Function DrawLine
; ---------------------------------
_DrawLine::
	push	ix
	ld	ix,#0
	add	ix,sp
;src\/Graphics.h:442: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	ld	c, 4 (ix)
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, #0x06
	jr	NC, 00105$
;src\/Graphics.h:443: DrawBlock(col, line, playfield[col][line]);
	ld	e, b
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ld	de, #_playfield
	add	hl, de
	ld	e, c
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	push	bc
	push	af
	inc	sp
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_DrawBlock
	pop	af
	inc	sp
	pop	bc
;src\/Graphics.h:442: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	inc	b
	jr	00103$
00105$:
;src\/Graphics.h:445: }
	pop	ix
	ret
;src\/Graphics.h:447: void DrawPiece(byte line) {
;	---------------------------------
; Function DrawPiece
; ---------------------------------
_DrawPiece::
;src\/Graphics.h:448: DrawLine(line);
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_DrawLine
	inc	sp
;src\/Graphics.h:449: DrawLine(line + 1);
	ld	hl, #2
	add	hl, sp
	ld	b, (hl)
	ld	a, b
	inc	a
	push	bc
	push	af
	inc	sp
	call	_DrawLine
	inc	sp
	pop	bc
;src\/Graphics.h:450: DrawLine(line + 2);
	inc	b
	inc	b
	push	bc
	inc	sp
	call	_DrawLine
	inc	sp
;src\/Graphics.h:451: }
	ret
;src\/Graphics.h:453: void DrawPlayfield() {
;	---------------------------------
; Function DrawPlayfield
; ---------------------------------
_DrawPlayfield::
;src\/Graphics.h:454: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, #0x0c
	ret	NC
;src\/Graphics.h:455: DrawLine(line);
	push	bc
	push	bc
	inc	sp
	call	_DrawLine
	inc	sp
	pop	bc
;src\/Graphics.h:454: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	inc	b
;src\/Graphics.h:457: }
	jr	00103$
;src\/Sound.h:1: void SoundFx_2() {
;	---------------------------------
; Function SoundFx_2
; ---------------------------------
_SoundFx_2::
;src\/Sound.h:2: GICINI();
	call	_GICINI
;src\/Sound.h:17: WRTPSG(0x0f08);
	ld	hl, #0x0f08
	call	_WRTPSG
;src\/Sound.h:19: for(byte i=0; i<255; i++) {
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0xff
	jr	NC, 00101$
;src\/Sound.h:20: WRTPSG((93 * 256) + 0);
	push	bc
	ld	hl, #0x5d00
	call	_WRTPSG
	ld	hl, #0x0001
	call	_WRTPSG
	pop	bc
;src\/Sound.h:19: for(byte i=0; i<255; i++) {
	inc	c
	jr	00104$
00101$:
;src\/Sound.h:24: for(byte i=0; i<255; i++) {
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0xff
	jr	NC, 00102$
;src\/Sound.h:25: WRTPSG((45 * 256) + 0);
	push	bc
	ld	hl, #0x2d00
	call	_WRTPSG
	ld	hl, #0x0001
	call	_WRTPSG
	pop	bc
;src\/Sound.h:24: for(byte i=0; i<255; i++) {
	inc	c
	jr	00107$
00102$:
;src\/Sound.h:29: WRTPSG((0 * 256) + 8);	// register 8, value 0
	ld	hl, #0x0008
;src\/Sound.h:30: }
	jp	_WRTPSG
;src\/Sound.h:32: void SoundFx_1() {
;	---------------------------------
; Function SoundFx_1
; ---------------------------------
_SoundFx_1::
;src\/Sound.h:34: GICINI();
	call	_GICINI
;src\/Sound.h:36: WRTPSG((151 * 256) + 6);
	ld	hl, #0x9706
	call	_WRTPSG
;src\/Sound.h:40: WRTPSG((0b10000001 * 256) + 7);
	ld	hl, #0x8107
	call	_WRTPSG
;src\/Sound.h:42: WRTPSG((16 * 256) + 8);
	ld	hl, #0x1008
	call	_WRTPSG
;src\/Sound.h:43: WRTPSG((19 * 256) + 12);
	ld	hl, #0x130c
	call	_WRTPSG
;src\/Sound.h:44: WRTPSG((1 * 256) + 13);
	ld	hl, #0x010d
;src\/Sound.h:49: }
	jp	_WRTPSG
;src\/CheckPlayfield.h:2: void CheckIfPlayfieldIsValid() {
;	---------------------------------
; Function CheckIfPlayfieldIsValid
; ---------------------------------
_CheckIfPlayfieldIsValid::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	dec	sp
;src\/CheckPlayfield.h:3: bool found = FALSE;
	ld	-5 (ix), #0
;src\/CheckPlayfield.h:4: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	ld	-4 (ix), #0
	ld	-2 (ix), #0
00119$:
	ld	a, -2 (ix)
	sub	a, #0x0c
	jp	NC, 00121$
;src\/CheckPlayfield.h:5: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	ld	-3 (ix), #0
	ld	-1 (ix), #0
00116$:
	ld	a, -1 (ix)
	sub	a, #0x06
	jr	NC, 00120$
;src\/CheckPlayfield.h:6: for(byte item = 0; item < 5; item++) {
	ld	c, #0x00
00113$:
	ld	a, c
	sub	a, #0x05
	jr	NC, 00104$
;src\/CheckPlayfield.h:7: found = FALSE;
	ld	-5 (ix), #0
;src\/CheckPlayfield.h:8: if(playfieldTemp[col][line] == pieces[item] || playfieldTemp[col][line] == EMPTY) {
	ld	e, -1 (ix)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ld	de, #_playfieldTemp
	add	hl, de
	ld	a, l
	add	a, -2 (ix)
	ld	e, a
	ld	a, h
	adc	a, #0x00
	ld	d, a
	ld	hl, #_pieces
	ld	b, #0x00
	add	hl, bc
	ld	b, (hl)
	ld	a, (de)
	cp	a, b
	jr	Z, 00101$
	or	a, a
	jr	NZ, 00114$
00101$:
;src\/CheckPlayfield.h:9: found = TRUE;
	ld	-5 (ix), #0x01
;src\/CheckPlayfield.h:10: break;
	jr	00104$
00114$:
;src\/CheckPlayfield.h:6: for(byte item = 0; item < 5; item++) {
	inc	c
	jr	00113$
00104$:
;src\/CheckPlayfield.h:13: if(!found) {
	ld	a, -5 (ix)
	or	a, a
	jr	NZ, 00117$
;src\/CheckPlayfield.h:14: d_col = col;
	ld	a, -3 (ix)
	ld	(#_d_col),a
;src\/CheckPlayfield.h:15: d_line = line;
	ld	a, -4 (ix)
	ld	(#_d_line),a
;src\/CheckPlayfield.h:16: d_value = playfieldTemp[col][line];
	ld	c, -3 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	de, #_playfieldTemp
	add	hl, de
	ld	e, -4 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	ld	(_d_value+0), a
;src\/CheckPlayfield.h:18: while(1) { 
00106$:
;src\/CheckPlayfield.h:19: BEEP();
	call	_BEEP
	jr	00106$
00117$:
;src\/CheckPlayfield.h:5: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	ld	-3 (ix), a
	jr	00116$
00120$:
;src\/CheckPlayfield.h:4: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	inc	-2 (ix)
	ld	a, -2 (ix)
	ld	-4 (ix), a
	jp	00119$
00121$:
;src\/CheckPlayfield.h:25: }
	ld	sp, ix
	pop	ix
	ret
;src\/CheckPlayfield.h:28: void CheckPlayfield(byte iteration) {
;	---------------------------------
; Function CheckPlayfield
; ---------------------------------
_CheckPlayfield::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-17
	add	hl, sp
	ld	sp, hl
;src\/CheckPlayfield.h:29: bool piecesRemoved = FALSE;
	ld	-17 (ix), #0
;src\/CheckPlayfield.h:32: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	ld	c, #0x00
00190$:
	ld	a, c
	sub	a, #0x0c
	jr	NC, 00102$
;src\/CheckPlayfield.h:33: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	ld	-1 (ix), #0
00187$:
	ld	a, -1 (ix)
	sub	a, #0x06
	jr	NC, 00191$
;src\/CheckPlayfield.h:34: playfieldTemp[col][line] = playfield[col][line];
	ld	e, -1 (ix)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfieldTemp
	add	hl, de
	ld	b, #0x00
	add	hl, bc
	ld	a, #<(_playfield)
	add	a, e
	ld	e, a
	ld	a, #>(_playfield)
	adc	a, d
	ld	d, a
	ld	a, e
	add	a, c
	ld	e, a
	jr	NC, 00599$
	inc	d
00599$:
	ld	a, (de)
	ld	(hl), a
;src\/CheckPlayfield.h:33: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	inc	-1 (ix)
	jr	00187$
00191$:
;src\/CheckPlayfield.h:32: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	inc	c
	jr	00190$
00102$:
;src\/CheckPlayfield.h:39: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	ld	-2 (ix), #0
00196$:
	ld	a, -2 (ix)
	sub	a, #0x0c
	jp	NC, 00108$
;src\/CheckPlayfield.h:40: for(byte col = 2; col < COLS_PLAYFIELD; col++) {
	ld	-1 (ix), #0x02
00193$:
	ld	a, -1 (ix)
	sub	a, #0x06
	jp	NC, 00197$
;src\/CheckPlayfield.h:41: if (playfieldTemp[col][line] != EMPTY &&
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	-11 (ix), l
	ld	-10 (ix), h
	ld	a, #<(_playfieldTemp)
	add	a, -11 (ix)
	ld	c, a
	ld	a, #>(_playfieldTemp)
	adc	a, -10 (ix)
	ld	b, a
	ld	a, c
	add	a, -2 (ix)
	ld	-9 (ix), a
	ld	a, b
	adc	a, #0x00
	ld	-8 (ix), a
	ld	l, -9 (ix)
	ld	h, -8 (ix)
	ld	a, (hl)
	ld	-7 (ix), a
	or	a, a
	jp	Z, 00194$
;src\/CheckPlayfield.h:42: playfieldTemp[col - 2][line] == playfieldTemp[col - 1][line] && 
	ld	a, -1 (ix)
	ld	-3 (ix), a
	ld	c, a
	dec	c
	dec	c
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfieldTemp
	add	hl, de
	ld	a, l
	add	a, -2 (ix)
	ld	-6 (ix), a
	ld	a, h
	adc	a, #0x00
	ld	-5 (ix), a
	ld	c, -3 (ix)
	dec	c
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	a, #<(_playfieldTemp)
	add	a, -4 (ix)
	ld	c, a
	ld	a, #>(_playfieldTemp)
	adc	a, -3 (ix)
	ld	b, a
	ld	a, c
	add	a, -2 (ix)
	ld	c, a
	jr	NC, 00600$
	inc	b
00600$:
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	l, (hl)
	ld	a, (bc)
	ld	h, a
	ld	a, l
	sub	a, h
	jr	NZ, 00194$
;src\/CheckPlayfield.h:43: playfieldTemp[col - 1][line] == playfieldTemp[col][line]) {
	ld	a, -7 (ix)
	sub	a, h
	jr	NZ, 00194$
;src\/CheckPlayfield.h:45: piecesRemoved = TRUE;
	ld	-17 (ix), #0x01
;src\/CheckPlayfield.h:48: playfield[col - 2][line] = playfieldTemp[col - 2][line] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, e
	ld	e, a
	ld	a, #>(_playfield)
	adc	a, d
	ld	d, a
	ld	a, e
	add	a, -2 (ix)
	ld	e, a
	jr	NC, 00605$
	inc	d
00605$:
	ld	a, l
	set	7, a
	ld	(de), a
;src\/CheckPlayfield.h:49: playfield[col - 1][line] = playfieldTemp[col - 1][line] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, -4 (ix)
	ld	e, a
	ld	a, #>(_playfield)
	adc	a, -3 (ix)
	ld	d, a
	ld	l, -2 (ix)
	ld	h, #0x00
	add	hl, de
	ld	a, (bc)
	set	7, a
	ld	(hl), a
;src\/CheckPlayfield.h:50: playfield[col][line] = 	   playfieldTemp[col][line] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, -11 (ix)
	ld	c, a
	ld	a, #>(_playfield)
	adc	a, -10 (ix)
	ld	b, a
	ld	a, c
	add	a, -2 (ix)
	ld	c, a
	jr	NC, 00606$
	inc	b
00606$:
	ld	l, -9 (ix)
	ld	h, -8 (ix)
	ld	a, (hl)
	set	7, a
	ld	(bc), a
00194$:
;src\/CheckPlayfield.h:40: for(byte col = 2; col < COLS_PLAYFIELD; col++) {
	inc	-1 (ix)
	jp	00193$
00197$:
;src\/CheckPlayfield.h:39: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	inc	-2 (ix)
	jp	00196$
00108$:
;src\/CheckPlayfield.h:56: for(byte line = 2; line < LINES_PLAYFIELD; line++) {
	ld	c, #0x02
00202$:
	ld	a, c
	sub	a, #0x0c
	jp	NC, 00114$
;src\/CheckPlayfield.h:57: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	ld	-1 (ix), #0
00199$:
	ld	a, -1 (ix)
	sub	a, #0x06
	jp	NC, 00203$
;src\/CheckPlayfield.h:58: if (playfieldTemp[col][line] != EMPTY &&
	ld	e, -1 (ix)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ld	-9 (ix), l
	ld	-8 (ix), h
	ld	a, #<(_playfieldTemp)
	add	a, -9 (ix)
	ld	e, a
	ld	a, #>(_playfieldTemp)
	adc	a, -8 (ix)
	ld	d, a
	ld	a, e
	add	a, c
	ld	-7 (ix), a
	ld	a, d
	adc	a, #0x00
	ld	-6 (ix), a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	a, (hl)
	ld	-2 (ix), a
	or	a, a
	jr	Z, 00200$
;src\/CheckPlayfield.h:59: playfieldTemp[col][line - 2] == playfieldTemp[col][line - 1] && 
	ld	-3 (ix), c
	ld	a, c
	add	a, #0xfe
	ld	-5 (ix), a
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	b, -3 (ix)
	dec	b
	ld	a, e
	add	a, b
	ld	e, a
	jr	NC, 00607$
	inc	d
00607$:
	ld	a, (hl)
	ld	-4 (ix), a
	ld	a, (de)
	ld	l, a
	ld	a, -4 (ix)
	sub	a, l
	jr	NZ, 00200$
;src\/CheckPlayfield.h:60: playfieldTemp[col][line - 1] == playfieldTemp[col][line]) {
	ld	a, -2 (ix)
	sub	a, l
	jr	NZ, 00200$
;src\/CheckPlayfield.h:62: piecesRemoved = TRUE;
	ld	-17 (ix), #0x01
;src\/CheckPlayfield.h:65: playfield[col][line - 2] = playfieldTemp[col][line - 2] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, -9 (ix)
	ld	-3 (ix), a
	ld	a, #>(_playfield)
	adc	a, -8 (ix)
	ld	-2 (ix), a
	ld	a, -3 (ix)
	add	a, -5 (ix)
	ld	l, a
	ld	a, -2 (ix)
	adc	a, #0x00
	ld	h, a
	ld	a, -4 (ix)
	set	7, a
	ld	(hl), a
;src\/CheckPlayfield.h:66: playfield[col][line - 1] = playfieldTemp[col][line - 1] | REMOVING_FLAG;
	ld	a, -3 (ix)
	add	a, b
	ld	l, a
	ld	a, -2 (ix)
	adc	a, #0x00
	ld	h, a
	ld	a, (de)
	set	7, a
	ld	(hl), a
;src\/CheckPlayfield.h:67: playfield[col][line] = 	   playfieldTemp[col][line] | REMOVING_FLAG;
	ld	a, -3 (ix)
	add	a, c
	ld	e, a
	ld	a, -2 (ix)
	adc	a, #0x00
	ld	d, a
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	a, (hl)
	set	7, a
	ld	(de), a
00200$:
;src\/CheckPlayfield.h:57: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	inc	-1 (ix)
	jp	00199$
00203$:
;src\/CheckPlayfield.h:56: for(byte line = 2; line < LINES_PLAYFIELD; line++) {
	inc	c
	jp	00202$
00114$:
;src\/CheckPlayfield.h:73: for(byte line = 2; line < LINES_PLAYFIELD; line++) {
	ld	-2 (ix), #0x02
00208$:
	ld	a, -2 (ix)
	sub	a, #0x0c
	jp	NC, 00124$
;src\/CheckPlayfield.h:74: for(byte col = 2; col < COLS_PLAYFIELD; col++) {
	ld	-1 (ix), #0x02
00205$:
	ld	a, -1 (ix)
	sub	a, #0x06
	jp	NC, 00209$
;src\/CheckPlayfield.h:75: if (playfieldTemp[col][line] != EMPTY &&
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	-16 (ix), l
	ld	-15 (ix), h
	ld	a, #<(_playfieldTemp)
	add	a, -16 (ix)
	ld	c, a
	ld	a, #>(_playfieldTemp)
	adc	a, -15 (ix)
	ld	b, a
	ld	a, c
	add	a, -2 (ix)
	ld	-14 (ix), a
	ld	a, b
	adc	a, #0x00
	ld	-13 (ix), a
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	e, (hl)
;src\/CheckPlayfield.h:76: playfieldTemp[col - 2][line - 2] == playfieldTemp[col - 1][line - 1] && 
	ld	d, -1 (ix)
	ld	h, -2 (ix)
	ld	l, d
	dec	l
	dec	l
	ld	a, h
	add	a, #0xfe
	ld	-12 (ix), a
	dec	d
	ld	a, h
	add	a, #0xff
	ld	-11 (ix), a
	push	de
	ld	e, l
	ld	a, e
	rlca
	sbc	a, a
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	pop	de
	ld	-10 (ix), l
	ld	-9 (ix), h
	push	de
	ld	e, d
	ld	a, e
	rlca
	sbc	a, a
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	pop	de
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	a, #<(_playfieldTemp)
	add	a, -10 (ix)
	ld	-6 (ix), a
	ld	a, #>(_playfieldTemp)
	adc	a, -9 (ix)
	ld	-5 (ix), a
	ld	a, #<(_playfieldTemp)
	add	a, -8 (ix)
	ld	d, a
	ld	a, #>(_playfieldTemp)
	adc	a, -7 (ix)
	ld	l, a
	ld	a, d
	add	a, -11 (ix)
	ld	-4 (ix), a
	ld	a, l
	adc	a, #0x00
	ld	-3 (ix), a
;src\/CheckPlayfield.h:75: if (playfieldTemp[col][line] != EMPTY &&
	ld	a, e
	or	a, a
	jr	Z, 00116$
;src\/CheckPlayfield.h:76: playfieldTemp[col - 2][line - 2] == playfieldTemp[col - 1][line - 1] && 
	ld	a, -6 (ix)
	add	a, -12 (ix)
	ld	l, a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	h, a
	ld	d, (hl)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	l, (hl)
	ld	a, d
	sub	a, l
	jr	NZ, 00116$
;src\/CheckPlayfield.h:77: playfieldTemp[col - 1][line - 1] == playfieldTemp[col][line]) {
	ld	a, e
	sub	a, l
	jr	NZ, 00116$
;src\/CheckPlayfield.h:79: piecesRemoved = TRUE;
	ld	-17 (ix), #0x01
;src\/CheckPlayfield.h:82: playfield[col - 2][line - 2] = playfieldTemp[col - 2][line - 2] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, -10 (ix)
	ld	e, a
	ld	a, #>(_playfield)
	adc	a, -9 (ix)
	ld	h, a
	ld	a, e
	add	a, -12 (ix)
	ld	l, a
	jr	NC, 00616$
	inc	h
00616$:
	set	7, d
	ld	(hl), d
;src\/CheckPlayfield.h:83: playfield[col - 1][line - 1] = playfieldTemp[col - 1][line - 1] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, -8 (ix)
	ld	e, a
	ld	a, #>(_playfield)
	adc	a, -7 (ix)
	ld	d, a
	ld	a, e
	add	a, -11 (ix)
	ld	e, a
	jr	NC, 00617$
	inc	d
00617$:
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	set	7, a
	ld	(de), a
;src\/CheckPlayfield.h:84: playfield[col][line] = 	       playfieldTemp[col][line] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, -16 (ix)
	ld	e, a
	ld	a, #>(_playfield)
	adc	a, -15 (ix)
	ld	d, a
	ld	a, e
	add	a, -2 (ix)
	ld	e, a
	jr	NC, 00618$
	inc	d
00618$:
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	ld	a, (hl)
	set	7, a
	ld	(de), a
00116$:
;src\/CheckPlayfield.h:86: if (playfieldTemp[col][line - 2] != EMPTY &&
	ld	l, -12 (ix)
	ld	h, #0x00
	add	hl, bc
	ld	c, (hl)
	ld	a, c
	or	a, a
	jr	Z, 00206$
;src\/CheckPlayfield.h:87: playfieldTemp[col - 1][line - 1] == playfieldTemp[col - 2][line] && 
	ld	a, -6 (ix)
	add	a, -2 (ix)
	ld	e, a
	ld	a, -5 (ix)
	adc	a, #0x00
	ld	d, a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	b, (hl)
	ld	a, (de)
	cp	a, b
	jr	NZ, 00206$
;src\/CheckPlayfield.h:88: playfieldTemp[col - 2][line] == playfieldTemp[col][line - 2]) {
	sub	a, c
	jr	NZ, 00206$
;src\/CheckPlayfield.h:90: piecesRemoved = TRUE;
	ld	-17 (ix), #0x01
;src\/CheckPlayfield.h:93: playfield[col][line - 2] =     playfieldTemp[col][line - 2] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, -16 (ix)
	ld	b, a
	ld	a, #>(_playfield)
	adc	a, -15 (ix)
	ld	h, a
	ld	a, b
	add	a, -12 (ix)
	ld	l, a
	jr	NC, 00623$
	inc	h
00623$:
	set	7, c
	ld	(hl), c
;src\/CheckPlayfield.h:94: playfield[col - 1][line - 1] = playfieldTemp[col - 1][line - 1] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, -8 (ix)
	ld	c, a
	ld	a, #>(_playfield)
	adc	a, -7 (ix)
	ld	b, a
	ld	a, c
	add	a, -11 (ix)
	ld	c, a
	jr	NC, 00624$
	inc	b
00624$:
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	set	7, a
	ld	(bc), a
;src\/CheckPlayfield.h:95: playfield[col - 2][line] =     playfieldTemp[col - 2][line] | REMOVING_FLAG;
	ld	a, #<(_playfield)
	add	a, -10 (ix)
	ld	c, a
	ld	a, #>(_playfield)
	adc	a, -9 (ix)
	ld	b, a
	ld	l, -2 (ix)
	ld	h, #0x00
	add	hl, bc
	ld	a, (de)
	set	7, a
	ld	(hl), a
00206$:
;src\/CheckPlayfield.h:74: for(byte col = 2; col < COLS_PLAYFIELD; col++) {
	inc	-1 (ix)
	jp	00205$
00209$:
;src\/CheckPlayfield.h:73: for(byte line = 2; line < LINES_PLAYFIELD; line++) {
	inc	-2 (ix)
	jp	00208$
00124$:
;src\/CheckPlayfield.h:100: if(piecesRemoved) {
	ld	a, -17 (ix)
	or	a, a
	jp	Z, 00231$
;src\/CheckPlayfield.h:107: byte leftmostPieceRemoved = 5, rightmostPieceRemoved = 0;
	ld	-16 (ix), #0x05
	ld	-15 (ix), #0
;src\/CheckPlayfield.h:108: byte lowermostPieceRemoved = 11,   upmostPieceRemoved = 0;
	ld	-14 (ix), #0x0b
	ld	-13 (ix), #0
;src\/CheckPlayfield.h:110: HideArrow();
	call	_HideArrow
;src\/CheckPlayfield.h:112: SoundFx_2();
	call	_SoundFx_2
;src\/CheckPlayfield.h:115: numberPiecesRemoved = 0;
	ld	-2 (ix), #0
;src\/CheckPlayfield.h:116: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	ld	-1 (ix), #0
00214$:
	ld	a, -1 (ix)
	sub	a, #0x0c
	jr	NC, 00136$
;src\/CheckPlayfield.h:117: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	ld	b, -2 (ix)
	ld	e, #0x00
00211$:
	ld	a, e
	sub	a, #0x06
	jr	NC, 00312$
;src\/CheckPlayfield.h:118: if((playfield[col][line] & REMOVING_FLAG) != 0) {
	push	de
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ld	de, #_playfield
	add	hl, de
	pop	de
	ld	a, l
	add	a, -1 (ix)
	ld	l, a
	jr	NC, 00625$
	inc	h
00625$:
	ld	a, (hl)
	rlca
	jr	NC, 00212$
;src\/CheckPlayfield.h:119: numberPiecesRemoved++;
	inc	b
;src\/CheckPlayfield.h:121: if(col < leftmostPieceRemoved) leftmostPieceRemoved = col;
	ld	a, e
	sub	a, -16 (ix)
	jr	NC, 00126$
	ld	-16 (ix), e
00126$:
;src\/CheckPlayfield.h:122: if(col > rightmostPieceRemoved) rightmostPieceRemoved = col;
	ld	a, -15 (ix)
	sub	a, e
	jr	NC, 00128$
	ld	-15 (ix), e
00128$:
;src\/CheckPlayfield.h:123: if(line < lowermostPieceRemoved) lowermostPieceRemoved = line;
	ld	a, -1 (ix)
	sub	a, -14 (ix)
	jr	NC, 00130$
	ld	a, -1 (ix)
	ld	-14 (ix), a
00130$:
;src\/CheckPlayfield.h:124: if(line > upmostPieceRemoved) upmostPieceRemoved = line;
	ld	a, -13 (ix)
	sub	a, -1 (ix)
	jr	NC, 00212$
	ld	a, -1 (ix)
	ld	-13 (ix), a
00212$:
;src\/CheckPlayfield.h:117: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	inc	e
	jr	00211$
00312$:
	ld	-2 (ix), b
;src\/CheckPlayfield.h:116: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	inc	-1 (ix)
	jr	00214$
00136$:
;src\/CheckPlayfield.h:130: DrawNumber(numberPiecesRemoved, 0, 0);//test
	ld	c, -2 (ix)
	ld	b, #0x00
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	call	_DrawNumber
	pop	af
	pop	af
;src\/CheckPlayfield.h:131: DrawNumber(iteration, 0, 1);//test
	ld	c, 4 (ix)
	ld	b, #0x00
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	call	_DrawNumber
	pop	af
	pop	af
;src\/CheckPlayfield.h:132: DrawNumber(leftmostPieceRemoved, 0, 13);//test
	ld	c, -16 (ix)
	ld	b, #0x00
	ld	a, #0x0d
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	call	_DrawNumber
	pop	af
	pop	af
;src\/CheckPlayfield.h:133: DrawNumber(rightmostPieceRemoved, 0, 14);//test
	ld	c, -15 (ix)
	ld	b, #0x00
	ld	a, #0x0e
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	call	_DrawNumber
	pop	af
	pop	af
;src\/CheckPlayfield.h:134: DrawNumber(lowermostPieceRemoved, 0, 16);//test
	ld	c, -14 (ix)
	ld	b, #0x00
	ld	a, #0x10
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	call	_DrawNumber
	pop	af
	pop	af
;src\/CheckPlayfield.h:135: DrawNumber(upmostPieceRemoved, 0, 17);//test
	ld	c, -13 (ix)
	ld	b, #0x00
	ld	a, #0x11
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	call	_DrawNumber
	pop	af
	pop	af
;src\/CheckPlayfield.h:138: while(counter-- > 0) {
	ld	a, -2 (ix)
	sub	a, #0x03
	ld	a, #0x01
	jr	Z, 00628$
	xor	a, a
00628$:
	ld	-12 (ix), a
	ld	-3 (ix), #0x48
00161$:
	ld	c, -3 (ix)
	dec	-3 (ix)
	ld	a, c
	or	a, a
	jp	Z, 00163$
;src\/CheckPlayfield.h:139: word lastJiffy = JIFFY;
	ld	bc, (_JIFFY)
;src\/CheckPlayfield.h:140: while (lastJiffy == JIFFY) {
00137$:
	ld	hl, (_JIFFY)
	cp	a, a
	sbc	hl, bc
	jr	Z, 00137$
;src\/CheckPlayfield.h:145: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	ld	a, #0x0c
	sub	a, -3 (ix)
	ld	a, #0x00
	rla
	ld	-11 (ix), a
	ld	a, #0x09
	sub	a, -3 (ix)
	ld	a, #0x00
	rla
	ld	-10 (ix), a
	ld	a, #0x06
	sub	a, -3 (ix)
	ld	a, #0x00
	rla
	ld	-9 (ix), a
	ld	a, #0x03
	sub	a, -3 (ix)
	ld	a, #0x00
	rla
	ld	-8 (ix), a
	ld	-2 (ix), #0
00220$:
	ld	a, -2 (ix)
	sub	a, #0x0c
	jr	NC, 00161$
;src\/CheckPlayfield.h:146: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	ld	-1 (ix), #0
00217$:
	ld	a, -1 (ix)
	sub	a, #0x06
	jp	NC, 00221$
;src\/CheckPlayfield.h:148: if((playfield[col][line] & REMOVING_FLAG) != 0) {
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	de, #_playfield
	add	hl, de
	ld	e, -2 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	rlca
	jp	NC,00218$
;src\/CheckPlayfield.h:153: if(numberPiecesRemoved == 3) {
	ld	a, -12 (ix)
	or	a, a
	jp	Z, 00141$
;src\/CheckPlayfield.h:154: x = (PLAYFIELD_HORIZ_OFFSET * 8) + (((rightmostPieceRemoved * 16) - (leftmostPieceRemoved * 16)) / 2) + (leftmostPieceRemoved * 16);
	ld	l, -15 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	ld	c, h
	ld	l, -16 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	sub	a, l
	ld	-7 (ix), a
	ld	a, c
	sbc	a, h
	ld	-6 (ix), a
	ld	a, -7 (ix)
	ld	-5 (ix), a
	ld	a, -6 (ix)
	ld	-4 (ix), a
	bit	7, -6 (ix)
	jr	Z, 00233$
	ld	a, -7 (ix)
	add	a, #0x01
	ld	-5 (ix), a
	ld	a, -6 (ix)
	adc	a, #0x00
	ld	-4 (ix), a
00233$:
	ld	c, -5 (ix)
	ld	b, -4 (ix)
	sra	b
	rr	c
	ld	a, c
	add	a, #0x50
	ld	l, -16 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	a, l
	ld	e, a
;src\/CheckPlayfield.h:155: y = (((lowermostPieceRemoved * 16) - (upmostPieceRemoved * 16)) / 2) + (upmostPieceRemoved * 16) - (72 - counter);
	ld	l, -14 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	l, -13 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, c
	sub	a, l
	ld	l, a
	ld	a, b
	sbc	a, h
	ld	h, a
	ld	c, l
	ld	b, h
	bit	7, h
	jr	Z, 00234$
	ld	c, l
	ld	b, h
	inc	bc
00234$:
	sra	b
	rr	c
	ld	l, -13 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, -3 (ix)
	ld	a, #0x48
	sub	a, c
	ld	c, a
	ld	a, l
	sub	a, c
;src\/CheckPlayfield.h:156: DrawHitSprite(x, y);
	ld	d,a
	push	de
	call	_DrawHitSprite
	pop	af
00141$:
;src\/CheckPlayfield.h:160: if(counter > 12) {
	ld	a, -11 (ix)
	or	a, a
	jr	Z, 00155$
;src\/CheckPlayfield.h:161: if(JIFFY & 0b00000011) {
	ld	hl, (_JIFFY)
	ld	a, l
	and	a, #0x03
	jr	Z, 00143$
;src\/CheckPlayfield.h:162: DrawBlock(col, line, playfield[col][line] & 0b01111111);
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	de, #_playfield
	add	hl, de
	ld	e, -2 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	res	7, a
	push	af
	inc	sp
	ld	h, -2 (ix)
	ld	l, -1 (ix)
	push	hl
	call	_DrawBlock
	pop	af
	inc	sp
	jr	00218$
00143$:
;src\/CheckPlayfield.h:165: DrawBlock(col, line, EMPTY);
	xor	a, a
	push	af
	inc	sp
	ld	h, -2 (ix)
	ld	l, -1 (ix)
	push	hl
	call	_DrawBlock
	pop	af
	inc	sp
	jr	00218$
00155$:
;src\/CheckPlayfield.h:170: if(counter > 9) DrawBlock_SameTile(col, line, DUST_1);
	ld	a, -10 (ix)
	or	a, a
	jr	Z, 00152$
	ld	h, #0x2a
	ld	l, -2 (ix)
	push	hl
	ld	a, -1 (ix)
	push	af
	inc	sp
	call	_DrawBlock_SameTile
	pop	af
	inc	sp
	jr	00218$
00152$:
;src\/CheckPlayfield.h:171: else if(counter > 6) DrawBlock_SameTile(col, line, DUST_1 + 1);
	ld	a, -9 (ix)
	or	a, a
	jr	Z, 00149$
	ld	h, #0x2b
	ld	l, -2 (ix)
	push	hl
	ld	a, -1 (ix)
	push	af
	inc	sp
	call	_DrawBlock_SameTile
	pop	af
	inc	sp
	jr	00218$
00149$:
;src\/CheckPlayfield.h:172: else if(counter > 3) DrawBlock_SameTile(col, line, DUST_1 + 2);
	ld	a, -8 (ix)
	or	a, a
	jr	Z, 00146$
	ld	h, #0x2c
	ld	l, -2 (ix)
	push	hl
	ld	a, -1 (ix)
	push	af
	inc	sp
	call	_DrawBlock_SameTile
	pop	af
	inc	sp
	jr	00218$
00146$:
;src\/CheckPlayfield.h:173: else DrawBlock_SameTile(col, line, DUST_1 + 3);
	ld	h, #0x2d
	ld	l, -2 (ix)
	push	hl
	ld	a, -1 (ix)
	push	af
	inc	sp
	call	_DrawBlock_SameTile
	pop	af
	inc	sp
00218$:
;src\/CheckPlayfield.h:146: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	inc	-1 (ix)
	jp	00217$
00221$:
;src\/CheckPlayfield.h:145: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	inc	-2 (ix)
	jp	00220$
00163$:
;src\/CheckPlayfield.h:181: HideHitSprite();
	call	_HideHitSprite
;src\/CheckPlayfield.h:186: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	ld	-3 (ix), #0
00229$:
	ld	a, -3 (ix)
	sub	a, #0x0c
	jp	NC, 00172$
;src\/CheckPlayfield.h:187: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	ld	-2 (ix), #0
00226$:
	ld	a, -2 (ix)
	sub	a, #0x06
	jp	NC, 00230$
;src\/CheckPlayfield.h:189: if((playfield[col][line] & REMOVING_FLAG) != 0) {
	ld	c, -2 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfield
	add	hl, de
	ld	-5 (ix), l
	ld	-4 (ix), h
	ld	a, -5 (ix)
	add	a, -3 (ix)
	ld	c, a
	ld	a, -4 (ix)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	rlca
	jp	NC,00227$
;src\/CheckPlayfield.h:191: blocksRemoved++;
	ld	hl, (_blocksRemoved)
	inc	hl
	ld	(_blocksRemoved), hl
;src\/CheckPlayfield.h:194: for(byte line1 = line; line1 > 0; line1--) {
	ld	a, -5 (ix)
	ld	-9 (ix), a
	ld	a, -4 (ix)
	ld	-8 (ix), a
	ld	a, -3 (ix)
	ld	-1 (ix), a
00223$:
	ld	a, -1 (ix)
	or	a, a
	jr	Z, 00227$
;src\/CheckPlayfield.h:195: byte linesToBeRemoved = 1;
	ld	c, #0x01
;src\/CheckPlayfield.h:196: if((playfield[col][line1 - 1] & REMOVING_FLAG) != 0) linesToBeRemoved++;
	ld	a, -1 (ix)
	ld	-4 (ix), a
	dec	a
	add	a, -9 (ix)
	ld	e, a
	ld	a, #0x00
	adc	a, -8 (ix)
	ld	d, a
	ld	a, (de)
	rlca
	jr	NC, 00165$
	ld	c, #0x02
00165$:
;src\/CheckPlayfield.h:197: if((playfield[col][line1 - 2] & REMOVING_FLAG) != 0) linesToBeRemoved++;
	ld	a, -4 (ix)
	dec	a
	dec	a
	add	a, -9 (ix)
	ld	e, a
	ld	a, #0x00
	adc	a, -8 (ix)
	ld	d, a
	ld	a, (de)
	rlca
	jr	NC, 00167$
	inc	c
00167$:
;src\/CheckPlayfield.h:201: playfield[col][line1] = (line1 - linesToBeRemoved >= 0) ? playfield[col][line1 - linesToBeRemoved] : EMPTY;
	ld	a, -9 (ix)
	add	a, -1 (ix)
	ld	-7 (ix), a
	ld	a, -8 (ix)
	adc	a, #0x00
	ld	-6 (ix), a
	ld	l, -1 (ix)
	ld	h, #0x00
	ld	e, c
	ld	d, #0x00
	cp	a, a
	sbc	hl, de
	bit	7, h
	jr	NZ, 00237$
	ld	a, -1 (ix)
	sub	a, c
	add	a, -9 (ix)
	ld	c, a
	ld	a, #0x00
	adc	a, -8 (ix)
	ld	b, a
	ld	a, (bc)
	ld	-5 (ix), a
	ld	-4 (ix), #0
	jr	00238$
00237$:
	xor	a, a
	ld	-5 (ix), a
	ld	-4 (ix), a
00238$:
	ld	a, -5 (ix)
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	(hl), a
;src\/CheckPlayfield.h:194: for(byte line1 = line; line1 > 0; line1--) {
	dec	-1 (ix)
	jp	00223$
00227$:
;src\/CheckPlayfield.h:187: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	inc	-2 (ix)
	jp	00226$
00230$:
;src\/CheckPlayfield.h:186: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	inc	-3 (ix)
	jp	00229$
00172$:
;src\/CheckPlayfield.h:208: oldLevel = level;
	ld	a, (#_level + 0)
	ld	c, a
;src\/CheckPlayfield.h:209: if(blocksRemoved >= 90) {
	ld	hl, #_blocksRemoved
	ld	b, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, b
	sub	a, #0x5a
	ld	a, d
	sbc	a, #0x00
	jr	C, 00180$
;src\/CheckPlayfield.h:210: level = (blocksRemoved / 30) + 1;
	push	bc
	ld	hl, #0x001e
	push	hl
	ld	e, b
	push	de
	call	__divuint
	pop	af
	pop	af
	pop	bc
	ld	a, l
	inc	a
	ld	(_level+0), a
;src\/CheckPlayfield.h:211: speed = 15;
	ld	hl, #_speed
	ld	(hl), #0x0f
	jr	00181$
00180$:
;src\/CheckPlayfield.h:214: else if(blocksRemoved >= 60) { 
	ld	a, b
	sub	a, #0x3c
	ld	a, d
	sbc	a, #0x00
	jr	C, 00177$
;src\/CheckPlayfield.h:215: level = 3;
	ld	hl, #_level
	ld	(hl), #0x03
;src\/CheckPlayfield.h:216: speed = 30;
	ld	hl, #_speed
	ld	(hl), #0x1e
	jr	00181$
00177$:
;src\/CheckPlayfield.h:218: else if(blocksRemoved >= 30) { 
	ld	a, b
	sub	a, #0x1e
	ld	a, d
	sbc	a, #0x00
	jr	C, 00174$
;src\/CheckPlayfield.h:219: level = 2;
	ld	hl, #_level
	ld	(hl), #0x02
;src\/CheckPlayfield.h:220: speed = 45;
	ld	hl, #_speed
	ld	(hl), #0x2d
	jr	00181$
00174$:
;src\/CheckPlayfield.h:223: level = 1;
	ld	hl, #_level
	ld	(hl), #0x01
;src\/CheckPlayfield.h:224: speed = 60;
	ld	hl, #_speed
	ld	(hl), #0x3c
00181$:
;src\/CheckPlayfield.h:227: if(oldLevel != level) {
	ld	a,(#_level + 0)
	sub	a, c
	jr	Z, 00183$
;src\/CheckPlayfield.h:228: newLevel = TRUE;
	ld	hl, #_newLevel
	ld	(hl), #0x01
00183$:
;src\/CheckPlayfield.h:232: DrawPlayfield();
	call	_DrawPlayfield
;src\/CheckPlayfield.h:236: CheckIfPlayfieldIsValid(); // test
	call	_CheckIfPlayfieldIsValid
;src\/CheckPlayfield.h:238: DrawScore();
	call	_DrawScore
;src\/CheckPlayfield.h:240: iteration++;
	inc	4 (ix)
;src\/CheckPlayfield.h:241: CheckPlayfield(iteration);  
	ld	a, 4 (ix)
	push	af
	inc	sp
	call	_CheckPlayfield
00231$:
;src\/CheckPlayfield.h:246: }
	ld	sp, ix
	pop	ix
	ret
;src\/GameLogic.h:3: byte RandomIndex() {
;	---------------------------------
; Function RandomIndex
; ---------------------------------
_RandomIndex::
;src\/GameLogic.h:5: do {
00101$:
;src\/GameLogic.h:6: random = GetRandom() & 0b00000111; // AND mask to get a value in the 0-7 range
	call	_GetRandom
	ld	a, l
	and	a, #0x07
	ld	l, a
;src\/GameLogic.h:8: while(random > 4); // Get a number between 0 and 4
	ld	a, #0x04
	sub	a, l
	jr	C, 00101$
;src\/GameLogic.h:10: return random;
;src\/GameLogic.h:11: }
	ret
;src\/GameLogic.h:13: void RandomPiece() {
;	---------------------------------
; Function RandomPiece
; ---------------------------------
_RandomPiece::
;src\/GameLogic.h:14: topPiece = pieces[RandomIndex()];
	ld	bc, #_pieces+0
	push	bc
	call	_RandomIndex
	pop	bc
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(_topPiece+0), a
;src\/GameLogic.h:15: midPiece = pieces[RandomIndex()];
	push	bc
	call	_RandomIndex
	pop	bc
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(_midPiece+0), a
;src\/GameLogic.h:16: bottomPiece = pieces[RandomIndex()];
	push	bc
	call	_RandomIndex
	pop	bc
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(_bottomPiece+0), a
;src\/GameLogic.h:17: }
	ret
;src\/GameLogic.h:19: void UpdateAndDrawPieceStatic() {
;	---------------------------------
; Function UpdateAndDrawPieceStatic
; ---------------------------------
_UpdateAndDrawPieceStatic::
;src\/GameLogic.h:22: playfield[col][line] = topPiece;
	ld	bc, #_playfield+0
	ld	de, (_col)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ex	de, hl
	ld	a, (#_line + 0)
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	a,(#_topPiece + 0)
	ld	(hl), a
;src\/GameLogic.h:23: playfield[col][line + 1] = midPiece;
	ld	de, (_col)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ex	de, hl
	ld	a, (#_line + 0)
	ld	l, a
	inc	l
	ld	h, #0x00
	add	hl, de
	ld	a,(#_midPiece + 0)
	ld	(hl), a
;src\/GameLogic.h:24: playfield[col][line + 2] = bottomPiece;
	ld	de, (_col)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ex	de, hl
	ld	a, (#_line + 0)
	ld	l, a
	inc	l
	inc	l
	ld	h, #0x00
	add	hl, de
	ld	a,(#_bottomPiece + 0)
	ld	(hl), a
;src\/GameLogic.h:25: DrawPiece(line);
	push	bc
	ld	a,(#_line + 0)
	push	af
	inc	sp
	call	_DrawPiece
	inc	sp
	pop	bc
;src\/GameLogic.h:28: col = INITIAL_COL;
	ld	a, #0x02
	ld	(#_col), a
;src\/GameLogic.h:29: line = INITIAL_LINE;
;src\/GameLogic.h:31: counter = 0;
	ld	a,#0x00
	ld	(#_line),a
	ld	(#_counter), a
;src\/GameLogic.h:34: if(playfield[col][line] != EMPTY ||
	ld	a, (#_playfield + 24)
	or	a, a
	jr	NZ, 00101$
;src\/GameLogic.h:35: playfield[col][line + 1] != EMPTY ||
	ld	a, (#_playfield + 25)
	or	a, a
	jr	NZ, 00101$
;src\/GameLogic.h:36: playfield[col][line + 2] != EMPTY) {
	ld	a, (#_playfield + 26)
	or	a, a
	jr	Z, 00102$
00101$:
;src\/GameLogic.h:37: gameOver = TRUE;
	ld	iy, #_gameOver
	ld	0 (iy), #0x01
	jp	_DrawPlayfield
00102$:
;src\/GameLogic.h:40: RandomPiece();
	call	_RandomPiece
;src\/GameLogic.h:42: CheckPlayfield(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_CheckPlayfield
	inc	sp
;src\/GameLogic.h:45: DrawPlayfield();
;src\/GameLogic.h:46: }
	jp	_DrawPlayfield
;src\/GameLogic.h:48: void BlinkPauseText() {
;	---------------------------------
; Function BlinkPauseText
; ---------------------------------
_BlinkPauseText::
;src\/GameLogic.h:49: if(JIFFY & 0b00001000) {
	ld	hl, (_JIFFY)
	bit	3, l
	jr	Z, 00102$
;src\/GameLogic.h:50: DrawString("PAUSE", 13, 12);
	ld	de, #0x0c0d
	push	de
	ld	hl, #___str_4
	push	hl
	call	_DrawString
	pop	af
	pop	af
	ret
00102$:
;src\/GameLogic.h:55: DrawLine(6);
	ld	a, #0x06
	push	af
	inc	sp
	call	_DrawLine
	inc	sp
;src\/GameLogic.h:58: }
	ret
___str_4:
	.ascii "PAUSE"
	.db 0x00
;src\/GameLogic.h:60: void Pause() {
;	---------------------------------
; Function Pause
; ---------------------------------
_Pause::
;src\/GameLogic.h:63: DrawString("PAUSE", 13, 12);
	ld	de, #0x0c0d
	push	de
	ld	hl, #___str_5
	push	hl
	call	_DrawString
	pop	af
	pop	af
;src\/GameLogic.h:65: while(TRUE) {
00114$:
;src\/GameLogic.h:67: BlinkPauseText();
	call	_BlinkPauseText
;src\/GameLogic.h:70: keyboard = SNSMAT(7);
	ld	l, #0x07
	call	_SNSMAT
;src\/GameLogic.h:71: if((keyboard & 0b00000100) != 0) {
	bit	2, l
	jr	Z, 00114$
;src\/GameLogic.h:73: while(TRUE) {
00109$:
;src\/GameLogic.h:75: BlinkPauseText();
	call	_BlinkPauseText
;src\/GameLogic.h:78: keyboard = SNSMAT(7);
	ld	l, #0x07
	call	_SNSMAT
;src\/GameLogic.h:79: if((keyboard & 0b00000100) == 0) {
	bit	2, l
	jr	NZ, 00109$
;src\/GameLogic.h:81: while(TRUE) {
00104$:
;src\/GameLogic.h:83: BlinkPauseText();
	call	_BlinkPauseText
;src\/GameLogic.h:86: keyboard = SNSMAT(7);
	ld	l, #0x07
	call	_SNSMAT
;src\/GameLogic.h:87: if((keyboard & 0b00000100) != 0) {
	bit	2, l
	jr	Z, 00104$
;src\/GameLogic.h:89: DrawLine(6);
	ld	a, #0x06
	push	af
	inc	sp
	call	_DrawLine
	inc	sp
;src\/GameLogic.h:90: return;
;src\/GameLogic.h:100: }
	ret
___str_5:
	.ascii "PAUSE"
	.db 0x00
;src\/GameLogic.h:102: void GameLoop() {
;	---------------------------------
; Function GameLoop
; ---------------------------------
_GameLoop::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-13
	add	hl, sp
	ld	sp, hl
;src\/GameLogic.h:105: byte lastJoystick_LeftRight = STCK_none, lastJoystick_UpDown = STCK_none;
	ld	-1 (ix), #0
	ld	-13 (ix), #0
;src\/GameLogic.h:106: byte lastBtn1 = 0, lastBtn2 = 0;
	ld	-12 (ix), #0
	ld	-11 (ix), #0
;src\/GameLogic.h:109: while(!gameOver) {
00150$:
	ld	a,(#_gameOver + 0)
	or	a, a
	jp	NZ, 00152$
;src\/GameLogic.h:111: word lastJiffy = JIFFY;
	ld	bc, (_JIFFY)
;src\/GameLogic.h:113: while (lastJiffy == JIFFY) {
00101$:
	ld	hl, (_JIFFY)
	cp	a, a
	sbc	hl, bc
	jr	Z, 00101$
;src\/GameLogic.h:122: playfield[col][line] = EMPTY;
	ld	bc, (_col)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfield
	add	hl, de
	ex	de, hl
	ld	iy, #_line
	ld	l, 0 (iy)
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x00
;src\/GameLogic.h:123: playfield[col][line + 1] = EMPTY;
	ld	bc, (_col)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfield
	add	hl, de
	ex	de, hl
	ld	l, 0 (iy)
	inc	l
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x00
;src\/GameLogic.h:124: playfield[col][line + 2] = EMPTY;
	ld	bc, (_col)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfield
	add	hl, de
	ex	de, hl
	ld	l, 0 (iy)
	inc	l
	inc	l
	ld	h, #0x00
	add	hl, de
	ld	(hl), #0x00
;src\/GameLogic.h:127: joystick = GTSTCK(STCK_Joy1);
	ld	l, #0x01
	call	_GTSTCK
	ld	-10 (ix), l
;src\/GameLogic.h:128: btn1 = GTTRIG(TRIG_Joy1_A);
	ld	l, #0x01
	call	_GTTRIG
	ld	-9 (ix), l
;src\/GameLogic.h:129: btn2 = GTTRIG(TRIG_Joy1_B);
	ld	l, #0x03
	call	_GTTRIG
	ld	-8 (ix), l
;src\/GameLogic.h:131: if(joystick == STCK_none) {
	ld	a, -10 (ix)
;src\/GameLogic.h:132: joystick = GTSTCK(STCK_Cursors);
	or	a,a
	jr	NZ, 00105$
	ld	l,a
	call	_GTSTCK
	ld	-10 (ix), l
00105$:
;src\/GameLogic.h:122: playfield[col][line] = EMPTY;
	ld	iy, #_line
	ld	a, 0 (iy)
	ld	-7 (ix), a
;src\/GameLogic.h:135: if(lastJoystick_LeftRight == STCK_none) {
	ld	a, -1 (ix)
	or	a, a
	jp	NZ, 00118$
;src\/GameLogic.h:123: playfield[col][line + 1] = EMPTY;
	ld	a, 0 (iy)
	ld	-1 (ix), a
;src\/GameLogic.h:140: playfield[col - 1][line] == EMPTY && 
	ld	iy, #_col
	ld	a, 0 (iy)
	ld	-6 (ix), a
;src\/GameLogic.h:141: playfield[col - 1][line + 2] == EMPTY) {
	ld	a, -1 (ix)
	add	a, #0x02
	ld	-5 (ix), a
;src\/GameLogic.h:138: if (joystick == STCK_W && 
	ld	a, -10 (ix)
	sub	a, #0x07
	jr	NZ, 00112$
;src\/GameLogic.h:139: col > 0 && 
	ld	a, 0 (iy)
	or	a, a
	jr	Z, 00112$
;src\/GameLogic.h:140: playfield[col - 1][line] == EMPTY && 
	ld	a, -6 (ix)
	add	a, #0xff
	ld	-1 (ix), a
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, #<(_playfield)
	add	a, -2 (ix)
	ld	-4 (ix), a
	ld	a, #>(_playfield)
	adc	a, -1 (ix)
	ld	-3 (ix), a
	ld	a, -4 (ix)
	add	a, -7 (ix)
	ld	-2 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	or	a, a
	jr	NZ, 00112$
;src\/GameLogic.h:141: playfield[col - 1][line + 2] == EMPTY) {
	ld	a, -4 (ix)
	add	a, -5 (ix)
	ld	c, a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	jr	NZ, 00112$
;src\/GameLogic.h:142: col--;
	dec	0 (iy)
	jr	00118$
00112$:
;src\/GameLogic.h:144: else if (joystick == STCK_E && 
	ld	a, -10 (ix)
	sub	a, #0x03
	jr	NZ, 00118$
;src\/GameLogic.h:145: col < COLS_PLAYFIELD - 1 &&
	ld	iy, #_col
	ld	a, 0 (iy)
	sub	a, #0x05
	jr	NC, 00118$
;src\/GameLogic.h:146: playfield[col + 1][line] == EMPTY &&
	ld	a, -6 (ix)
	inc	a
	ld	-1 (ix), a
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, #<(_playfield)
	add	a, -2 (ix)
	ld	-4 (ix), a
	ld	a, #>(_playfield)
	adc	a, -1 (ix)
	ld	-3 (ix), a
	ld	a, -4 (ix)
	add	a, -7 (ix)
	ld	-2 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	or	a, a
	jr	NZ, 00118$
;src\/GameLogic.h:147: playfield[col + 1][line + 2] == EMPTY) {
	ld	a, -4 (ix)
	add	a, -5 (ix)
	ld	c, a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	jr	NZ, 00118$
;src\/GameLogic.h:148: col++;
	inc	0 (iy)
00118$:
;src\/GameLogic.h:152: if(lastJoystick_UpDown == STCK_none) {
	ld	a, -13 (ix)
	or	a, a
	jp	NZ, 00132$
;src\/GameLogic.h:156: if (joystick == STCK_N || (lastBtn1 == 0 && btn1 == 0xff) || (lastBtn2 == 0 && btn2 == 0xff)) {
	ld	a, -10 (ix)
	dec	a
	jr	Z, 00119$
	ld	a, -12 (ix)
	or	a, a
	jr	NZ, 00124$
	ld	a, -9 (ix)
	inc	a
	jr	Z, 00119$
00124$:
	ld	a, -11 (ix)
	or	a, a
	jr	NZ, 00120$
	ld	a, -8 (ix)
	inc	a
	jr	NZ, 00120$
00119$:
;src\/GameLogic.h:157: byte temp = bottomPiece;
	ld	a, (#_bottomPiece + 0)
	ld	c, a
;src\/GameLogic.h:159: bottomPiece = midPiece;
	ld	a,(#_midPiece + 0)
	ld	(#_bottomPiece),a
;src\/GameLogic.h:160: midPiece = topPiece;
	ld	a,(#_topPiece + 0)
	ld	(#_midPiece),a
;src\/GameLogic.h:161: topPiece = temp;
	ld	hl, #_topPiece
	ld	(hl), c
00120$:
;src\/GameLogic.h:165: if (joystick == STCK_S) {
	ld	a, -10 (ix)
	sub	a, #0x05
	jp	NZ,00132$
;src\/GameLogic.h:166: for(byte i = line; i < LINES_PLAYFIELD; i++) {
	ld	a, -7 (ix)
	ld	-2 (ix), a
	ld	a, -7 (ix)
	ld	-1 (ix), a
00154$:
	ld	a, -1 (ix)
	sub	a, #0x0c
	jr	NC, 00132$
;src\/GameLogic.h:167: if(i == LINES_PLAYFIELD - 3 || playfield[col][i + 3] != EMPTY) {
	ld	a, -1 (ix)
	sub	a, #0x09
	jr	Z, 00125$
	ld	bc, (_col)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	a, #<(_playfield)
	add	a, -4 (ix)
	ld	-6 (ix), a
	ld	a, #>(_playfield)
	adc	a, -3 (ix)
	ld	-5 (ix), a
	ld	a, -1 (ix)
	ld	-3 (ix), a
	inc	-3 (ix)
	inc	-3 (ix)
	inc	-3 (ix)
	ld	a, -3 (ix)
	add	a, -6 (ix)
	ld	-4 (ix), a
	ld	a, #0x00
	adc	a, -5 (ix)
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	or	a, a
	jr	Z, 00155$
00125$:
;src\/GameLogic.h:170: DrawPiece(line);
	ld	a,(#_line + 0)
	push	af
	inc	sp
	call	_DrawPiece
	inc	sp
;src\/GameLogic.h:172: line = i;
	ld	a, -2 (ix)
	ld	(#_line),a
;src\/GameLogic.h:174: UpdateAndDrawPieceStatic();
	call	_UpdateAndDrawPieceStatic
;src\/GameLogic.h:175: break;
	jr	00132$
00155$:
;src\/GameLogic.h:166: for(byte i = line; i < LINES_PLAYFIELD; i++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	ld	-2 (ix), a
	jr	00154$
00132$:
;src\/GameLogic.h:184: lastJoystick_LeftRight = joystick;
	ld	a, -10 (ix)
	ld	-1 (ix), a
;src\/GameLogic.h:185: lastJoystick_UpDown = joystick;
	ld	a, -10 (ix)
	ld	-13 (ix), a
;src\/GameLogic.h:186: lastBtn1 = btn1;
	ld	a, -9 (ix)
	ld	-12 (ix), a
;src\/GameLogic.h:187: lastBtn2 = btn2;
	ld	a, -8 (ix)
	ld	-11 (ix), a
;src\/GameLogic.h:211: keyboard = SNSMAT(7);
	ld	l, #0x07
	call	_SNSMAT
;src\/GameLogic.h:213: if((keyboard & 0b00000100) == 0) {
	bit	2, l
	jr	NZ, 00134$
;src\/GameLogic.h:214: Pause();
	call	_Pause
00134$:
;src\/GameLogic.h:219: counter++;
	ld	iy, #_counter
	inc	0 (iy)
;src\/GameLogic.h:220: if(counter == speed) {
	ld	a, 0 (iy)
	ld	hl, #_speed
	sub	a, (hl)
	jr	NZ, 00139$
;src\/GameLogic.h:222: counter = 0;
	ld	hl, #_counter
	ld	(hl), #0x00
;src\/GameLogic.h:225: DrawPiece(line);
	ld	a,(#_line + 0)
	push	af
	inc	sp
	call	_DrawPiece
	inc	sp
;src\/GameLogic.h:229: if(line == LINES_PLAYFIELD - 3 || playfield[col][line + 3] != EMPTY) {
	ld	iy, #_line
	ld	a, 0 (iy)
	sub	a, #0x09
	jr	Z, 00135$
	ld	bc, (_col)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfield
	add	hl, de
	ex	de, hl
	ld	a, 0 (iy)
	add	a, #0x03
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00136$
00135$:
;src\/GameLogic.h:231: UpdateAndDrawPieceStatic();
	call	_UpdateAndDrawPieceStatic
00136$:
;src\/GameLogic.h:234: line++;
	ld	hl, #_line
	inc	(hl)
00139$:
;src\/GameLogic.h:241: playfield[col][line] = topPiece;
	ld	bc, (_col)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfield
	add	hl, de
	ex	de, hl
	ld	a, (#_line + 0)
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	a,(#_topPiece + 0)
	ld	(hl), a
;src\/GameLogic.h:242: playfield[col][line + 1] = midPiece;
	ld	bc, (_col)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfield
	add	hl, de
	ex	de, hl
	ld	a, (#_line + 0)
	ld	l, a
	inc	l
	ld	h, #0x00
	add	hl, de
	ld	a,(#_midPiece + 0)
	ld	(hl), a
;src\/GameLogic.h:243: playfield[col][line + 2] = bottomPiece;
	ld	bc, (_col)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	hl, #_playfield
	add	hl, de
	ex	de, hl
	ld	a, (#_line + 0)
	ld	l, a
	inc	l
	inc	l
	ld	h, #0x00
	add	hl, de
	ld	a,(#_bottomPiece + 0)
	ld	(hl), a
;src\/GameLogic.h:248: DrawPiece(line);
	ld	a,(#_line + 0)
	push	af
	inc	sp
	call	_DrawPiece
	inc	sp
;src\/GameLogic.h:122: playfield[col][line] = EMPTY;
	ld	bc, (_col)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ex	de, hl
;src\/GameLogic.h:253: if(playfield[col][line + 3] != EMPTY) {
	ld	hl, #_playfield
	add	hl, de
	ex	de, hl
	ld	a,(#_line + 0)
	add	a, #0x03
	ld	c, a
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00148$
;src\/GameLogic.h:254: HideArrow();
	call	_HideArrow
	jp	00150$
00148$:
;src\/GameLogic.h:257: for(byte i = line + 3; i < LINES_PLAYFIELD; i++) {
	ld	b, c
00157$:
	ld	a, b
	sub	a, #0x0c
	jp	NC, 00150$
;src\/GameLogic.h:259: DrawArrow((col * 16) + (PLAYFIELD_HORIZ_OFFSET * 8), (i) * 16);
	ld	a,(#_col + 0)
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	ld	-2 (ix), a
;src\/GameLogic.h:258: if(i == LINES_PLAYFIELD - 1 && playfield[col][i] == EMPTY) {
	ld	l, b
	ld	h, #0x00
	add	hl, de
;src\/GameLogic.h:259: DrawArrow((col * 16) + (PLAYFIELD_HORIZ_OFFSET * 8), (i) * 16);
	ld	a, -2 (ix)
	add	a, #0x50
	ld	-2 (ix), a
;src\/GameLogic.h:258: if(i == LINES_PLAYFIELD - 1 && playfield[col][i] == EMPTY) {
	ld	l, (hl)
	ld	a, b
	sub	a,#0x0b
	jr	NZ, 00143$
	or	a,l
	jr	NZ, 00143$
;src\/GameLogic.h:259: DrawArrow((col * 16) + (PLAYFIELD_HORIZ_OFFSET * 8), (i) * 16);
	ld	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	push	af
	inc	sp
	ld	a, -2 (ix)
	push	af
	inc	sp
	call	_DrawArrow
	pop	af
;src\/GameLogic.h:260: break;
	jp	00150$
00143$:
;src\/GameLogic.h:262: else if(playfield[col][i] != EMPTY) {
	ld	a, l
	or	a, a
	jr	Z, 00158$
;src\/GameLogic.h:263: DrawArrow((col * 16) + (PLAYFIELD_HORIZ_OFFSET * 8), (i - 1) * 16);
	ld	a, c
	dec	a
	add	a, a
	add	a, a
	add	a, a
	add	a, a
	push	af
	inc	sp
	ld	a, -2 (ix)
	push	af
	inc	sp
	call	_DrawArrow
	pop	af
;src\/GameLogic.h:264: break;
	jp	00150$
00158$:
;src\/GameLogic.h:257: for(byte i = line + 3; i < LINES_PLAYFIELD; i++) {
	inc	b
	ld	c, b
	jr	00157$
00152$:
;src\/GameLogic.h:271: DrawString("GAME OVER", 12, 12);
	ld	de, #0x0c0c
	push	de
	ld	hl, #___str_6
	push	hl
	call	_DrawString
	pop	af
;src\/GameLogic.h:276: Wait(60 * 3);
	ld	hl, #0x00b4
	ex	(sp),hl
	call	_Wait
;src\/GameLogic.h:278: }
	ld	sp,ix
	pop	ix
	ret
___str_6:
	.ascii "GAME OVER"
	.db 0x00
;src\/GameLogic.h:280: void TestCase() {
;	---------------------------------
; Function TestCase
; ---------------------------------
_TestCase::
;src\/GameLogic.h:281: playfield[2][ 8] = TILE_GREEN;
	ld	hl, #(_playfield + 0x0020)
	ld	(hl), #0x04
;src\/GameLogic.h:282: playfield[2][ 9] = TILE_BLUE;
	ld	hl, #(_playfield + 0x0021)
	ld	(hl), #0x0c
;src\/GameLogic.h:284: playfield[0][10] = TILE_BLUE;
	ld	hl, #(_playfield + 0x000a)
	ld	(hl), #0x0c
;src\/GameLogic.h:285: playfield[1][10] = TILE_BLUE;
	ld	hl, #(_playfield + 0x0016)
	ld	(hl), #0x0c
;src\/GameLogic.h:286: playfield[2][10] = TILE_RED;
	ld	hl, #(_playfield + 0x0022)
	ld	(hl), #0x08
;src\/GameLogic.h:287: playfield[4][10] = TILE_RED;
	ld	hl, #(_playfield + 0x003a)
	ld	(hl), #0x08
;src\/GameLogic.h:288: playfield[5][10] = TILE_BLUE;
	ld	hl, #(_playfield + 0x0046)
	ld	(hl), #0x0c
;src\/GameLogic.h:290: playfield[0][11] = TILE_GREEN;
	ld	hl, #(_playfield + 0x000b)
	ld	(hl), #0x04
;src\/GameLogic.h:291: playfield[1][11] = TILE_GREEN;
	ld	hl, #(_playfield + 0x0017)
	ld	(hl), #0x04
;src\/GameLogic.h:292: playfield[2][11] = TILE_RED;
	ld	hl, #(_playfield + 0x0023)
	ld	(hl), #0x08
;src\/GameLogic.h:293: playfield[3][11] = TILE_BLUE;
	ld	hl, #(_playfield + 0x002f)
	ld	(hl), #0x0c
;src\/GameLogic.h:294: playfield[4][11] = TILE_RED;
	ld	hl, #(_playfield + 0x003b)
	ld	(hl), #0x08
;src\/GameLogic.h:295: playfield[5][11] = TILE_RED;
	ld	hl, #(_playfield + 0x0047)
	ld	(hl), #0x08
;src\/GameLogic.h:297: topPiece = TILE_BLUE;
	ld	a, #0x0c
	ld	(#_topPiece), a
;src\/GameLogic.h:298: midPiece = TILE_RED;
	ld	a, #0x08
	ld	(#_midPiece), a
;src\/GameLogic.h:299: bottomPiece = TILE_YELLOW;
	ld	a, #0x14
	ld	(#_bottomPiece), a
;src\/GameLogic.h:300: }
	ret
;src\/GameLogic.h:302: void InitGame() {
;	---------------------------------
; Function InitGame
; ---------------------------------
_InitGame::
;src\/GameLogic.h:304: gameOver = FALSE;
	ld	hl, #_gameOver
	ld	(hl), #0x00
;src\/GameLogic.h:305: line = INITIAL_LINE;
	ld	hl, #_line
	ld	(hl), #0x00
;src\/GameLogic.h:306: col = INITIAL_COL;
	ld	hl, #_col
	ld	(hl), #0x02
;src\/GameLogic.h:307: blocksRemoved = 0;
	ld	hl, #0x0000
	ld	(_blocksRemoved), hl
;src\/GameLogic.h:308: level = 1;
	ld	hl, #_level
	ld	(hl), #0x01
;src\/GameLogic.h:309: newLevel = FALSE;
	ld	hl, #_newLevel
	ld	(hl), #0x00
;src\/GameLogic.h:310: speed = 60;
	ld	hl, #_speed
	ld	(hl), #0x3c
;src\/GameLogic.h:312: InitVRAM();
	call	_InitVRAM
;src\/GameLogic.h:315: InitRnd(rndSeed, JIFFY * rndSeed, JIFFY * rndSeed + 99);
	ld	a, (#_rndSeed + 0)
	ld	e, a
	ld	a, (#_JIFFY + 0)
	ld	h, a
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00133$:
	add	hl, hl
	jr	NC, 00134$
	add	hl, de
00134$:
	djnz	00133$
	ld	a, l
	add	a, #0x63
	ld	c, a
	ld	a, (#_rndSeed + 0)
	ld	e, a
	ld	a, (#_JIFFY + 0)
	ld	h, a
	ld	l, #0x00
	ld	d, l
	ld	b, #0x08
00135$:
	add	hl, hl
	jr	NC, 00136$
	add	hl, de
00136$:
	djnz	00135$
	ld	a, c
	push	af
	ld	a, l
	inc	sp
	push	af
	inc	sp
	ld	a,(#_rndSeed + 0)
	push	af
	inc	sp
	call	_InitRnd
	pop	af
	inc	sp
;src\/GameLogic.h:318: RandomPiece();
	call	_RandomPiece
;src\/GameLogic.h:321: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x0c
	jr	NC, 00102$
;src\/GameLogic.h:322: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x06
	jr	NC, 00108$
;src\/GameLogic.h:323: playfield[col][line] = EMPTY;
	ld	e, b
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ld	de, #_playfield
	add	hl, de
	ld	e, c
	ld	d, #0x00
	add	hl, de
	ld	(hl), #0x00
;src\/GameLogic.h:322: for(byte col = 0; col < COLS_PLAYFIELD; col++) {
	inc	b
	jr	00104$
00108$:
;src\/GameLogic.h:321: for(byte line = 0; line < LINES_PLAYFIELD; line++) {
	inc	c
	jr	00107$
00102$:
;src\/GameLogic.h:328: TestCase();
	call	_TestCase
;src\/GameLogic.h:330: DrawBackground();
	call	_DrawBackground
;src\/GameLogic.h:332: DrawPlayfield();
	call	_DrawPlayfield
;src\/GameLogic.h:334: DrawScore();
	call	_DrawScore
;src\/GameLogic.h:336: GameLoop();
;src\/GameLogic.h:337: }
	jp	_GameLoop
;src\/Intro.h:3: void ChangeFontColor(byte color) {
;	---------------------------------
; Function ChangeFontColor
; ---------------------------------
_ChangeFontColor::
;src\/Intro.h:4: FILVRM(MSX_modedata_screen2.color + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, color);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	bc, #0x0178
	add	hl, bc
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	push	af
	inc	sp
	ld	de, #0x0300
	push	de
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
;src\/Intro.h:5: FILVRM(MSX_modedata_screen2.color + (256 * 8) + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, color);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	bc, #0x0978
	add	hl, bc
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	push	af
	inc	sp
	ld	de, #0x0300
	push	de
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
;src\/Intro.h:6: FILVRM(MSX_modedata_screen2.color + (512 * 8) + (NUMBER_OF_PATTERNS * 8), (HICHAR - LOCHAR + 1) * 8, color);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0002) + 0)
	ld	bc, #0x1178
	add	hl, bc
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	push	af
	inc	sp
	ld	de, #0x0300
	push	de
	push	hl
	call	_FILVRM
	pop	af
	pop	af
	inc	sp
;src\/Intro.h:7: }
	ret
;src\/Intro.h:9: void ScrollDownFont() {
;	---------------------------------
; Function ScrollDownFont
; ---------------------------------
_ScrollDownFont::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;src\/Intro.h:10: word startVRAMAddr = MSX_modedata_screen2.pattern + (256 * 8) + (NUMBER_OF_PATTERNS * 8);
	ld	hl, (#(_MSX_modedata_screen2 + 0x0004) + 0)
	ld	bc, #0x0978
	add	hl, bc
;src\/Intro.h:25: for(word i=startVRAMAddr; i < (startVRAMAddr + size); i+=8) {
	ld	c, l
	ld	b, h
	ld	e, l
	ld	a, h
	add	a, #0x03
	ld	d, a
00107$:
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jr	NC, 00109$
;src\/Intro.h:26: for(word j=i+7; j>0; j--) {
	inc	sp
	inc	sp
	push	bc
	ld	a, -4 (ix)
	add	a, #0x07
	ld	l, a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-2 (ix), l
	ld	-1 (ix), a
00104$:
	ld	a, -1 (ix)
	or	a, -2 (ix)
	jr	Z, 00101$
;src\/Intro.h:27: value = RDVRM(j-1);
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	dec	hl
	push	bc
	push	de
	call	_RDVRM
	xor	a, a
	push	af
	inc	sp
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
	pop	bc
;src\/Intro.h:26: for(word j=i+7; j>0; j--) {
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	dec	hl
	ld	-2 (ix), l
	ld	-1 (ix), h
	jr	00104$
00101$:
;src\/Intro.h:31: WRTVRM(i, 0);
	push	de
	xor	a, a
	push	af
	inc	sp
	push	bc
	call	_WRTVRM
	pop	af
	inc	sp
	pop	de
;src\/Intro.h:25: for(word i=startVRAMAddr; i < (startVRAMAddr + size); i+=8) {
	ld	a, -4 (ix)
	add	a, #0x08
	ld	c, a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	b, a
	jr	00107$
00109$:
;src\/Intro.h:35: }
	ld	sp, ix
	pop	ix
	ret
;src\/Intro.h:37: void Intro() {
;	---------------------------------
; Function Intro
; ---------------------------------
_Intro::
;src\/Intro.h:41: InitVRAM();
	call	_InitVRAM
;src\/Intro.h:43: DrawString("A GAME BY", 11, 11);
	ld	de, #0x0b0b
	push	de
	ld	hl, #___str_7
	push	hl
	call	_DrawString
	pop	af
	pop	af
;src\/Intro.h:44: DrawString("ANDRE BAPTISTA", 9, 13);
	ld	de, #0x0d09
	push	de
	ld	hl, #___str_8
	push	hl
	call	_DrawString
	pop	af
;src\/Intro.h:51: ChangeFontColor(0xf0);
	ld	h,#0xf0
	ex	(sp),hl
	inc	sp
	call	_ChangeFontColor
	inc	sp
;src\/Intro.h:56: Wait(2 * 60);
	ld	hl, #0x0078
	push	hl
	call	_Wait
	pop	af
;src\/Intro.h:58: while(counter++ < 20) {
	ld	c, #0x00
00112$:
	ld	a, c
	sub	a, #0x14
	ret	NC
	inc	c
;src\/Intro.h:59: byte lastJiffy = JIFFY;
	ld	hl, #_JIFFY
	ld	b, (hl)
;src\/Intro.h:60: while (JIFFY == lastJiffy) {
00101$:
	ld	e, b
	ld	d, #0x00
	ld	hl, (_JIFFY)
	cp	a, a
	sbc	hl, de
	jr	Z, 00101$
;src\/Intro.h:63: if(counter == 15) {
	ld	a, c
	sub	a, #0x0f
	jr	NZ, 00110$
;src\/Intro.h:64: ChangeFontColor(0x40);
	push	bc
	ld	a, #0x40
	push	af
	inc	sp
	call	_ChangeFontColor
	inc	sp
	pop	bc
	jr	00112$
00110$:
;src\/Intro.h:66: else if(counter == 10) {
	ld	a, c
	sub	a, #0x0a
	jr	NZ, 00107$
;src\/Intro.h:67: ChangeFontColor(0x50);
	push	bc
	ld	a, #0x50
	push	af
	inc	sp
	call	_ChangeFontColor
	inc	sp
	pop	bc
	jr	00112$
00107$:
;src\/Intro.h:69: else if(counter == 5) {
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00112$
;src\/Intro.h:71: ChangeFontColor(0xe0);
	push	bc
	ld	a, #0xe0
	push	af
	inc	sp
	call	_ChangeFontColor
	inc	sp
	pop	bc
;src\/Intro.h:140: }
	jr	00112$
___str_7:
	.ascii "A GAME BY"
	.db 0x00
___str_8:
	.ascii "ANDRE BAPTISTA"
	.db 0x00
;src\/Title.h:14: void SetBlock(byte col, byte line, byte tileNumber) {
;	---------------------------------
; Function SetBlock
; ---------------------------------
_SetBlock::
	push	ix
	ld	ix,#0
	add	ix,sp
;src\/Title.h:15: WRTVRM(MSX_modedata_screen2.name + col + (line * 32), tileNumber);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	ld	c, 4 (ix)
	ld	b, #0x00
	add	hl, bc
	ex	de, hl
	ld	l, 5 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	a, 6 (ix)
	push	af
	inc	sp
	push	hl
	call	_WRTVRM
	pop	af
	inc	sp
;src\/Title.h:16: }
	pop	ix
	ret
;src\/Title.h:18: void TitleScreen() {
;	---------------------------------
; Function TitleScreen
; ---------------------------------
_TitleScreen::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-21
	add	hl, sp
	ld	sp, hl
;src\/Title.h:19: byte colorIndex = 0;
	ld	c, #0x00
;src\/Title.h:50: const char blocks[] = {
	ld	hl, #0
	add	hl, sp
	ex	de, hl
	ld	a, #0x8e
	ld	(de), a
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x8f
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	(hl), #0x90
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x91
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x92
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x93
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x94
;src\/Title.h:60: const char colors[] = { A, C, E, G }; // last item will be ignored
	ld	hl, #7
	add	hl, sp
	ld	-10 (ix), l
	ld	-9 (ix), h
	ld	(hl), #0x8e
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	inc	hl
	ld	(hl), #0x90
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	inc	hl
	inc	hl
	ld	(hl), #0x92
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x94
;src\/Title.h:63: InitVRAM();
	push	bc
	push	de
	call	_InitVRAM
	pop	de
	pop	bc
;src\/Title.h:65: LDIRVM(MSX_modedata_screen2.name, title, 32 * 24);
	ld	hl, (#_MSX_modedata_screen2 + 0)
	push	bc
	push	de
	ld	de, #0x0300
	push	de
	ld	de, #_TitleScreen_title_65536_275
	push	de
	push	hl
	call	_LDIRVM
	ld	hl, #6
	add	hl, sp
	ld	sp, hl
	ld	de, #0x0d05
	push	de
	ld	hl, #___str_9
	push	hl
	call	_DrawString
	pop	af
	ld	h,#0x17
	ex	(sp),hl
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	hl, #___str_10
	push	hl
	call	_DrawString
	pop	af
	pop	af
	ld	de, #0x1719
	push	de
	ld	hl, #___str_11
	push	hl
	call	_DrawString
	pop	af
	pop	af
	pop	de
	pop	bc
;src\/Title.h:71: while(TRUE) {
00120$:
;src\/Title.h:72: byte index = 0, col_1, line_1; //, col_2, line_2, col_3, line_3;
	ld	-3 (ix), #0
;src\/Title.h:76: word counter = 0;
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
;src\/Title.h:86: do {
00106$:
;src\/Title.h:93: col_1 = GetRandomInInterval(31, 0b00011111);
	push	bc
	push	de
	ld	de, #0x1f1f
	push	de
	call	_GetRandomInInterval
	pop	af
;src\/Title.h:94: line_1 = GetRandomInInterval(7, 0b00000111);
	ld	-8 (ix), l
	ld	de, #0x0707
	push	de
	call	_GetRandomInInterval
	pop	af
	pop	de
	pop	bc
	ld	-7 (ix), l
;src\/Title.h:97: value = RDVRM(MSX_modedata_screen2.name + col_1 + (line_1 * 32));
	ld	hl, (#_MSX_modedata_screen2 + 0)
	ld	a, -8 (ix)
	ld	b, #0x00
	add	a, l
	ld	-5 (ix), a
	ld	a, b
	adc	a, h
	ld	-4 (ix), a
	ld	l, -7 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, -5 (ix)
	ld	l, a
	ld	a, h
	adc	a, -4 (ix)
	ld	h, a
	push	bc
	push	de
	call	_RDVRM
	pop	de
	pop	bc
	ld	-6 (ix), l
;src\/Title.h:100: if(counter++ > 1000) {
	ld	b, -2 (ix)
	ld	l, -1 (ix)
	inc	-2 (ix)
	jr	NZ, 00192$
	inc	-1 (ix)
00192$:
	ld	a, #0xe8
	cp	a, b
	ld	a, #0x03
	sbc	a, l
	jr	NC, 00107$
;src\/Title.h:101: colorIndex++;
	inc	c
;src\/Title.h:102: if(colorIndex >= sizeof(colors) - 1) colorIndex = 0;
	ld	a, c
	sub	a, #0x03
	jr	C, 00102$
	ld	c, #0x00
00102$:
;src\/Title.h:117: counter = 0;
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00107$:
;src\/Title.h:120: while (value == EMPTY || value == colors[colorIndex + 1]);
	ld	a, -6 (ix)
	or	a, a
	jr	Z, 00106$
	ld	a, c
	inc	a
	push	af
	rla
	sbc	a, a
	ld	b, a
	pop	af
	add	a, -10 (ix)
	ld	-5 (ix), a
	ld	a, b
	adc	a, -9 (ix)
	ld	-4 (ix), a
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	b, (hl)
	ld	a, -6 (ix)
	sub	a, b
	jp	Z,00106$
;src\/Title.h:136: for(byte i=0; i < 10 + 0; i++) {
	ld	b, #0x00
00123$:
	ld	a, b
	sub	a, #0x0a
	jr	NC, 00118$
;src\/Title.h:138: word lastJiffy = JIFFY;
	ld	hl, (_JIFFY)
	ld	-2 (ix), l
	ld	-1 (ix), h
;src\/Title.h:139: while (JIFFY == lastJiffy) {
00109$:
	ld	iy, #_JIFFY
	ld	a, 0 (iy)
	sub	a, -2 (ix)
	jr	NZ, 00194$
	ld	a, 1 (iy)
	sub	a, -1 (ix)
	jr	Z, 00109$
00194$:
;src\/Title.h:144: SetBlock(col_1, line_1, blocks[index]);
	ld	l, -3 (ix)
	ld	h, #0x00
	add	hl, de
	ld	a, (hl)
	push	bc
	push	de
	push	af
	inc	sp
	ld	h, -7 (ix)
	ld	l, -8 (ix)
	push	hl
	call	_SetBlock
	pop	af
	inc	sp
	pop	de
	pop	bc
;src\/Title.h:148: if(index++ >= sizeof(blocks)) index = 0;
	ld	a, -3 (ix)
	inc	-3 (ix)
	sub	a, #0x07
	jr	C, 00113$
	ld	-3 (ix), #0
00113$:
;src\/Title.h:161: spaceBar = GTTRIG(TRIG_Spacebar);
	push	bc
	push	de
	ld	l, #0x00
	call	_GTTRIG
;src\/Title.h:162: btn1 = GTTRIG(TRIG_Joy1_A);
	ld	-1 (ix), l
	ld	l, #0x01
	call	_GTTRIG
	pop	de
	pop	bc
;src\/Title.h:163: btn2 = GTTRIG(TRIG_Joy1_B);
	push	hl
	push	bc
	push	de
	ld	l, #0x03
	call	_GTTRIG
	ld	a, l
	pop	de
	pop	bc
	pop	hl
	ld	h, a
;src\/Title.h:165: if(spaceBar == 0xff || btn1 == 0xff || btn2 == 0xff) { 
	ld	a, -1 (ix)
	inc	a
	jr	Z, 00114$
	inc	l
	jr	Z, 00114$
	inc	h
	jr	NZ, 00124$
00114$:
;src\/Title.h:166: rndSeed = JIFFY;
	ld	a,(#_JIFFY + 0)
	ld	(#_rndSeed), a
;src\/Title.h:167: return;
	jr	00125$
00124$:
;src\/Title.h:136: for(byte i=0; i < 10 + 0; i++) {
	inc	b
	jr	00123$
00118$:
;src\/Title.h:171: SetBlock(col_1, line_1, colors[colorIndex + 1]);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	ld	a, (hl)
	push	bc
	push	de
	push	af
	inc	sp
	ld	h, -7 (ix)
	ld	l, -8 (ix)
	push	hl
	call	_SetBlock
	pop	af
	inc	sp
	pop	de
	pop	bc
	jp	00120$
00125$:
;src\/Title.h:174: }
	ld	sp, ix
	pop	ix
	ret
_TitleScreen_title_65536_275:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
___str_9:
	.ascii "PRESS TRIGGER TO START"
	.db 0x00
___str_10:
	.ascii "ANDREBAPTISTA.COM.BR"
	.db 0x00
___str_11:
	.ascii "v.?.?.?"
	.db 0x00
;src\main.c:85: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src\main.c:87: while(TRUE) {
00102$:
;src\main.c:89: Intro();
	call	_Intro
;src\main.c:91: TitleScreen();
	call	_TitleScreen
;src\main.c:93: InitGame();
	call	_InitGame
;src\main.c:96: }
	jr	00102$
	.area _CODE
	.area _INITIALIZER
__xinit__gameOver:
	.db #0x00	; 0
__xinit__col:
	.db #0x00	; 0
__xinit__line:
	.db #0x00	; 0
__xinit__counter:
	.db #0x00	; 0
__xinit__blocksRemoved:
	.dw #0x0000
__xinit__level:
	.db #0x01	; 1
__xinit__newLevel:
	.db #0x00	; 0
__xinit__rndSeed:
	.db #0x00	; 0
__xinit__d_col:
	.db #0x00	; 0
__xinit__d_line:
	.db #0x00	; 0
__xinit__d_value:
	.db #0x00	; 0
	.area _CABS (ABS)
