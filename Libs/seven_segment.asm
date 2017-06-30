
Libs/seven_segment_Lcd_0:

;Libs/seven_segment.mbas,81 :: 		sub procedure Lcd_0()
;Libs/seven_segment.mbas,83 :: 		END SUB
L_end_Lcd_0:
	RET
; end of Libs/seven_segment_Lcd_0

_Display_Init:

;Libs/seven_segment.mbas,84 :: 		Sub Procedure Display_Init()
;Libs/seven_segment.mbas,87 :: 		keypadPort_D = 0
	LDI        R27, 0
	OUT        PORTD+0, R27
;Libs/seven_segment.mbas,88 :: 		keypadPort_Direction_D = 0xFF    ' set PORTD as output
	LDI        R27, 255
	OUT        DDRD+0, R27
;Libs/seven_segment.mbas,91 :: 		keypadPort_Direction_C=0xFF   ' set PORTC as output
	LDI        R27, 255
	OUT        DDRC+0, R27
;Libs/seven_segment.mbas,92 :: 		keypadPort_C = 0
	LDI        R27, 0
	OUT        PORTC+0, R27
;Libs/seven_segment.mbas,110 :: 		v          = 0  v2=0
	LDI        R27, 0
	STS        Libs/seven_segment_v+0, R27
	LDI        R27, 0
	STS        Libs/seven_segment_v2+0, R27
;Libs/seven_segment.mbas,111 :: 		zz         = 1
	LDI        R27, 1
	STS        Libs/seven_segment_zz+0, R27
;Libs/seven_segment.mbas,113 :: 		Display[3]     = 0      ' mask for digit 4 (7seg.)
	LDI        R27, 0
	STS        Libs/seven_segment_Display+3, R27
;Libs/seven_segment.mbas,114 :: 		Display[2]     = 0      ' mask for digit 6 (7seg.)
	LDI        R27, 0
	STS        Libs/seven_segment_Display+2, R27
;Libs/seven_segment.mbas,115 :: 		Display[1]     = 0      ' mask for digit 5 (7seg.)
	LDI        R27, 0
	STS        Libs/seven_segment_Display+1, R27
;Libs/seven_segment.mbas,116 :: 		Display[0]     = 0      ' mask for digit 8 (7seg.)
	LDI        R27, 0
	STS        Libs/seven_segment_Display+0, R27
;Libs/seven_segment.mbas,118 :: 		End Sub
L_end_Display_Init:
	RET
; end of _Display_Init

_Display_InterruptCall:

;Libs/seven_segment.mbas,120 :: 		Sub Procedure Display_InterruptCall()
;Libs/seven_segment.mbas,121 :: 		delay_ms(10)
	LDI        R17, 104
	LDI        R16, 229
L__Display_InterruptCall3:
	DEC        R16
	BRNE       L__Display_InterruptCall3
	DEC        R17
	BRNE       L__Display_InterruptCall3
;Libs/seven_segment.mbas,146 :: 		if v > 3 then
	LDS        R17, Libs/seven_segment_v+0
	LDI        R16, 3
	CP         R16, R17
	BRLO       L__Display_InterruptCall215
	JMP        L__Display_InterruptCall6
L__Display_InterruptCall215:
;Libs/seven_segment.mbas,147 :: 		v = 0
	LDI        R27, 0
	STS        Libs/seven_segment_v+0, R27
L__Display_InterruptCall6:
;Libs/seven_segment.mbas,151 :: 		inc(v2)
	LDS        R16, Libs/seven_segment_v2+0
	SUBI       R16, 255
	STS        Libs/seven_segment_v2+0, R16
;Libs/seven_segment.mbas,152 :: 		if ((n div 10000)=0) then
	LDI        R20, 16
	LDI        R21, 39
	LDS        R16, _n+0
	LDS        R17, _n+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	CPI        R17, 0
	BRNE       L__Display_InterruptCall216
	CPI        R16, 0
L__Display_InterruptCall216:
	BREQ       L__Display_InterruptCall217
	JMP        L__Display_InterruptCall9
L__Display_InterruptCall217:
;Libs/seven_segment.mbas,153 :: 		if v2 > 3 then
	LDS        R17, Libs/seven_segment_v2+0
	LDI        R16, 3
	CP         R16, R17
	BRLO       L__Display_InterruptCall218
	JMP        L__Display_InterruptCall12
L__Display_InterruptCall218:
;Libs/seven_segment.mbas,154 :: 		v2 = 0
	LDI        R27, 0
	STS        Libs/seven_segment_v2+0, R27
L__Display_InterruptCall12:
;Libs/seven_segment.mbas,155 :: 		end if
L__Display_InterruptCall9:
;Libs/seven_segment.mbas,158 :: 		if ((n div 1000)=0) then
	LDI        R20, 232
	LDI        R21, 3
	LDS        R16, _n+0
	LDS        R17, _n+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	CPI        R17, 0
	BRNE       L__Display_InterruptCall219
	CPI        R16, 0
L__Display_InterruptCall219:
	BREQ       L__Display_InterruptCall220
	JMP        L__Display_InterruptCall15
L__Display_InterruptCall220:
;Libs/seven_segment.mbas,159 :: 		if v2 > 2 then
	LDS        R17, Libs/seven_segment_v2+0
	LDI        R16, 2
	CP         R16, R17
	BRLO       L__Display_InterruptCall221
	JMP        L__Display_InterruptCall18
L__Display_InterruptCall221:
;Libs/seven_segment.mbas,160 :: 		v2 = 0
	LDI        R27, 0
	STS        Libs/seven_segment_v2+0, R27
