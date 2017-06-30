
_Lcd_Port_Init:

;Libs/LCD_1.mbas,79 :: 		sub procedure Lcd_Port_Init()
;Libs/LCD_1.mbas,105 :: 		DDC6_bit =1   DDB0_bit =1
	IN         R27, DDC6_bit+0
	SBR        R27, BitMask(DDC6_bit+0)
	OUT        DDC6_bit+0, R27
	IN         R27, DDB0_bit+0
	SBR        R27, BitMask(DDB0_bit+0)
	OUT        DDB0_bit+0, R27
;Libs/LCD_1.mbas,106 :: 		DDB4_bit =1   DDB5_bit =1  ' configure PORTD as output
	IN         R27, DDB4_bit+0
	SBR        R27, BitMask(DDB4_bit+0)
	OUT        DDB4_bit+0, R27
	IN         R27, DDB5_bit+0
	SBR        R27, BitMask(DDB5_bit+0)
	OUT        DDB5_bit+0, R27
;Libs/LCD_1.mbas,107 :: 		DDB6_bit =1   DDB7_bit =1
	IN         R27, DDB6_bit+0
	SBR        R27, BitMask(DDB6_bit+0)
	OUT        DDB6_bit+0, R27
	IN         R27, DDB7_bit+0
	SBR        R27, BitMask(DDB7_bit+0)
	OUT        DDB7_bit+0, R27
;Libs/LCD_1.mbas,110 :: 		end sub
L_end_Lcd_Port_Init:
	RET
; end of _Lcd_Port_Init

_Lcd_0:

;Libs/LCD_1.mbas,111 :: 		sub procedure Lcd_0()
;Libs/LCD_1.mbas,112 :: 		Lcd_Init()
	PUSH       R2
	CALL       _Lcd_Init+0
;Libs/LCD_1.mbas,113 :: 		Lcd_Cmd(_LCD_CLEAR)               ' Clear display
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Libs/LCD_1.mbas,114 :: 		Lcd_Cmd(_LCD_CURSOR_OFF)          ' Cursor off
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Libs/LCD_1.mbas,116 :: 		end sub
L_end_Lcd_0:
	POP        R2
	RET
; end of _Lcd_0

Libs/LCD_1_LCD_Load:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Libs/LCD_1.mbas,120 :: 		dim i, dchar as byte
;Libs/LCD_1.mbas,121 :: 		for dchar = 0 to 4
	PUSH       R2
	LDI        R27, 0
	STD        Y+1, R27
L_Libs/LCD_1_LCD_Load4:
;Libs/LCD_1.mbas,122 :: 		LCD_Cmd(64 + (dchar * 8))               ' Select 2x16 memory location for custom character
	LDD        R16, Y+1
	LSL        R16
	LSL        R16
	LSL        R16
	SUBI       R16, 192
	MOV        R2, R16
	CALL       _Lcd_Cmd+0
;Libs/LCD_1.mbas,123 :: 		for i = 0 to 7
	LDI        R27, 0
	STD        Y+0, R27
L_Libs/LCD_1_LCD_Load9:
;Libs/LCD_1.mbas,125 :: 		case 0
	LDD        R16, Y+1
	CPI        R16, 0
	BREQ       L_Libs/LCD_1_LCD_Load38
	JMP        L_Libs/LCD_1_LCD_Load16
