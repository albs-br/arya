;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW64)
;--------------------------------------------------------
	.module msxbios
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _getchar
	.globl _putchar
	.globl _LOAD_REGS
	.globl _REGS
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
	.globl _MSX_version
	.globl _MSX_vdp_port_write
	.globl _MSX_vdp_port_read
	.globl _RDSLT
	.globl _WRSLT
	.globl _DISSCR
	.globl _ENASCR
	.globl _WRTVDP
	.globl _RDVRM
	.globl _WRTVRM
	.globl _SETRD
	.globl _SETWRT
	.globl _FILVRM
	.globl _LDIRMV
	.globl _LDIRVM
	.globl _CHGMOD
	.globl _CHGCLR
	.globl _CLRSPR
	.globl _INITXT
	.globl _INIT32
	.globl _INIGRP
	.globl _INIMLT
	.globl _CALPAT
	.globl _CALATR
	.globl _GSPSIZ
	.globl _GRPPRT
	.globl _GICINI
	.globl _WRTPSG
	.globl _CHSNS
	.globl _CHGET
	.globl _CHPUT
	.globl _LPTOUT
	.globl _BEEP
	.globl _CLS
	.globl _POSIT
	.globl _TOTEXT
	.globl _GTSTCK
	.globl _GTTRIG
	.globl _GTPAD
	.globl _GTPDL
	.globl _MAPXY
	.globl _FETCHC_ADDR
	.globl _RDVDP
	.globl _SNSMAT
	.globl _KILBUF
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
_REGS::
	.ds 12
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
;src\msxbios.c:32: void LOAD_REGS() {
;	---------------------------------
; Function LOAD_REGS
; ---------------------------------
_LOAD_REGS::
;src\msxbios.c:33: __asm__("ld de,(_REGS+4)");
	ld	de,(_REGS+4)
;src\msxbios.c:34: __asm__("ld bc,(_REGS+6)");
	ld	bc,(_REGS+6)
;src\msxbios.c:35: __asm__("ld a,(_REGS+9)");
	ld	a,(_REGS+9)
;src\msxbios.c:36: __asm__("ld hl,(_REGS+10)");
	ld	hl,(_REGS+10)
;src\msxbios.c:38: }
	ret
_MSX_vdp_port_read	=	0x0006
_MSX_vdp_port_write	=	0x0007
_MSX_version	=	0x002d
;src\msxbios.c:44: void RDSLT(uint8_t slot, uint16_t addr) {
;	---------------------------------
; Function RDSLT
; ---------------------------------
_RDSLT::
;src\msxbios.c:45: REGS.b.a = slot;
	ld	hl, #(_REGS + 0x0009)
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	ld	(hl), a
;src\msxbios.c:46: REGS.w.hl = addr;
	ld	hl, #(_REGS + 0x000a)
	ld	a, 1 (iy)
	inc	iy
	ld	(hl), a
	inc	hl
	ld	a, 1 (iy)
	ld	(hl), a
;src\msxbios.c:47: MSXUSR_LOAD_REGS(0x000c);
	call	_LOAD_REGS
	call	0x000c
;src\msxbios.c:48: }
	ret
;src\msxbios.c:50: void WRSLT(uint8_t slot, uint16_t addr, uint8_t value) {
;	---------------------------------
; Function WRSLT
; ---------------------------------
_WRSLT::
;src\msxbios.c:51: REGS.b.a = slot;
	ld	hl, #(_REGS + 0x0009)
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	ld	(hl), a
;src\msxbios.c:52: REGS.w.hl = addr;
	ld	hl, #(_REGS + 0x000a)
	ld	a, 1 (iy)
	inc	iy
	ld	(hl), a
	inc	hl
	ld	a, 1 (iy)
	ld	(hl), a
;src\msxbios.c:53: REGS.b.e = value;
	ld	hl, #(_REGS + 0x0004)
	ld	a, 2 (iy)
	ld	(hl), a
;src\msxbios.c:54: MSXUSR_LOAD_REGS(0x0014);
	call	_LOAD_REGS
	call	0x0014
;src\msxbios.c:55: }
	ret
;src\msxbios.c:57: void DISSCR() __z88dk_fastcall {
;	---------------------------------
; Function DISSCR
; ---------------------------------
_DISSCR::
;src\msxbios.c:58: MSXUSR(0x0041);
	call	0x0041
;src\msxbios.c:59: }
	ret