L__Display_InterruptCall18:
;Libs/seven_segment.mbas,161 :: 		end if
L__Display_InterruptCall15:
;Libs/seven_segment.mbas,163 :: 		if (n div 100)=0 then
	LDI        R20, 100
	LDI        R21, 0
	LDS        R16, _n+0
	LDS        R17, _n+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	CPI        R17, 0
	BRNE       L__Display_InterruptCall222
	CPI        R16, 0
L__Display_InterruptCall222:
	BREQ       L__Display_InterruptCall223
	JMP        L__Display_InterruptCall21
L__Display_InterruptCall223:
;Libs/seven_segment.mbas,164 :: 		if v2 > 1 then
	LDS        R17, Libs/seven_segment_v2+0
	LDI        R16, 1
	CP         R16, R17
	BRLO       L__Display_InterruptCall224
	JMP        L__Display_InterruptCall24
L__Display_InterruptCall224:
;Libs/seven_segment.mbas,165 :: 		v2 = 0
	LDI        R27, 0
	STS        Libs/seven_segment_v2+0, R27
L__Display_InterruptCall24:
;Libs/seven_segment.mbas,166 :: 		end if
L__Display_InterruptCall21:
;Libs/seven_segment.mbas,168 :: 		if (n div 10)=0 then
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _n+0
	LDS        R17, _n+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	CPI        R17, 0
	BRNE       L__Display_InterruptCall225
	CPI        R16, 0
L__Display_InterruptCall225:
	BREQ       L__Display_InterruptCall226
	JMP        L__Display_InterruptCall27
L__Display_InterruptCall226:
;Libs/seven_segment.mbas,169 :: 		if v2 > 0 then
	LDS        R17, Libs/seven_segment_v2+0
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__Display_InterruptCall227
	JMP        L__Display_InterruptCall30
L__Display_InterruptCall227:
;Libs/seven_segment.mbas,170 :: 		v2 = 0
	LDI        R27, 0
	STS        Libs/seven_segment_v2+0, R27
L__Display_InterruptCall30:
;Libs/seven_segment.mbas,171 :: 		end if
L__Display_InterruptCall27:
;Libs/seven_segment.mbas,176 :: 		case 0  portc=            %00000111       ' 1 th
	LDS        R16, Libs/seven_segment_v2+0
	CPI        R16, 0
	BREQ       L__Display_InterruptCall228
	JMP        L__Display_InterruptCall35
L__Display_InterruptCall228:
	LDI        R27, 7
	OUT        PORTC+0, R27
	JMP        L__Display_InterruptCall32
L__Display_InterruptCall35:
;Libs/seven_segment.mbas,177 :: 		case 1  portc=            %00001011        '' 10th
	LDS        R16, Libs/seven_segment_v2+0
	CPI        R16, 1
	BREQ       L__Display_InterruptCall229
	JMP        L__Display_InterruptCall38
L__Display_InterruptCall229:
	LDI        R27, 11
	OUT        PORTC+0, R27
	JMP        L__Display_InterruptCall32
L__Display_InterruptCall38:
;Libs/seven_segment.mbas,178 :: 		case 2  portc=            %00001101         ' 100th
	LDS        R16, Libs/seven_segment_v2+0
	CPI        R16, 2
	BREQ       L__Display_InterruptCall230
	JMP        L__Display_InterruptCall41
L__Display_InterruptCall230:
	LDI        R27, 13
	OUT        PORTC+0, R27
	JMP        L__Display_InterruptCall32
L__Display_InterruptCall41:
;Libs/seven_segment.mbas,179 :: 		case 3  portc=            %00001110         ' 1000 th
	LDS        R16, Libs/seven_segment_v2+0
	CPI        R16, 3
	BREQ       L__Display_InterruptCall231
	JMP        L__Display_InterruptCall44
L__Display_InterruptCall231:
	LDI        R27, 14
	OUT        PORTC+0, R27
	JMP        L__Display_InterruptCall32
L__Display_InterruptCall44:
L__Display_InterruptCall32:
;Libs/seven_segment.mbas,181 :: 		keypadPort_D = Display[v2]           ' Send the appropriate mask to PORTB
	LDI        R16, #lo_addr(Libs/seven_segment_Display+0)
	LDI        R17, hi_addr(Libs/seven_segment_Display+0)
	LDS        R18, Libs/seven_segment_v2+0
	MOV        R30, R18
	LDI        R31, 0
	ADD        R30, R16
	ADC        R31, R17
	LD         R16, Z
	OUT        PORTD+0, R16
;Libs/seven_segment.mbas,184 :: 		if v2 > 3 then
	LDI        R16, 3
	CP         R16, R18
	BRLO       L__Display_InterruptCall232
	JMP        L__Display_InterruptCall46
L__Display_InterruptCall232:
;Libs/seven_segment.mbas,185 :: 		v2 = 0
	LDI        R27, 0
	STS        Libs/seven_segment_v2+0, R27
L__Display_InterruptCall46:
;Libs/seven_segment.mbas,198 :: 		End Sub
L_end_Display_InterruptCall:
	RET
; end of _Display_InterruptCall

Libs/seven_segment_StringToD_seven:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Libs/seven_segment.mbas,202 :: 		Sub Function StringToD_seven(dim tirth as byte) as word
;Libs/seven_segment.mbas,204 :: 		Result = 0
	LDI        R27, 0
	STD        Y+0, R27
	STD        Y+1, R27