L_Libs/LCD_1_LCD_Load38:
;Libs/LCD_1.mbas,126 :: 		LCD_Chr_Cp(heart[i])
	LDI        R17, #lo_addr(_heart+0)
	LDI        R18, hi_addr(_heart+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L_Libs/LCD_1_LCD_Load13
L_Libs/LCD_1_LCD_Load16:
;Libs/LCD_1.mbas,127 :: 		case 1
	LDD        R16, Y+1
	CPI        R16, 1
	BREQ       L_Libs/LCD_1_LCD_Load39
	JMP        L_Libs/LCD_1_LCD_Load19
L_Libs/LCD_1_LCD_Load39:
;Libs/LCD_1.mbas,128 :: 		LCD_Chr_Cp(co[i])
	LDI        R17, #lo_addr(_co+0)
	LDI        R18, hi_addr(_co+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L_Libs/LCD_1_LCD_Load13
L_Libs/LCD_1_LCD_Load19:
;Libs/LCD_1.mbas,129 :: 		case 2
	LDD        R16, Y+1
	CPI        R16, 2
	BREQ       L_Libs/LCD_1_LCD_Load40
	JMP        L_Libs/LCD_1_LCD_Load22
L_Libs/LCD_1_LCD_Load40:
;Libs/LCD_1.mbas,130 :: 		LCD_Chr_Cp(cn[i])
	LDI        R17, #lo_addr(_cn+0)
	LDI        R18, hi_addr(_cn+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L_Libs/LCD_1_LCD_Load13
L_Libs/LCD_1_LCD_Load22:
;Libs/LCD_1.mbas,131 :: 		case 3
	LDD        R16, Y+1
	CPI        R16, 3
	BREQ       L_Libs/LCD_1_LCD_Load41
	JMP        L_Libs/LCD_1_LCD_Load25
L_Libs/LCD_1_LCD_Load41:
;Libs/LCD_1.mbas,132 :: 		LCD_Chr_Cp(cf[i])
	LDI        R17, #lo_addr(_cf+0)
	LDI        R18, hi_addr(_cf+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L_Libs/LCD_1_LCD_Load13
L_Libs/LCD_1_LCD_Load25:
;Libs/LCD_1.mbas,133 :: 		case 4
	LDD        R16, Y+1
	CPI        R16, 4
	BREQ       L_Libs/LCD_1_LCD_Load42
	JMP        L_Libs/LCD_1_LCD_Load28
L_Libs/LCD_1_LCD_Load42:
;Libs/LCD_1.mbas,134 :: 		LCD_Chr_Cp(character_b[i])
	LDI        R17, #lo_addr(_character_b+0)
	LDI        R18, hi_addr(_character_b+0)
	LDD        R16, Y+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	JMP        L_Libs/LCD_1_LCD_Load13
L_Libs/LCD_1_LCD_Load28:
L_Libs/LCD_1_LCD_Load13:
;Libs/LCD_1.mbas,136 :: 		next i
	LDD        R16, Y+0
	CPI        R16, 7
	BRNE       L_Libs/LCD_1_LCD_Load43
	JMP        L_Libs/LCD_1_LCD_Load12
L_Libs/LCD_1_LCD_Load43:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L_Libs/LCD_1_LCD_Load9
L_Libs/LCD_1_LCD_Load12:
;Libs/LCD_1.mbas,137 :: 		next dchar
	LDD        R16, Y+1
	CPI        R16, 4
	BRNE       L_Libs/LCD_1_LCD_Load44
	JMP        L_Libs/LCD_1_LCD_Load7
L_Libs/LCD_1_LCD_Load44:
	LDD        R16, Y+1
	SUBI       R16, 255
	STD        Y+1, R16
	JMP        L_Libs/LCD_1_LCD_Load4
L_Libs/LCD_1_LCD_Load7:
;Libs/LCD_1.mbas,138 :: 		end sub
L_end_LCD_Load:
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of Libs/LCD_1_LCD_Load

Libs/LCD_1_CustomChar:

;Libs/LCD_1.mbas,141 :: 		dim i as byte
;Libs/LCD_1.mbas,142 :: 		Lcd_Cmd(120)
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 120
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
	POP        R2
	POP        R3
;Libs/LCD_1.mbas,143 :: 		for i = 0 to 7
; i start address is: 18 (R18)
	LDI        R18, 0
; i end address is: 18 (R18)
L_Libs/LCD_1_CustomChar31:
;Libs/LCD_1.mbas,144 :: 		Lcd_Chr_CP(character[i])
; i start address is: 18 (R18)
	LDI        R16, #lo_addr(_character+0)
	LDI        R17, hi_addr(_character+0)
	MOV        R30, R18
	LDI        R31, 0
	ADD        R30, R16
	ADC        R31, R17
	LPM        R16, Z
	PUSH       R18
	PUSH       R3
	PUSH       R2
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R2
	POP        R3
	POP        R18
;Libs/LCD_1.mbas,145 :: 		next i
	CPI        R18, 7
	BRNE       L_Libs/LCD_1_CustomChar46
	JMP        L_Libs/LCD_1_CustomChar34
L_Libs/LCD_1_CustomChar46:
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
; i end address is: 18 (R18)
	JMP        L_Libs/LCD_1_CustomChar31
L_Libs/LCD_1_CustomChar34:
;Libs/LCD_1.mbas,146 :: 		Lcd_Cmd(_LCD_RETURN_HOME)
	PUSH       R3
	PUSH       R2
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
	POP        R2
	POP        R3
;Libs/LCD_1.mbas,147 :: 		Lcd_Chr(pos_row, pos_char, 7)
	PUSH       R3
	PUSH       R2
	LDI        R27, 7
	MOV        R4, R27
	CALL       _Lcd_Chr+0
	POP        R2
	POP        R3
;Libs/LCD_1.mbas,148 :: 		end sub
L_end_CustomChar:
	POP        R4
	RET
; end of Libs/LCD_1_CustomChar

_Libs/LCD_1_?main:

;Libs/LCD_1.mbas,151 :: 		end.
L_end_Libs/LCD_1_?main:
	RET
; end of _Libs/LCD_1_?main