;src\msxbios.c:61: void ENASCR() __z88dk_fastcall {
;	---------------------------------
; Function ENASCR
; ---------------------------------
_ENASCR::
;src\msxbios.c:62: MSXUSR(0x0044);
	call	0x0044
;src\msxbios.c:63: }
	ret
;src\msxbios.c:65: void WRTVDP(uint16_t reg_data) __z88dk_fastcall {
;	---------------------------------
; Function WRTVDP
; ---------------------------------
_WRTVDP::
;src\msxbios.c:67: __asm__("ld b,l");
	ld	b,l
;src\msxbios.c:68: __asm__("ld c,h");
	ld	c,h
;src\msxbios.c:69: MSXUSR(0x0047);
	call	0x0047
;src\msxbios.c:70: }
	ret
;src\msxbios.c:72: uint8_t RDVRM(uint16_t addr) __z88dk_fastcall {
;	---------------------------------
; Function RDVRM
; ---------------------------------
_RDVRM::
;src\msxbios.c:74: MSXUSR(0x004a);
	call	0x004a
;src\msxbios.c:75: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:76: }
	ret
;src\msxbios.c:78: void WRTVRM(uint16_t addr, uint8_t data) {
;	---------------------------------
; Function WRTVRM
; ---------------------------------
_WRTVRM::
;src\msxbios.c:79: REGS.w.hl = addr;
	ld	hl, #(_REGS + 0x000a)
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	ld	(hl), a
	inc	hl
	ld	a, 1 (iy)
	ld	(hl), a
;src\msxbios.c:80: REGS.b.a = data;
	ld	hl, #(_REGS + 0x0009)
	ld	a, 2 (iy)
	ld	(hl), a
;src\msxbios.c:81: MSXUSR_LOAD_REGS(0x004d);
	call	_LOAD_REGS
	call	0x004d
;src\msxbios.c:82: }
	ret
;src\msxbios.c:84: void SETRD() {
;	---------------------------------
; Function SETRD
; ---------------------------------
_SETRD::
;src\msxbios.c:85: MSXUSR(0x0050);
	call	0x0050
;src\msxbios.c:86: }
	ret
;src\msxbios.c:88: void SETWRT() {
;	---------------------------------
; Function SETWRT
; ---------------------------------
_SETWRT::
;src\msxbios.c:89: MSXUSR(0x0053);
	call	0x0053
;src\msxbios.c:90: }
	ret
;src\msxbios.c:92: void FILVRM(uint16_t start, uint16_t len, uint8_t data) {
;	---------------------------------
; Function FILVRM
; ---------------------------------
_FILVRM::
;src\msxbios.c:93: REGS.w.hl = start;
	ld	hl, #(_REGS + 0x000a)
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	ld	(hl), a
	inc	hl
	ld	a, 1 (iy)
	ld	(hl), a
;src\msxbios.c:94: REGS.w.bc = len;
	ld	hl, #(_REGS + 0x0006)
	ld	a, 2 (iy)
	inc	iy
	inc	iy
	ld	(hl), a
	inc	hl
	ld	a, 1 (iy)
	ld	(hl), a
;src\msxbios.c:95: REGS.b.a = data;
	ld	hl, #(_REGS + 0x0009)
	ld	a, 2 (iy)
	ld	(hl), a
;src\msxbios.c:96: MSXUSR_LOAD_REGS(0x0056);
	call	_LOAD_REGS
	call	0x0056
;src\msxbios.c:97: }
	ret
;src\msxbios.c:99: void LDIRMV(uint8_t* mdest, uint16_t vsrc, uint16_t count) {
;	---------------------------------
; Function LDIRMV
; ---------------------------------
_LDIRMV::
	push	ix
	ld	ix,#0
	add	ix,sp
;src\msxbios.c:100: REGS.w.de = (uint16_t)mdest;
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	ld	((_REGS + 0x0004)), bc
;src\msxbios.c:101: REGS.w.hl = vsrc;
	ld	hl, #(_REGS + 0x000a)
	ld	a, 6 (ix)
	ld	(hl), a
	inc	hl
	ld	a, 7 (ix)
	ld	(hl), a
;src\msxbios.c:102: REGS.w.bc = count;
	ld	hl, #(_REGS + 0x0006)
	ld	a, 8 (ix)
	ld	(hl), a
	inc	hl
	ld	a, 9 (ix)
	ld	(hl), a
;src\msxbios.c:103: MSXUSR_LOAD_REGS(0x0059);
	call	_LOAD_REGS
	call	0x0059
;src\msxbios.c:104: }
	pop	ix
	ret