;Libs/seven_segment.mbas,206 :: 		if tirth<>1 then
	LDI        R27, 1
	CP         R2, R27
	BRNE       L_Libs/seven_segment_StringToD_seven234
	JMP        L_Libs/seven_segment_StringToD_seven50
L_Libs/seven_segment_StringToD_seven234:
;Libs/seven_segment.mbas,209 :: 		case "0" Result = %00111111
	LDS        R16, _istr+0
	CPI        R16, 48
	BREQ       L_Libs/seven_segment_StringToD_seven235
	JMP        L_Libs/seven_segment_StringToD_seven55
L_Libs/seven_segment_StringToD_seven235:
	LDI        R27, 63
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven55:
;Libs/seven_segment.mbas,210 :: 		case "1" Result = %00000110
	LDS        R16, _istr+0
	CPI        R16, 49
	BREQ       L_Libs/seven_segment_StringToD_seven236
	JMP        L_Libs/seven_segment_StringToD_seven58
L_Libs/seven_segment_StringToD_seven236:
	LDI        R27, 6
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven58:
;Libs/seven_segment.mbas,211 :: 		case "2" Result = %01011011
	LDS        R16, _istr+0
	CPI        R16, 50
	BREQ       L_Libs/seven_segment_StringToD_seven237
	JMP        L_Libs/seven_segment_StringToD_seven61
L_Libs/seven_segment_StringToD_seven237:
	LDI        R27, 91
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven61:
;Libs/seven_segment.mbas,212 :: 		case "3" Result = %01001111
	LDS        R16, _istr+0
	CPI        R16, 51
	BREQ       L_Libs/seven_segment_StringToD_seven238
	JMP        L_Libs/seven_segment_StringToD_seven64
L_Libs/seven_segment_StringToD_seven238:
	LDI        R27, 79
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven64:
;Libs/seven_segment.mbas,213 :: 		case "4" Result = %01100110
	LDS        R16, _istr+0
	CPI        R16, 52
	BREQ       L_Libs/seven_segment_StringToD_seven239
	JMP        L_Libs/seven_segment_StringToD_seven67
L_Libs/seven_segment_StringToD_seven239:
	LDI        R27, 102
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven67:
;Libs/seven_segment.mbas,214 :: 		case "5" Result = %01101101
	LDS        R16, _istr+0
	CPI        R16, 53
	BREQ       L_Libs/seven_segment_StringToD_seven240
	JMP        L_Libs/seven_segment_StringToD_seven70
L_Libs/seven_segment_StringToD_seven240:
	LDI        R27, 109
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven70:
;Libs/seven_segment.mbas,215 :: 		case "6" Result = %01111101
	LDS        R16, _istr+0
	CPI        R16, 54
	BREQ       L_Libs/seven_segment_StringToD_seven241
	JMP        L_Libs/seven_segment_StringToD_seven73
L_Libs/seven_segment_StringToD_seven241:
	LDI        R27, 125
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven73:
;Libs/seven_segment.mbas,216 :: 		case "7" Result = %00000111
	LDS        R16, _istr+0
	CPI        R16, 55
	BREQ       L_Libs/seven_segment_StringToD_seven242
	JMP        L_Libs/seven_segment_StringToD_seven76
L_Libs/seven_segment_StringToD_seven242:
	LDI        R27, 7
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven76:
;Libs/seven_segment.mbas,217 :: 		case "8" Result = %01111111
	LDS        R16, _istr+0
	CPI        R16, 56
	BREQ       L_Libs/seven_segment_StringToD_seven243
	JMP        L_Libs/seven_segment_StringToD_seven79
L_Libs/seven_segment_StringToD_seven243:
	LDI        R27, 127
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven79:
;Libs/seven_segment.mbas,218 :: 		case "9" Result = %01101111
	LDS        R16, _istr+0
	CPI        R16, 57
	BREQ       L_Libs/seven_segment_StringToD_seven244
	JMP        L_Libs/seven_segment_StringToD_seven82
L_Libs/seven_segment_StringToD_seven244:
	LDI        R27, 111
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven82:
;Libs/seven_segment.mbas,219 :: 		case "E" Result = %01111001
	LDS        R16, _istr+0
	CPI        R16, 69
	BREQ       L_Libs/seven_segment_StringToD_seven245
	JMP        L_Libs/seven_segment_StringToD_seven85
L_Libs/seven_segment_StringToD_seven245:
	LDI        R27, 121
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven85:
;Libs/seven_segment.mbas,222 :: 		case "N" Result = %00110111
	LDS        R16, _istr+0
	CPI        R16, 78
	BREQ       L_Libs/seven_segment_StringToD_seven246
	JMP        L_Libs/seven_segment_StringToD_seven88
L_Libs/seven_segment_StringToD_seven246:
	LDI        R27, 55
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven88:
;Libs/seven_segment.mbas,223 :: 		case "D" Result = %01011110
	LDS        R16, _istr+0
	CPI        R16, 68
	BREQ       L_Libs/seven_segment_StringToD_seven247
	JMP        L_Libs/seven_segment_StringToD_seven91
L_Libs/seven_segment_StringToD_seven247:
	LDI        R27, 94
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven91:
;Libs/seven_segment.mbas,224 :: 		case "G" Result = %01111101
	LDS        R16, _istr+0
	CPI        R16, 71
	BREQ       L_Libs/seven_segment_StringToD_seven248
	JMP        L_Libs/seven_segment_StringToD_seven94
L_Libs/seven_segment_StringToD_seven248:
	LDI        R27, 125
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven94:
;Libs/seven_segment.mbas,225 :: 		case "O" Result = %00111111
	LDS        R16, _istr+0
	CPI        R16, 79
	BREQ       L_Libs/seven_segment_StringToD_seven249
	JMP        L_Libs/seven_segment_StringToD_seven97
