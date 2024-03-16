
ORG  $2000        
BEGIN:          ;this is where execution starts(boot ram)

	LDA #$00        ; re-hide vector ram overlay
	STA $4020 

	; check for supported NSf version
	LDA $8005
	CMP #$01
	BNE ERR


	; check for ntsc tune...we dont support PAL(maybe in the future?)
	LDA $807A
	CMP #$01
	BNE ERR

	; we only support play call rates close to apu irq (maybe in the future using a custom timer running at 1Mhz??)
	LDA $806F
	CMP #$41
	BNE ERR

;	setup nes mixer..
	LDA $807B
	STA APUMIXCTRL





; copy the file header(wont be accessible after bank switching...)
define	SOURCEPTRL $FB
define	SOURCEPTH $FC
define	DESTPTRL $FD
define	DESTPTRH $FE

    	LDA #$00
   	STA $FB
    	LDA #$80
    	STA $FC
    	LDA #$00
    	STA $FD
    	LDA #$2E
    	STA $FE
	LDY #$0

NSFHEADERLOOP:
	LDA ($FB),Y
	STA ($FD),Y
	INY
	CPY #$80
	BNE NSFHEADERLOOP



	; check for bank switch settings
	LDA #$00
	STA $FD
	LDA #$2E
	STA $FE
	LDY #$70

NSFBKSWCHECKLOOP:
	LDA ($FB),Y
	BNE BANKWASNOTZERO
	INY
	CPY #$77
	BNE NSFBKSWCHECKLOOP

	; all bank switch init bytes were zero, do not use bank switching...setup linear memory map
	LDA #$00
	STA BKSWPAGENUMS
	LDA #$01
	STA BKSWPAGENUMS+1
	LDA #$02
	STA BKSWPAGENUMS+2
	LDA #$03
	STA BKSWPAGENUMS+3
	LDA #$04
	STA BKSWPAGENUMS+4
	LDA #$05
	STA BKSWPAGENUMS+5
	LDA #$06
	STA BKSWPAGENUMS+6
	LDA #$07
	STA BKSWPAGENUMS+7

	JMP BKSWTABLEDONE

BANKWASNOTZERO:
	; load initial bank switch settings...
	LDA #$70
	STA $FB
	LDA #$2E
	STA $FC
	LDA #$F8
	STA $FD
	LDA #$5F
	STA $FE
	LDY #$0

NSFBKSWCHECKLOOP:
	LDA ($FB),Y
	STA ($FD),Y
	INY
	CPY #$7
	BNE NSFBKSWCHECKLOOP

BKSWTABLEDONE:
; bank table is done, now calculate required offset as given in nsf header
; offset required is: OFF = $80 - (LOAD_ADDR - $8000)

; use ZP 0 for high byte of load address with cleared highest bit

	LDA #$0
	STA $0

	SEC ; no borrow
	LDA #$80
	SBC HDRLOADADDRL
	STA BKSWOFFSL
	LDA HDRLOADADDRH
	; strip away highest bit
	AND #$7F
	STA $0
	LDA #$0
	SBC $0
	STA BKSWOFFSM
	LDA #$0
	SBC #$0
	STA BKSWOFFSH


	; setup apu registers....
	LDA #$00
	STA $FD
	LDA #$40
	STA $FE
	LDY #$0
	LDA #$0

CLEARAPULOOP:
	STA ($FD),Y
	INY
	CPY #$13
	BNE CLEARAPULOOP


	LDA #$0F
	STA APUSTATUSREG
	LDA #$40
	STA FRAMECTRCTRL

	; call init routine
	; self modifying code madness.....
	LDA HDRINITADDRL
	STA $2101
	LDA HDRINITADDRH
	STA $2102



	; setup A, X
	LDA #$0
	LDX #$0 ; for NTSC tune....
	LDY #$0

	; clear used ram
	STA $FD
	STA $FE
	STA $FF
	STA $FC
	STA $FB
	STA $0
	; now branch to init
	JMP INITJSRLOCATION
	ORG $2100
	INITJSRLOCATION:
	JSR $0000


	; setup interrupt-triggered call of play routine
	LDA #$00
	STA IRQSHADOWREGL
	STA CURRENTLYINPLAYROUT
	LDA #$23
	STA IRQSHADOWREGH
	; modify call address
	LDA HDRPLAYADDRL
	STA $2316
	LDA HDRPLAYADDRH
	ORA #$80
	STA $2317
	; enable frame interrupt
	LDA #$00
	STA FRAMECTRCTRL
	CLI


	; enable interrupts and enter an endless loop
WAITLOOP:
	JMP WAITLOOP

; irq handler ____ WARNING: ANY CHANGEs IN HERE NEED To REFLECTED IN MODIFICATION OF PLAY ROUTINE START ADDRESS MODIFICATION ________
ORG $2300
	
	SEI
	
	; clear frame interrupt
	LDA APUSTATUSREG

	; disable vector overlay (just write to the overlay RAM once...)
	LDA #$00
	STA $4021

	

	; check if we managed to finishe the play routine before the current interrupt came in
	LDA CURRENTLYINPLAYROUT
	CMP #$0
	; no? dont call it again
	BNE ISRDONE

	; we are okay to run the play routine
	LDA #$01
	STA CURRENTLYINPLAYROUT

	; actual play routine call
	JSR $0000

	LDA #$00
	STA CURRENTLYINPLAYROUT

	ISRDONE:
	
	CLI
	RTI


ERR:

ERRLOOP:
JMP ERRLOOP

ORG $2E00
DB 0,0,0,0,0
HDRVERNUM:
DB 0
HDRTOTALSONGNUM:
DB 0
HDRSTARTSONGNUM:
DB 0
HDRLOADADDRL:
DB 0
HDRLOADADDRH:
DB 0
HDRINITADDRL:
DB 0
HDRINITADDRH:
DB 0
HDRPLAYADDRL:
DB 0
HDRPLAYADDRH:
DB 0
ORG $2E6E
HDRNTSCSPEED:
DW 0
HDRBANKS:
DB 0,0,0,0,0,0,0,0
HDRPALSPEED:
DW 0

CURRENTLYINPLAYROUT:
DB 0


ORG $5FF0
BKSWOFFSL:
DB 0
BKSWOFFSM:
DB 0
BKSWOFFSH:
DB 0
APUMIXCTRL:
DB 0
DB 0, 0, 0, 0
BKSWPAGENUMS:
DB 0, 0, 0, 0, 0, 0, 0, 0

ORG $4015
APUSTATUSREG:
DB 0

ORG $4017
FRAMECTRCTRL:
DB 0

ORG $4020
DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
NMISHADOWREGL:
DB 0
NMISHADOWREGH:
DB 0
RESSHADOWREGL:
DB 0
RESSHADOWREGH:
DB 0
IRQSHADOWREGL:
DB 0
IRQSHADOWREGH:
DB 0