;src\msxbios.c:106: void LDIRVM(uint16_t vdest, const uint8_t* msrc, uint16_t count) {
;	---------------------------------
; Function LDIRVM
; ---------------------------------
_LDIRVM::
	push	ix
	ld	ix,#0
	add	ix,sp
;src\msxbios.c:107: REGS.w.de = vdest;
	ld	hl, #(_REGS + 0x0004)
	ld	a, 4 (ix)
	ld	(hl), a
	inc	hl
	ld	a, 5 (ix)
	ld	(hl), a
;src\msxbios.c:108: REGS.w.hl = (uint16_t)msrc;
	ld	c, 6 (ix)
	ld	b, 7 (ix)
	ld	((_REGS + 0x000a)), bc
;src\msxbios.c:109: REGS.w.bc = count;
	ld	hl, #(_REGS + 0x0006)
	ld	a, 8 (ix)
	ld	(hl), a
	inc	hl
	ld	a, 9 (ix)
	ld	(hl), a
;src\msxbios.c:110: MSXUSR_LOAD_REGS(0x005c);
	call	_LOAD_REGS
	call	0x005c
;src\msxbios.c:111: }
	pop	ix
	ret
;src\msxbios.c:113: void CHGMOD(uint8_t mode) __z88dk_fastcall {
;	---------------------------------
; Function CHGMOD
; ---------------------------------
_CHGMOD::
;src\msxbios.c:115: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:116: MSXUSR(0x005f);
	call	0x005f
;src\msxbios.c:117: }
	ret
;src\msxbios.c:119: void CHGCLR() __z88dk_fastcall {
;	---------------------------------
; Function CHGCLR
; ---------------------------------
_CHGCLR::
;src\msxbios.c:121: MSXUSR(0x0062);
	call	0x0062
;src\msxbios.c:122: }
	ret
;src\msxbios.c:124: void CLRSPR() __z88dk_fastcall {
;	---------------------------------
; Function CLRSPR
; ---------------------------------
_CLRSPR::
;src\msxbios.c:125: MSXUSR(0x0069);
	call	0x0069
;src\msxbios.c:126: }
	ret
;src\msxbios.c:128: void INITXT() __z88dk_fastcall {
;	---------------------------------
; Function INITXT
; ---------------------------------
_INITXT::
;src\msxbios.c:129: MSXUSR(0x006c);
	call	0x006c
;src\msxbios.c:130: }
	ret
;src\msxbios.c:132: void INIT32() __z88dk_fastcall {
;	---------------------------------
; Function INIT32
; ---------------------------------
_INIT32::
;src\msxbios.c:133: MSXUSR(0x006f);
	call	0x006f
;src\msxbios.c:134: }
	ret
;src\msxbios.c:136: void INIGRP() __z88dk_fastcall {
;	---------------------------------
; Function INIGRP
; ---------------------------------
_INIGRP::
;src\msxbios.c:137: MSXUSR(0x0072);
	call	0x0072
;src\msxbios.c:138: }
	ret
;src\msxbios.c:140: void INIMLT() __z88dk_fastcall {
;	---------------------------------
; Function INIMLT
; ---------------------------------
_INIMLT::
;src\msxbios.c:141: MSXUSR(0x0075);
	call	0x0075
;src\msxbios.c:142: }
	ret
;src\msxbios.c:144: uint16_t CALPAT() __z88dk_fastcall {
;	---------------------------------
; Function CALPAT
; ---------------------------------
_CALPAT::
;src\msxbios.c:145: MSXUSR(0x0084);
	call	0x0084
;src\msxbios.c:146: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:147: }
	ret
;src\msxbios.c:149: uint16_t CALATR() __z88dk_fastcall {
;	---------------------------------
; Function CALATR
; ---------------------------------
_CALATR::
;src\msxbios.c:150: MSXUSR(0x0087);
	call	0x0087
;src\msxbios.c:151: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:152: }
	ret