L_Libs/seven_segment_StringToD_seven249:
	LDI        R27, 63
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven97:
;Libs/seven_segment.mbas,226 :: 		case "r" Result = %00110001
	LDS        R16, _istr+0
	CPI        R16, 114
	BREQ       L_Libs/seven_segment_StringToD_seven250
	JMP        L_Libs/seven_segment_StringToD_seven100
L_Libs/seven_segment_StringToD_seven250:
	LDI        R27, 49
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven100:
;Libs/seven_segment.mbas,227 :: 		case "e" Result = %01111011
	LDS        R16, _istr+0
	CPI        R16, 101
	BREQ       L_Libs/seven_segment_StringToD_seven251
	JMP        L_Libs/seven_segment_StringToD_seven103
L_Libs/seven_segment_StringToD_seven251:
	LDI        R27, 123
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven103:
;Libs/seven_segment.mbas,228 :: 		case "d" Result = %01011110
	LDS        R16, _istr+0
	CPI        R16, 100
	BREQ       L_Libs/seven_segment_StringToD_seven252
	JMP        L_Libs/seven_segment_StringToD_seven106
L_Libs/seven_segment_StringToD_seven252:
	LDI        R27, 94
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven106:
;Libs/seven_segment.mbas,229 :: 		case "y" Result = %01101110
	LDS        R16, _istr+0
	CPI        R16, 121
	BREQ       L_Libs/seven_segment_StringToD_seven253
	JMP        L_Libs/seven_segment_StringToD_seven109
L_Libs/seven_segment_StringToD_seven253:
	LDI        R27, 110
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven109:
;Libs/seven_segment.mbas,230 :: 		case "s" Result = %01101101
	LDS        R16, _istr+0
	CPI        R16, 115
	BREQ       L_Libs/seven_segment_StringToD_seven254
	JMP        L_Libs/seven_segment_StringToD_seven112
L_Libs/seven_segment_StringToD_seven254:
	LDI        R27, 109
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven112:
;Libs/seven_segment.mbas,231 :: 		case "a" Result = %01110111
	LDS        R16, _istr+0
	CPI        R16, 97
	BREQ       L_Libs/seven_segment_StringToD_seven255
	JMP        L_Libs/seven_segment_StringToD_seven115
L_Libs/seven_segment_StringToD_seven255:
	LDI        R27, 119
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven115:
;Libs/seven_segment.mbas,232 :: 		case "v" Result = %00111110
	LDS        R16, _istr+0
	CPI        R16, 118
	BREQ       L_Libs/seven_segment_StringToD_seven256
	JMP        L_Libs/seven_segment_StringToD_seven118
L_Libs/seven_segment_StringToD_seven256:
	LDI        R27, 62
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven118:
;Libs/seven_segment.mbas,233 :: 		case " " Result = %00000000
	LDS        R16, _istr+0
	CPI        R16, 32
	BREQ       L_Libs/seven_segment_StringToD_seven257
	JMP        L_Libs/seven_segment_StringToD_seven121
L_Libs/seven_segment_StringToD_seven257:
	LDI        R27, 0
	STD        Y+0, R27
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven52
L_Libs/seven_segment_StringToD_seven121:
L_Libs/seven_segment_StringToD_seven52:
;Libs/seven_segment.mbas,234 :: 		End Select
	JMP        L_Libs/seven_segment_StringToD_seven51
;Libs/seven_segment.mbas,235 :: 		else
L_Libs/seven_segment_StringToD_seven50:
;Libs/seven_segment.mbas,238 :: 		case "0" Result = %10111111
	LDS        R16, _istr+0
	CPI        R16, 48
	BREQ       L_Libs/seven_segment_StringToD_seven258
	JMP        L_Libs/seven_segment_StringToD_seven125
L_Libs/seven_segment_StringToD_seven258:
	LDI        R27, 191
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven125:
;Libs/seven_segment.mbas,239 :: 		case "1" Result = %10000110
	LDS        R16, _istr+0
	CPI        R16, 49
	BREQ       L_Libs/seven_segment_StringToD_seven259
	JMP        L_Libs/seven_segment_StringToD_seven128
L_Libs/seven_segment_StringToD_seven259:
	LDI        R27, 134
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven128:
;Libs/seven_segment.mbas,240 :: 		case "2" Result = %11011011
	LDS        R16, _istr+0
	CPI        R16, 50
	BREQ       L_Libs/seven_segment_StringToD_seven260
	JMP        L_Libs/seven_segment_StringToD_seven131
L_Libs/seven_segment_StringToD_seven260:
	LDI        R27, 219
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven131:
;Libs/seven_segment.mbas,241 :: 		case "3" Result = %11001111
	LDS        R16, _istr+0
	CPI        R16, 51
	BREQ       L_Libs/seven_segment_StringToD_seven261
	JMP        L_Libs/seven_segment_StringToD_seven134
L_Libs/seven_segment_StringToD_seven261:
	LDI        R27, 207
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven134:
;Libs/seven_segment.mbas,242 :: 		case "4" Result = %11100110
	LDS        R16, _istr+0
	CPI        R16, 52
	BREQ       L_Libs/seven_segment_StringToD_seven262
	JMP        L_Libs/seven_segment_StringToD_seven137
