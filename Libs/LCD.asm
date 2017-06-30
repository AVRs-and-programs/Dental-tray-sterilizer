
_Lcd_Port_Init:

;Libs/LCD.mbas,79 :: 		sub procedure Lcd_Port_Init()
;Libs/LCD.mbas,108 :: 		end sub
L_end_Lcd_Port_Init:
	RET
; end of _Lcd_Port_Init

_Lcd_0:

;Libs/LCD.mbas,109 :: 		sub procedure Lcd_0()
;Libs/LCD.mbas,110 :: 		Lcd_Init()
	PUSH       R2
	CALL       _Lcd_Init+0
;Libs/LCD.mbas,111 :: 		Lcd_Cmd(_LCD_CLEAR)               ' Clear display
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Libs/LCD.mbas,112 :: 		Lcd_Cmd(_LCD_CURSOR_OFF)          ' Cursor off
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;Libs/LCD.mbas,114 :: 		end sub
L_end_Lcd_0:
	POP        R2
	RET
; end of _Lcd_0

Libs/LCD_LCD_Load:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Libs/LCD.mbas,118 :: 		dim i, dchar as byte
;Libs/LCD.mbas,119 :: 		for dchar = 0 to 4
	PUSH       R2
	LDI        R27, 0
	STD        Y+1, R27
L_Libs/LCD_LCD_Load4:
;Libs/LCD.mbas,120 :: 		LCD_Cmd(64 + (dchar * 8))               ' Select 2x16 memory location for custom character
	LDD        R16, Y+1
	LSL        R16
	LSL        R16
	LSL        R16
	SUBI       R16, 192
	MOV        R2, R16
	CALL       _Lcd_Cmd+0
;Libs/LCD.mbas,121 :: 		for i = 0 to 7
	LDI        R27, 0
	STD        Y+0, R27
L_Libs/LCD_LCD_Load9:
;Libs/LCD.mbas,123 :: 		case 0
	LDD        R16, Y+1
	CPI        R16, 0
	BREQ       L_Libs/LCD_LCD_Load38
	JMP        L_Libs/LCD_LCD_Load16
L_Libs/LCD_LCD_Load38:
;Libs/LCD.mbas,124 :: 		LCD_Chr_Cp(heart[i])
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
	JMP        L_Libs/LCD_LCD_Load13
L_Libs/LCD_LCD_Load16:
;Libs/LCD.mbas,125 :: 		case 1
	LDD        R16, Y+1
	CPI        R16, 1
	BREQ       L_Libs/LCD_LCD_Load39
	JMP        L_Libs/LCD_LCD_Load19
L_Libs/LCD_LCD_Load39:
;Libs/LCD.mbas,126 :: 		LCD_Chr_Cp(co[i])
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
	JMP        L_Libs/LCD_LCD_Load13
L_Libs/LCD_LCD_Load19:
;Libs/LCD.mbas,127 :: 		case 2
	LDD        R16, Y+1
	CPI        R16, 2
	BREQ       L_Libs/LCD_LCD_Load40
	JMP        L_Libs/LCD_LCD_Load22
L_Libs/LCD_LCD_Load40:
;Libs/LCD.mbas,128 :: 		LCD_Chr_Cp(cn[i])
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
	JMP        L_Libs/LCD_LCD_Load13
L_Libs/LCD_LCD_Load22:
;Libs/LCD.mbas,129 :: 		case 3
	LDD        R16, Y+1
	CPI        R16, 3
	BREQ       L_Libs/LCD_LCD_Load41
	JMP        L_Libs/LCD_LCD_Load25
L_Libs/LCD_LCD_Load41:
;Libs/LCD.mbas,130 :: 		LCD_Chr_Cp(cf[i])
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
	JMP        L_Libs/LCD_LCD_Load13
L_Libs/LCD_LCD_Load25:
;Libs/LCD.mbas,131 :: 		case 4
	LDD        R16, Y+1
	CPI        R16, 4
	BREQ       L_Libs/LCD_LCD_Load42
	JMP        L_Libs/LCD_LCD_Load28
L_Libs/LCD_LCD_Load42:
;Libs/LCD.mbas,132 :: 		LCD_Chr_Cp(character_b[i])
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
	JMP        L_Libs/LCD_LCD_Load13
L_Libs/LCD_LCD_Load28:
L_Libs/LCD_LCD_Load13:
;Libs/LCD.mbas,134 :: 		next i
	LDD        R16, Y+0
	CPI        R16, 7
	BRNE       L_Libs/LCD_LCD_Load43
	JMP        L_Libs/LCD_LCD_Load12
L_Libs/LCD_LCD_Load43:
	LDD        R16, Y+0
	SUBI       R16, 255
	STD        Y+0, R16
	JMP        L_Libs/LCD_LCD_Load9
L_Libs/LCD_LCD_Load12:
;Libs/LCD.mbas,135 :: 		next dchar
	LDD        R16, Y+1
	CPI        R16, 4
	BRNE       L_Libs/LCD_LCD_Load44
	JMP        L_Libs/LCD_LCD_Load7
L_Libs/LCD_LCD_Load44:
	LDD        R16, Y+1
	SUBI       R16, 255
	STD        Y+1, R16
	JMP        L_Libs/LCD_LCD_Load4
L_Libs/LCD_LCD_Load7:
;Libs/LCD.mbas,136 :: 		end sub
L_end_LCD_Load:
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of Libs/LCD_LCD_Load

Libs/LCD_CustomChar:

;Libs/LCD.mbas,139 :: 		dim i as byte
;Libs/LCD.mbas,140 :: 		Lcd_Cmd(120)
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 120
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
	POP        R2
	POP        R3
;Libs/LCD.mbas,141 :: 		for i = 0 to 7
; i start address is: 18 (R18)
	LDI        R18, 0
; i end address is: 18 (R18)
L_Libs/LCD_CustomChar31:
;Libs/LCD.mbas,142 :: 		Lcd_Chr_CP(character[i])
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
;Libs/LCD.mbas,143 :: 		next i
	CPI        R18, 7
	BRNE       L_Libs/LCD_CustomChar46
	JMP        L_Libs/LCD_CustomChar34
L_Libs/LCD_CustomChar46:
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
; i end address is: 18 (R18)
	JMP        L_Libs/LCD_CustomChar31
L_Libs/LCD_CustomChar34:
;Libs/LCD.mbas,144 :: 		Lcd_Cmd(_LCD_RETURN_HOME)
	PUSH       R3
	PUSH       R2
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
	POP        R2
	POP        R3
;Libs/LCD.mbas,145 :: 		Lcd_Chr(pos_row, pos_char, 7)
	PUSH       R3
	PUSH       R2
	LDI        R27, 7
	MOV        R4, R27
	CALL       _Lcd_Chr+0
	POP        R2
	POP        R3
;Libs/LCD.mbas,146 :: 		end sub
L_end_CustomChar:
	POP        R4
	RET
; end of Libs/LCD_CustomChar

_Libs/LCD_?main:

;Libs/LCD.mbas,149 :: 		end.
L_end_Libs/LCD_?main:
	RET
; end of _Libs/LCD_?main