;src\msxbios.c:154: uint16_t GSPSIZ() __z88dk_fastcall {
;	---------------------------------
; Function GSPSIZ
; ---------------------------------
_GSPSIZ::
;src\msxbios.c:155: MSXUSR(0x008a);
	call	0x008a
;src\msxbios.c:156: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:157: }
	ret
;src\msxbios.c:159: uint16_t GRPPRT(char ch) __z88dk_fastcall {
;	---------------------------------
; Function GRPPRT
; ---------------------------------
_GRPPRT::
;src\msxbios.c:161: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:162: MSXUSR(0x008d);
	call	0x008d
;src\msxbios.c:163: }
	ret
;src\msxbios.c:165: uint16_t GICINI() __z88dk_fastcall {
;	---------------------------------
; Function GICINI
; ---------------------------------
_GICINI::
;src\msxbios.c:166: MSXUSR(0x0090);
	call	0x0090
;src\msxbios.c:167: }
	ret
;src\msxbios.c:169: uint16_t WRTPSG(uint16_t reg_data) __z88dk_fastcall {
;	---------------------------------
; Function WRTPSG
; ---------------------------------
_WRTPSG::
;src\msxbios.c:171: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:172: MSXUSR_LOAD_E();
	ld	e,h
;src\msxbios.c:174: MSXUSR(0x0093);
	call	0x0093
;src\msxbios.c:175: }
	ret
;src\msxbios.c:177: uint8_t CHSNS() __z88dk_fastcall {
;	---------------------------------
; Function CHSNS
; ---------------------------------
_CHSNS::
;src\msxbios.c:178: MSXUSR(0x009c);
	call	0x009c
;src\msxbios.c:179: MSXUSR_RTN_Z();
	ld	l,#0
	ret	nz
	inc	l
;src\msxbios.c:180: }
	ret
;src\msxbios.c:182: char CHGET() __z88dk_fastcall {
;	---------------------------------
; Function CHGET
; ---------------------------------
_CHGET::
;src\msxbios.c:183: MSXUSR(0x009f);
	call	0x009f
;src\msxbios.c:184: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:185: }
	ret
;src\msxbios.c:187: void CHPUT(char ch) __z88dk_fastcall {
;	---------------------------------
; Function CHPUT
; ---------------------------------
_CHPUT::
;src\msxbios.c:189: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:190: MSXUSR(0x00a2);
	call	0x00a2
;src\msxbios.c:191: }
	ret
;src\msxbios.c:193: void LPTOUT(char ch) __z88dk_fastcall {
;	---------------------------------
; Function LPTOUT
; ---------------------------------
_LPTOUT::
;src\msxbios.c:195: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:196: MSXUSR(0x00a5);
	call	0x00a5
;src\msxbios.c:197: }
	ret
;src\msxbios.c:199: void BEEP() __z88dk_fastcall {
;	---------------------------------
; Function BEEP
; ---------------------------------
_BEEP::
;src\msxbios.c:200: MSXUSR(0x00c0);
	call	0x00c0
;src\msxbios.c:201: }
	ret
;src\msxbios.c:203: void CLS() __z88dk_fastcall {
;	---------------------------------
; Function CLS
; ---------------------------------
_CLS::
;src\msxbios.c:204: __asm__("xor a");
	xor	a
;src\msxbios.c:205: MSXUSR(0x00c3);
	call	0x00c3
;src\msxbios.c:206: }
	ret
;src\msxbios.c:208: void POSIT(uint16_t yx) __z88dk_fastcall {
;	---------------------------------
; Function POSIT
; ---------------------------------
_POSIT::
;src\msxbios.c:210: MSXUSR(0x00c6);
	call	0x00c6
;src\msxbios.c:211: }
	ret
;src\msxbios.c:213: void TOTEXT() __z88dk_fastcall {
;	---------------------------------
; Function TOTEXT
; ---------------------------------
_TOTEXT::
;src\msxbios.c:214: MSXUSR(0x00d2);
	call	0x00d2
;src\msxbios.c:215: }
	ret