L_Libs/seven_segment_StringToD_seven262:
	LDI        R27, 230
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven137:
;Libs/seven_segment.mbas,243 :: 		case "5" Result = %11101101
	LDS        R16, _istr+0
	CPI        R16, 53
	BREQ       L_Libs/seven_segment_StringToD_seven263
	JMP        L_Libs/seven_segment_StringToD_seven140
L_Libs/seven_segment_StringToD_seven263:
	LDI        R27, 237
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven140:
;Libs/seven_segment.mbas,244 :: 		case "6" Result = %11111101
	LDS        R16, _istr+0
	CPI        R16, 54
	BREQ       L_Libs/seven_segment_StringToD_seven264
	JMP        L_Libs/seven_segment_StringToD_seven143
L_Libs/seven_segment_StringToD_seven264:
	LDI        R27, 253
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven143:
;Libs/seven_segment.mbas,245 :: 		case "7" Result = %10000111
	LDS        R16, _istr+0
	CPI        R16, 55
	BREQ       L_Libs/seven_segment_StringToD_seven265
	JMP        L_Libs/seven_segment_StringToD_seven146
L_Libs/seven_segment_StringToD_seven265:
	LDI        R27, 135
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven146:
;Libs/seven_segment.mbas,246 :: 		case "8" Result = %11111111
	LDS        R16, _istr+0
	CPI        R16, 56
	BREQ       L_Libs/seven_segment_StringToD_seven266
	JMP        L_Libs/seven_segment_StringToD_seven149
L_Libs/seven_segment_StringToD_seven266:
	LDI        R27, 255
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven149:
;Libs/seven_segment.mbas,247 :: 		case "9" Result = %11101111
	LDS        R16, _istr+0
	CPI        R16, 57
	BREQ       L_Libs/seven_segment_StringToD_seven267
	JMP        L_Libs/seven_segment_StringToD_seven152
L_Libs/seven_segment_StringToD_seven267:
	LDI        R27, 239
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven152:
;Libs/seven_segment.mbas,248 :: 		case "E" Result = %11111001
	LDS        R16, _istr+0
	CPI        R16, 69
	BREQ       L_Libs/seven_segment_StringToD_seven268
	JMP        L_Libs/seven_segment_StringToD_seven155
L_Libs/seven_segment_StringToD_seven268:
	LDI        R27, 249
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven155:
;Libs/seven_segment.mbas,249 :: 		case "N" Result = %10110111
	LDS        R16, _istr+0
	CPI        R16, 78
	BREQ       L_Libs/seven_segment_StringToD_seven269
	JMP        L_Libs/seven_segment_StringToD_seven158
L_Libs/seven_segment_StringToD_seven269:
	LDI        R27, 183
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven158:
;Libs/seven_segment.mbas,250 :: 		case "D" Result = %11011110
	LDS        R16, _istr+0
	CPI        R16, 68
	BREQ       L_Libs/seven_segment_StringToD_seven270
	JMP        L_Libs/seven_segment_StringToD_seven161
L_Libs/seven_segment_StringToD_seven270:
	LDI        R27, 222
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	JMP        L_Libs/seven_segment_StringToD_seven122
L_Libs/seven_segment_StringToD_seven161:
L_Libs/seven_segment_StringToD_seven122:
;Libs/seven_segment.mbas,252 :: 		end if
L_Libs/seven_segment_StringToD_seven51:
;Libs/seven_segment.mbas,253 :: 		End Sub
	LDD        R16, Y+0
	LDD        R17, Y+1
L_end_StringToD_seven:
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of Libs/seven_segment_StringToD_seven

Libs/seven_segment_Display_InterruptCall_text:

;Libs/seven_segment.mbas,256 :: 		Sub Procedure Display_InterruptCall_text(dim V2_2 as byte )
;Libs/seven_segment.mbas,257 :: 		delay_ms(10)
	LDI        R17, 104
	LDI        R16, 229
L_Libs/seven_segment_Display_InterruptCall_text163:
	DEC        R16
	BRNE       L_Libs/seven_segment_Display_InterruptCall_text163
	DEC        R17
	BRNE       L_Libs/seven_segment_Display_InterruptCall_text163
;Libs/seven_segment.mbas,258 :: 		v2=V2_2
	STS        Libs/seven_segment_v2+0, R2
;Libs/seven_segment.mbas,287 :: 		case 0  portc=            %00000111       ' 1 th
	LDI        R27, 0
	CP         R2, R27
	BREQ       L_Libs/seven_segment_Display_InterruptCall_text272
	JMP        L_Libs/seven_segment_Display_InterruptCall_text168
L_Libs/seven_segment_Display_InterruptCall_text272:
	LDI        R27, 7
	OUT        PORTC+0, R27
	JMP        L_Libs/seven_segment_Display_InterruptCall_text165
L_Libs/seven_segment_Display_InterruptCall_text168:
;Libs/seven_segment.mbas,288 :: 		case 1  portc=            %00001011        '' 10th
	LDS        R16, Libs/seven_segment_v2+0
	CPI        R16, 1
	BREQ       L_Libs/seven_segment_Display_InterruptCall_text273
	JMP        L_Libs/seven_segment_Display_InterruptCall_text171
L_Libs/seven_segment_Display_InterruptCall_text273:
	LDI        R27, 11
	OUT        PORTC+0, R27
	JMP        L_Libs/seven_segment_Display_InterruptCall_text165
L_Libs/seven_segment_Display_InterruptCall_text171:
;Libs/seven_segment.mbas,289 :: 		case 2  portc=            %00001101         ' 100th
	LDS        R16, Libs/seven_segment_v2+0
	CPI        R16, 2
	BREQ       L_Libs/seven_segment_Display_InterruptCall_text274
	JMP        L_Libs/seven_segment_Display_InterruptCall_text174
L_Libs/seven_segment_Display_InterruptCall_text274:
	LDI        R27, 13
	OUT        PORTC+0, R27
	JMP        L_Libs/seven_segment_Display_InterruptCall_text165
L_Libs/seven_segment_Display_InterruptCall_text174:
;Libs/seven_segment.mbas,290 :: 		case 3  portc=            %00001110         ' 1000 th
	LDS        R16, Libs/seven_segment_v2+0
	CPI        R16, 3
	BREQ       L_Libs/seven_segment_Display_InterruptCall_text275
	JMP        L_Libs/seven_segment_Display_InterruptCall_text177
L_Libs/seven_segment_Display_InterruptCall_text275:
	LDI        R27, 14
	OUT        PORTC+0, R27
	JMP        L_Libs/seven_segment_Display_InterruptCall_text165
L_Libs/seven_segment_Display_InterruptCall_text177:
L_Libs/seven_segment_Display_InterruptCall_text165:
;Libs/seven_segment.mbas,292 :: 		keypadPort_D = Display[v2]           ' Send the appropriate mask to PORTB
	LDI        R17, #lo_addr(Libs/seven_segment_Display+0)
	LDI        R18, hi_addr(Libs/seven_segment_Display+0)
	LDS        R16, Libs/seven_segment_v2+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LD         R16, Z
	OUT        PORTD+0, R16
;Libs/seven_segment.mbas,297 :: 		End Sub
L_end_Display_InterruptCall_text:
	RET
; end of Libs/seven_segment_Display_InterruptCall_text

Libs/seven_segment_GetChar:

;Libs/seven_segment.mbas,300 :: 		sub function GetChar(dim Character as char) as byte
;Libs/seven_segment.mbas,301 :: 		if ((Character >= "-") AND (Character <= "_")) then
	LDI        R27, 45
	CP         R2, R27
	LDI        R17, 0
	BRLO       L_Libs/seven_segment_GetChar277
	LDI        R17, 255
L_Libs/seven_segment_GetChar277:
	LDI        R16, 95
	CP         R16, R2
	LDI        R27, 0
	BRLO       L_Libs/seven_segment_GetChar278
	LDI        R27, 255
L_Libs/seven_segment_GetChar278:
	MOV        R16, R27
	AND        R16, R17
	BRNE       L_Libs/seven_segment_GetChar279
	JMP        L_Libs/seven_segment_GetChar180
L_Libs/seven_segment_GetChar279:
;Libs/seven_segment.mbas,302 :: 		result = CharTable[Character-"-"]
	MOV        R18, R2
	SUBI       R18, 45
	LDI        R16, #lo_addr(_CharTable+0)
	LDI        R17, hi_addr(_CharTable+0)
	MOV        R30, R18
	LDI        R31, 0
	ADD        R30, R16
	ADC        R31, R17
	LPM        R16, Z
; Result start address is: 17 (R17)
	MOV        R17, R16
; Result end address is: 17 (R17)
	JMP        L_Libs/seven_segment_GetChar181
;Libs/seven_segment.mbas,303 :: 		else
L_Libs/seven_segment_GetChar180:
;Libs/seven_segment.mbas,304 :: 		result = 0
; Result start address is: 17 (R17)
; Result start address is: 17 (R17)
	LDI        R17, 0
; Result end address is: 17 (R17)
; Result end address is: 17 (R17)
;Libs/seven_segment.mbas,305 :: 		end if
L_Libs/seven_segment_GetChar181:
;Libs/seven_segment.mbas,306 :: 		end sub
; Result start address is: 17 (R17)
	MOV        R16, R17
; Result end address is: 17 (R17)
L_end_GetChar:
	RET
; end of Libs/seven_segment_GetChar

_Display_Number:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 7
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Libs/seven_segment.mbas,309 :: 		Dim ms   as string[6]
;Libs/seven_segment.mbas,311 :: 		if dNumber > 9999 then
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R16, 15
	LDI        R17, 39
	CP         R16, R2
	CPC        R17, R3
	BRLT       L__Display_Number281
	JMP        L__Display_Number184
L__Display_Number281:
;Libs/seven_segment.mbas,312 :: 		dNumber = 9999
	LDI        R27, 15
	MOV        R2, R27
	LDI        R27, 39
	MOV        R3, R27
L__Display_Number184:
;Libs/seven_segment.mbas,314 :: 		n=dNumber
	STS        _n+0, R2
	STS        _n+1, R3
;Libs/seven_segment.mbas,316 :: 		IntToStr(dNumber,ms)
	MOVW       R16, R28
	MOVW       R4, R16
	CALL       _IntToStr+0
;Libs/seven_segment.mbas,318 :: 		istr[0]=ms[5]   Display[0] = StringToD_seven(0) Display_InterruptCall()
	LDD        R16, Y+5
	STS        _istr+0, R16
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+0, R16
	CALL       _Display_InterruptCall+0
;Libs/seven_segment.mbas,319 :: 		istr[0]=ms[4]   Display[1] = StringToD_seven(0) Display_InterruptCall()
	LDD        R16, Y+4
	STS        _istr+0, R16
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+1, R16
	CALL       _Display_InterruptCall+0
;Libs/seven_segment.mbas,320 :: 		istr[0]=ms[3]   Display[2] = StringToD_seven(1) Display_InterruptCall()
	LDD        R16, Y+3
	STS        _istr+0, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+2, R16
	CALL       _Display_InterruptCall+0