;src\msxbios.c:217: uint8_t GTSTCK(uint8_t index) __z88dk_fastcall {
;	---------------------------------
; Function GTSTCK
; ---------------------------------
_GTSTCK::
;src\msxbios.c:219: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:220: MSXUSR(0x00d5);
	call	0x00d5
;src\msxbios.c:221: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:222: }
	ret
;src\msxbios.c:224: uint8_t GTTRIG(uint8_t index) __z88dk_fastcall {
;	---------------------------------
; Function GTTRIG
; ---------------------------------
_GTTRIG::
;src\msxbios.c:226: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:227: MSXUSR(0x00d8);
	call	0x00d8
;src\msxbios.c:228: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:229: }
	ret
;src\msxbios.c:231: uint8_t GTPAD(uint8_t index) __z88dk_fastcall {
;	---------------------------------
; Function GTPAD
; ---------------------------------
_GTPAD::
;src\msxbios.c:233: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:234: MSXUSR(0x00db);
	call	0x00db
;src\msxbios.c:235: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:236: }
	ret
;src\msxbios.c:238: uint8_t GTPDL(uint8_t index) __z88dk_fastcall {
;	---------------------------------
; Function GTPDL
; ---------------------------------
_GTPDL::
;src\msxbios.c:240: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:241: MSXUSR(0x00de);
	call	0x00de
;src\msxbios.c:242: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:243: }
	ret
;src\msxbios.c:277: void MAPXY() __z88dk_fastcall {
;	---------------------------------
; Function MAPXY
; ---------------------------------
_MAPXY::
;src\msxbios.c:278: MSXUSR(0x0111);
	call	0x0111
;src\msxbios.c:279: }
	ret
;src\msxbios.c:281: uint16_t FETCHC_ADDR() __z88dk_fastcall {
;	---------------------------------
; Function FETCHC_ADDR
; ---------------------------------
_FETCHC_ADDR::
;src\msxbios.c:282: MSXUSR(0x0114);
	call	0x0114
;src\msxbios.c:283: }
	ret
;src\msxbios.c:313: uint8_t RDVDP() __z88dk_fastcall {
;	---------------------------------
; Function RDVDP
; ---------------------------------
_RDVDP::
;src\msxbios.c:314: MSXUSR(0x013e);
	call	0x013e
;src\msxbios.c:315: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:316: }
	ret
;src\msxbios.c:318: uint8_t SNSMAT(uint8_t row) __z88dk_fastcall {
;	---------------------------------
; Function SNSMAT
; ---------------------------------
_SNSMAT::
;src\msxbios.c:320: MSXUSR_LOAD_A();
	ld	a,l
;src\msxbios.c:321: MSXUSR(0x0141);
	call	0x0141
;src\msxbios.c:322: MSXUSR_RTN_A();
	ld	l,a
;src\msxbios.c:323: }
	ret
;src\msxbios.c:325: void KILBUF() __z88dk_fastcall {
;	---------------------------------
; Function KILBUF
; ---------------------------------
_KILBUF::
;src\msxbios.c:326: MSXUSR(0x0156);
	call	0x0156
;src\msxbios.c:327: }
	ret
;src\msxbios.c:330: int putchar(int ch) {
;	---------------------------------
; Function putchar
; ---------------------------------
_putchar::
;src\msxbios.c:331: CHPUT(ch);
	ld	iy, #2
	add	iy, sp
	ld	l, 0 (iy)
	call	_CHPUT
;src\msxbios.c:332: if (ch == '\n') CHPUT('\r'); // convert CR to CRLF
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	sub	a, #0x0a
	or	a, 1 (iy)
	jr	NZ, 00102$
	ld	l, #0x0d
	call	_CHPUT
00102$:
;src\msxbios.c:333: return ch;
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
;src\msxbios.c:334: }
	ret
;src\msxbios.c:335: char getchar() {
;	---------------------------------
; Function getchar
; ---------------------------------
_getchar::
;src\msxbios.c:336: char ch = CHGET();
	call	_CHGET
;src\msxbios.c:337: putchar(ch); // echo
	ld	c, l
	ld	b, #0x00
	push	hl
	push	bc
	call	_putchar
	pop	af
	pop	hl
;src\msxbios.c:338: if (ch == '\r') ch = '\n';
	ld	a, l
	sub	a, #0x0d
	ret	NZ
	ld	l, #0x0a
;src\msxbios.c:339: return ch;
;src\msxbios.c:340: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