;Libs/seven_segment.mbas,321 :: 		istr[0]=ms[2]   Display[3] = StringToD_seven(0) Display_InterruptCall()
	LDD        R16, Y+2
	STS        _istr+0, R16
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+3, R16
	CALL       _Display_InterruptCall+0
;Libs/seven_segment.mbas,331 :: 		End Sub
L_end_Display_Number:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _Display_Number

_Display_Number_2:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 12
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Libs/seven_segment.mbas,333 :: 		Dim ms   as string[6]
;Libs/seven_segment.mbas,334 :: 		if strcmp(ms2,"int")=0 then
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 105
	STD        Y+7, R27
	LDI        R27, 110
	STD        Y+8, R27
	LDI        R27, 116
	STD        Y+9, R27
	LDI        R27, 0
	STD        Y+10, R27
	MOVW       R16, R28
	SUBI       R16, 249
	SBCI       R17, 255
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	MOVW       R2, R4
	MOVW       R4, R16
	CALL       _strcmp+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	CPI        R17, 0
	BRNE       L__Display_Number_2283
	CPI        R16, 0
L__Display_Number_2283:
	BREQ       L__Display_Number_2284
	JMP        L__Display_Number_2188
L__Display_Number_2284:
;Libs/seven_segment.mbas,338 :: 		if dNumber > 9999 then
	LDI        R16, 15
	LDI        R17, 39
	CP         R16, R2
	CPC        R17, R3
	BRLT       L__Display_Number_2285
	JMP        L__Display_Number_2191
L__Display_Number_2285:
;Libs/seven_segment.mbas,339 :: 		dNumber = 9999
	LDI        R27, 15
	MOV        R2, R27
	LDI        R27, 39
	MOV        R3, R27
L__Display_Number_2191:
;Libs/seven_segment.mbas,341 :: 		n=dNumber
	STS        _n+0, R2
	STS        _n+1, R3
;Libs/seven_segment.mbas,343 :: 		inttostr(dNumber,ms)
	MOVW       R16, R28
	MOVW       R4, R16
	CALL       _IntToStr+0
;Libs/seven_segment.mbas,344 :: 		if strcmp(ms,"    ")=0  then
	MOVW       R30, R28
	ADIW       R30, 7
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 32
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	SUBI       R16, 249
	SBCI       R17, 255
	MOVW       R4, R16
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _strcmp+0
	CPI        R17, 0
	BRNE       L__Display_Number_2286
	CPI        R16, 0
L__Display_Number_2286:
	BREQ       L__Display_Number_2287
	JMP        L__Display_Number_2194
L__Display_Number_2287:
;Libs/seven_segment.mbas,349 :: 		istr[0]=ms[2]   Display[3] = StringToD_seven(0) Display_InterruptCall()
	LDD        R16, Y+2
	STS        _istr+0, R16
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+3, R16
	CALL       _Display_InterruptCall+0
	JMP        L__Display_Number_2195
;Libs/seven_segment.mbas,351 :: 		else
L__Display_Number_2194:
;Libs/seven_segment.mbas,352 :: 		for k=1 to  10
	LDI        R27, 1
	STS        _k+0, R27
	LDI        R27, 0
	STS        _k+1, R27
L__Display_Number_2197:
;Libs/seven_segment.mbas,353 :: 		istr[0]=ms[5]   Display[0] = StringToD_seven(0) Display_InterruptCall()
	LDD        R16, Y+5
	STS        _istr+0, R16
	PUSH       R3
	PUSH       R2
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	POP        R2
	POP        R3
	STS        Libs/seven_segment_Display+0, R16
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _Display_InterruptCall+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;Libs/seven_segment.mbas,354 :: 		istr[0]=ms[4]   Display[1] = StringToD_seven(0) Display_InterruptCall()
	LDD        R16, Y+4
	STS        _istr+0, R16
	PUSH       R3
	PUSH       R2
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	POP        R2
	POP        R3
	STS        Libs/seven_segment_Display+1, R16
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _Display_InterruptCall+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;Libs/seven_segment.mbas,355 :: 		istr[0]=ms[3]   Display[2] = StringToD_seven(1) Display_InterruptCall()
	LDD        R16, Y+3
	STS        _istr+0, R16
	PUSH       R3
	PUSH       R2
	LDI        R27, 1
	MOV        R2, R27
	CALL       Libs/seven_segment_StringToD_seven+0
	POP        R2
	POP        R3
	STS        Libs/seven_segment_Display+2, R16
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _Display_InterruptCall+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;Libs/seven_segment.mbas,356 :: 		istr[0]=ms[2]   Display[3] = StringToD_seven(0) Display_InterruptCall()
	LDD        R16, Y+2
	STS        _istr+0, R16
	PUSH       R3
	PUSH       R2
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	POP        R2
	POP        R3
	STS        Libs/seven_segment_Display+3, R16
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _Display_InterruptCall+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
;Libs/seven_segment.mbas,357 :: 		next k
	LDS        R16, _k+0
	LDS        R17, _k+1
	CPI        R17, 0
	BRNE       L__Display_Number_2288
	CPI        R16, 10
L__Display_Number_2288:
	BRNE       L__Display_Number_2289
	JMP        L__Display_Number_2200
L__Display_Number_2289:
	LDS        R16, _k+0
	LDS        R17, _k+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _k+0, R16
	STS        _k+1, R17
	JMP        L__Display_Number_2197
L__Display_Number_2200:
;Libs/seven_segment.mbas,358 :: 		end if
L__Display_Number_2195:
	JMP        L__Display_Number_2189
;Libs/seven_segment.mbas,359 :: 		else
L__Display_Number_2188:
;Libs/seven_segment.mbas,360 :: 		for k=1 to  10
	LDI        R27, 1
	STS        _k+0, R27
	LDI        R27, 0
	STS        _k+1, R27
L__Display_Number_2202:
;Libs/seven_segment.mbas,361 :: 		istr[0]=ms2[3]   Display[0] = StringToD_seven(0) Display_InterruptCall_text(0)
	MOVW       R30, R4
	ADIW       R30, 3
	LD         R16, Z
	STS        _istr+0, R16
	PUSH       R3
	PUSH       R2
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+0, R16
	CLR        R2
	CALL       Libs/seven_segment_Display_InterruptCall_text+0
;Libs/seven_segment.mbas,362 :: 		istr[0]=ms2[2]   Display[1] = StringToD_seven(0) Display_InterruptCall_text(1)
	MOVW       R30, R4
	ADIW       R30, 2
	LD         R16, Z
	STS        _istr+0, R16
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+1, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       Libs/seven_segment_Display_InterruptCall_text+0
;Libs/seven_segment.mbas,363 :: 		istr[0]=ms2[1]   Display[2] = StringToD_seven(0)  Display_InterruptCall_text(2)
	MOVW       R30, R4
	ADIW       R30, 1
	LD         R16, Z
	STS        _istr+0, R16
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+2, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       Libs/seven_segment_Display_InterruptCall_text+0
;Libs/seven_segment.mbas,364 :: 		istr[0]=ms2[0]   Display[3] = StringToD_seven(0) Display_InterruptCall_text(3)
	MOVW       R30, R4
	LD         R16, Z
	STS        _istr+0, R16
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+3, R16
	LDI        R27, 3
	MOV        R2, R27
	CALL       Libs/seven_segment_Display_InterruptCall_text+0
	POP        R2
	POP        R3
;Libs/seven_segment.mbas,365 :: 		next k
	LDS        R16, _k+0
	LDS        R17, _k+1
	CPI        R17, 0
	BRNE       L__Display_Number_2290
	CPI        R16, 10
L__Display_Number_2290:
	BRNE       L__Display_Number_2291
	JMP        L__Display_Number_2205
L__Display_Number_2291:
	LDS        R16, _k+0
	LDS        R17, _k+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _k+0, R16
	STS        _k+1, R17
	JMP        L__Display_Number_2202
L__Display_Number_2205:
;Libs/seven_segment.mbas,366 :: 		end if
L__Display_Number_2189:
;Libs/seven_segment.mbas,368 :: 		End Sub
L_end_Display_Number_2:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 11
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _Display_Number_2

_Display_text:

;Libs/seven_segment.mbas,370 :: 		Sub Procedure Display_text(dim byref ms2 as string[3])
;Libs/seven_segment.mbas,380 :: 		for k=1 to  10
	LDI        R27, 1
	STS        _k+0, R27
	LDI        R27, 0
	STS        _k+1, R27
L__Display_text208:
;Libs/seven_segment.mbas,381 :: 		istr[0]=ms2[3]   Display[0] = StringToD_seven(0) Display_InterruptCall_text(0)
	MOVW       R30, R2
	ADIW       R30, 3
	LD         R16, Z
	STS        _istr+0, R16
	PUSH       R3
	PUSH       R2
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+0, R16
	CLR        R2
	CALL       Libs/seven_segment_Display_InterruptCall_text+0
	POP        R2
	POP        R3
;Libs/seven_segment.mbas,382 :: 		istr[0]=ms2[2]   Display[1] = StringToD_seven(0) Display_InterruptCall_text(1)
	MOVW       R30, R2
	ADIW       R30, 2
	LD         R16, Z
	STS        _istr+0, R16
	PUSH       R3
	PUSH       R2
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+1, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       Libs/seven_segment_Display_InterruptCall_text+0
	POP        R2
	POP        R3
;Libs/seven_segment.mbas,383 :: 		istr[0]=ms2[1]   Display[2] = StringToD_seven(0)  Display_InterruptCall_text(2)
	MOVW       R30, R2
	ADIW       R30, 1
	LD         R16, Z
	STS        _istr+0, R16
	PUSH       R3
	PUSH       R2
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+2, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       Libs/seven_segment_Display_InterruptCall_text+0
	POP        R2
	POP        R3
;Libs/seven_segment.mbas,384 :: 		istr[0]=ms2[0]   Display[3] = StringToD_seven(0) Display_InterruptCall_text(3)
	MOVW       R30, R2
	LD         R16, Z
	STS        _istr+0, R16
	PUSH       R3
	PUSH       R2
	CLR        R2
	CALL       Libs/seven_segment_StringToD_seven+0
	STS        Libs/seven_segment_Display+3, R16
	LDI        R27, 3
	MOV        R2, R27
	CALL       Libs/seven_segment_Display_InterruptCall_text+0
	POP        R2
	POP        R3
;Libs/seven_segment.mbas,385 :: 		next k
	LDS        R16, _k+0
	LDS        R17, _k+1
	CPI        R17, 0
	BRNE       L__Display_text293
	CPI        R16, 10
L__Display_text293:
	BRNE       L__Display_text294
	JMP        L__Display_text211
L__Display_text294:
	LDS        R16, _k+0
	LDS        R17, _k+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _k+0, R16
	STS        _k+1, R17
	JMP        L__Display_text208
L__Display_text211:
;Libs/seven_segment.mbas,397 :: 		End Sub
L_end_Display_text:
	RET
; end of _Display_text
