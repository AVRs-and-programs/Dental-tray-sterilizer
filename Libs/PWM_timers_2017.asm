
Libs/PWM_timers_2017_SetPWM2:

;Libs/PWM_timers_2017.mbas,53 :: 		sub procedure SetPWM2(dim duty as integer)
;Libs/PWM_timers_2017.mbas,58 :: 		OCR2=duty
	OUT        OCR2+0, R2
;Libs/PWM_timers_2017.mbas,60 :: 		end sub
L_end_SetPWM2:
	RET
; end of Libs/PWM_timers_2017_SetPWM2

Libs/PWM_timers_2017_SetPWM1_A:

;Libs/PWM_timers_2017.mbas,62 :: 		sub procedure SetPWM1_A(dim duty as integer)
;Libs/PWM_timers_2017.mbas,66 :: 		OCR1AH=0x00
	LDI        R27, 0
	OUT        OCR1AH+0, R27
;Libs/PWM_timers_2017.mbas,67 :: 		OCR1AL=duty
	OUT        OCR1AL+0, R2
;Libs/PWM_timers_2017.mbas,69 :: 		end sub
L_end_SetPWM1_A:
	RET
; end of Libs/PWM_timers_2017_SetPWM1_A

Libs/PWM_timers_2017_SetPWM1_B:

;Libs/PWM_timers_2017.mbas,70 :: 		sub procedure SetPWM1_B(dim duty as integer)
;Libs/PWM_timers_2017.mbas,74 :: 		OCR1BH=0x00
	LDI        R27, 0
	OUT        OCR1BH+0, R27
;Libs/PWM_timers_2017.mbas,75 :: 		OCR1BL=duty
	OUT        OCR1BL+0, R2
;Libs/PWM_timers_2017.mbas,76 :: 		end sub
L_end_SetPWM1_B:
	RET
; end of Libs/PWM_timers_2017_SetPWM1_B

_PWM_MAKE:

;Libs/PWM_timers_2017.mbas,80 :: 		jjyear as float
;Libs/PWM_timers_2017.mbas,82 :: 		jjyear=ceil((jj*max_duty)/100)
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	MOV        R16, R2
	LDI        R17, 0
	MOV        R20, R3
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R20, 100
	LDI        R21, 0
	CALL       _Div_16x16_U+0
	MOVW       R16, R24
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _ceil+0
	POP        R2
	POP        R3
	POP        R4
; jjyear start address is: 20 (R20)
	MOVW       R20, R16
	MOVW       R22, R18
;Libs/PWM_timers_2017.mbas,83 :: 		FloatToStr(jjyear, st)
	PUSH       R23
	PUSH       R22
	PUSH       R21
	PUSH       R20
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(_st+0)
	MOV        R6, R27
	LDI        R27, hi_addr(_st+0)
	MOV        R7, R27
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _FloatToStr+0
	POP        R2
	POP        R3
	POP        R4
	POP        R20
	POP        R21
	POP        R22
	POP        R23
;Libs/PWM_timers_2017.mbas,92 :: 		ii = integer (jjyear)
	PUSH       R4
; jjyear end address is: 20 (R20)
	PUSH       R3
	PUSH       R2
	MOVW       R16, R20
	MOVW       R18, R22
	CALL       _float_fpint+0
	POP        R2
	POP        R3
	POP        R4
; ii start address is: 18 (R18)
	MOVW       R18, R16
;Libs/PWM_timers_2017.mbas,93 :: 		IntToStr(ii, txt)
	PUSH       R19
	PUSH       R18
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _IntToStr+0
	POP        R2
	POP        R3
	POP        R4
	POP        R18
	POP        R19
;Libs/PWM_timers_2017.mbas,103 :: 		case 2
	LDI        R27, 2
	CP         R4, R27
	BREQ       L__PWM_MAKE83
	JMP        L__PWM_MAKE7
L__PWM_MAKE83:
;Libs/PWM_timers_2017.mbas,106 :: 		PWM16bit_Change_Duty(ii,_TIMER1_CH_B )
	LDI        R27, 18
	MOV        R4, R27
	MOVW       R2, R18
	CALL       _PWM16bit_Change_Duty+0
;Libs/PWM_timers_2017.mbas,107 :: 		PWM16bit_Change_Duty(ii,_TIMER1_CH_B )
	LDI        R27, 18
	MOV        R4, R27
	MOVW       R2, R18
; ii end address is: 18 (R18)
	CALL       _PWM16bit_Change_Duty+0
	JMP        L__PWM_MAKE4
L__PWM_MAKE7:
;Libs/PWM_timers_2017.mbas,108 :: 		case 1
; ii start address is: 18 (R18)
	LDI        R27, 1
	CP         R4, R27
	BREQ       L__PWM_MAKE84
	JMP        L__PWM_MAKE10
L__PWM_MAKE84:
;Libs/PWM_timers_2017.mbas,111 :: 		PWM16bit_Change_Duty(ii,_TIMER1_CH_A )
	LDI        R27, 17
	MOV        R4, R27
	MOVW       R2, R18
	CALL       _PWM16bit_Change_Duty+0
;Libs/PWM_timers_2017.mbas,112 :: 		PWM16bit_Change_Duty(ii,_TIMER1_CH_A )
	LDI        R27, 17
	MOV        R4, R27
	MOVW       R2, R18
; ii end address is: 18 (R18)
	CALL       _PWM16bit_Change_Duty+0
	JMP        L__PWM_MAKE4
L__PWM_MAKE10:
;Libs/PWM_timers_2017.mbas,135 :: 		case 4
; ii start address is: 18 (R18)
	LDI        R27, 4
	CP         R4, R27
	BREQ       L__PWM_MAKE85
	JMP        L__PWM_MAKE13
L__PWM_MAKE85:
;Libs/PWM_timers_2017.mbas,144 :: 		if jj=0 then
	LDI        R27, 0
	CP         R2, R27
	BREQ       L__PWM_MAKE86
	JMP        L__PWM_MAKE15
L__PWM_MAKE86:
; ii end address is: 18 (R18)
;Libs/PWM_timers_2017.mbas,145 :: 		SetPWM2(0)
	CLR        R2
	CLR        R3
	CALL       Libs/PWM_timers_2017_SetPWM2+0
	JMP        L__PWM_MAKE16
;Libs/PWM_timers_2017.mbas,146 :: 		else
L__PWM_MAKE15:
;Libs/PWM_timers_2017.mbas,147 :: 		SetPWM2(ii)
; ii start address is: 18 (R18)
	MOVW       R2, R18
; ii end address is: 18 (R18)
	CALL       Libs/PWM_timers_2017_SetPWM2+0
;Libs/PWM_timers_2017.mbas,149 :: 		end if
L__PWM_MAKE16:
	JMP        L__PWM_MAKE4
L__PWM_MAKE13:
;Libs/PWM_timers_2017.mbas,151 :: 		case 45
; ii start address is: 18 (R18)
	LDI        R27, 45
	CP         R4, R27
	BREQ       L__PWM_MAKE87
	JMP        L__PWM_MAKE19
L__PWM_MAKE87:
;Libs/PWM_timers_2017.mbas,155 :: 		PWM16bit_Change_Duty(ii,2 )
	LDI        R27, 2
	MOV        R4, R27
	MOVW       R2, R18
; ii end address is: 18 (R18)
	CALL       _PWM16bit_Change_Duty+0
	JMP        L__PWM_MAKE4
L__PWM_MAKE19:
;Libs/PWM_timers_2017.mbas,158 :: 		case 25
; ii start address is: 18 (R18)
	LDI        R27, 25
	CP         R4, R27
	BREQ       L__PWM_MAKE88
	JMP        L__PWM_MAKE22
L__PWM_MAKE88:
;Libs/PWM_timers_2017.mbas,161 :: 		if jj=0 then
	LDI        R27, 0
	CP         R2, R27
	BREQ       L__PWM_MAKE89
	JMP        L__PWM_MAKE24
L__PWM_MAKE89:
;Libs/PWM_timers_2017.mbas,162 :: 		SetPWM1_A(max_duty-ii)
	MOV        R16, R3
	LDI        R17, 0
	SUB        R16, R18
	SBC        R17, R19
; ii end address is: 18 (R18)
	MOVW       R2, R16
	CALL       Libs/PWM_timers_2017_SetPWM1_A+0
	JMP        L__PWM_MAKE25
;Libs/PWM_timers_2017.mbas,163 :: 		else
L__PWM_MAKE24:
;Libs/PWM_timers_2017.mbas,164 :: 		SetPWM1_A(max_duty-ii)
; ii start address is: 18 (R18)
	MOV        R16, R3
	LDI        R17, 0
	SUB        R16, R18
	SBC        R17, R19
; ii end address is: 18 (R18)
	MOVW       R2, R16
	CALL       Libs/PWM_timers_2017_SetPWM1_A+0
;Libs/PWM_timers_2017.mbas,166 :: 		end if
L__PWM_MAKE25:
	JMP        L__PWM_MAKE4
L__PWM_MAKE22:
;Libs/PWM_timers_2017.mbas,167 :: 		case 35
; ii start address is: 18 (R18)
	LDI        R27, 35
	CP         R4, R27
	BREQ       L__PWM_MAKE90
	JMP        L__PWM_MAKE28
L__PWM_MAKE90:
;Libs/PWM_timers_2017.mbas,170 :: 		if jj=0 then
	LDI        R27, 0
	CP         R2, R27
	BREQ       L__PWM_MAKE91
	JMP        L__PWM_MAKE30
L__PWM_MAKE91:
;Libs/PWM_timers_2017.mbas,171 :: 		SetPWM1_B(max_duty-ii)
	MOV        R16, R3
	LDI        R17, 0
	SUB        R16, R18
	SBC        R17, R19
; ii end address is: 18 (R18)
	MOVW       R2, R16
	CALL       Libs/PWM_timers_2017_SetPWM1_B+0
	JMP        L__PWM_MAKE31
;Libs/PWM_timers_2017.mbas,172 :: 		else
L__PWM_MAKE30:
;Libs/PWM_timers_2017.mbas,173 :: 		SetPWM1_B(max_duty-ii)
; ii start address is: 18 (R18)
	MOV        R16, R3
	LDI        R17, 0
	SUB        R16, R18
	SBC        R17, R19
; ii end address is: 18 (R18)
	MOVW       R2, R16
	CALL       Libs/PWM_timers_2017_SetPWM1_B+0
;Libs/PWM_timers_2017.mbas,175 :: 		end if
L__PWM_MAKE31:
	JMP        L__PWM_MAKE4
L__PWM_MAKE28:
;Libs/PWM_timers_2017.mbas,177 :: 		case 5
	LDI        R27, 5
	CP         R4, R27
	BREQ       L__PWM_MAKE92
	JMP        L__PWM_MAKE34
L__PWM_MAKE92:
	JMP        L__PWM_MAKE4
L__PWM_MAKE34:
;Libs/PWM_timers_2017.mbas,181 :: 		case 6
	LDI        R27, 6
	CP         R4, R27
	BREQ       L__PWM_MAKE93
	JMP        L__PWM_MAKE37
L__PWM_MAKE93:
	JMP        L__PWM_MAKE4
L__PWM_MAKE37:
;Libs/PWM_timers_2017.mbas,185 :: 		case 7
	LDI        R27, 7
	CP         R4, R27
	BREQ       L__PWM_MAKE94
	JMP        L__PWM_MAKE40
L__PWM_MAKE94:
	JMP        L__PWM_MAKE4
L__PWM_MAKE40:
L__PWM_MAKE4:
;Libs/PWM_timers_2017.mbas,190 :: 		end sub
L_end_PWM_MAKE:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _PWM_MAKE

_PWM_Port_Initialize:

;Libs/PWM_timers_2017.mbas,193 :: 		sub procedure PWM_Port_Initialize ()
;Libs/PWM_timers_2017.mbas,196 :: 		DDB1_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB1_bit+0
	SBR        R27, 2
	OUT        DDB1_bit+0, R27
;Libs/PWM_timers_2017.mbas,197 :: 		DDB2_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB2_bit+0
	SBR        R27, 4
	OUT        DDB2_bit+0, R27
;Libs/PWM_timers_2017.mbas,198 :: 		DDB3_bit = 1                    ' Set PORTB pin 3 as output pin for the PWM (according to datasheet)
	IN         R27, DDB3_bit+0
	SBR        R27, 8
	OUT        DDB3_bit+0, R27
;Libs/PWM_timers_2017.mbas,202 :: 		end  sub
L_end_PWM_Port_Initialize:
	RET
; end of _PWM_Port_Initialize

_PWM_Initialize:

;Libs/PWM_timers_2017.mbas,206 :: 		dim j,k as byte
;Libs/PWM_timers_2017.mbas,209 :: 		PWM_Port_Initialize ()
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _PWM_Port_Initialize+0
;Libs/PWM_timers_2017.mbas,259 :: 		PWM2_Init(_PWM2_PHASE_CORRECT_MODE, _PWM2_PRESCALER_8, _PWM2_NON_INVERTED,0) ''PWM2_Init(5000)'' Initialize PWM2
	CLR        R5
	LDI        R27, 32
	MOV        R4, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 64
	MOV        R2, R27
	CALL       _PWM2_Init+0
;Libs/PWM_timers_2017.mbas,270 :: 		ASSR=0x00
	LDI        R27, 0
	OUT        ASSR+0, R27
;Libs/PWM_timers_2017.mbas,276 :: 		TCNT0=0x00
	LDI        R27, 0
	OUT        TCNT0+0, R27
;Libs/PWM_timers_2017.mbas,280 :: 		TCNT2=0x00
	LDI        R27, 0
	OUT        TCNT2+0, R27
;Libs/PWM_timers_2017.mbas,288 :: 		PWM16bit_Init(_PWM16_PHASE_CORRECT_MODE_8BIT, _PWM16_PRESCALER_16bit_1024, _PWM16_NON_INVERTED, 0, _TIMER1)
	LDI        R27, 30
	MOV        R7, R27
	CLR        R5
	CLR        R6
	LDI        R27, 160
	MOV        R4, R27
	LDI        R27, 5
	MOV        R3, R27
	LDI        R27, 11
	MOV        R2, R27
	CALL       _PWM16bit_Init+0
;Libs/PWM_timers_2017.mbas,330 :: 		end sub
L_end_PWM_Initialize:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _PWM_Initialize

_WDT_on:

;Libs/PWM_timers_2017.mbas,368 :: 		sub procedure  WDT_on()
;Libs/PWM_timers_2017.mbas,400 :: 		WDTCR =(1<<WDP2) or (1<<WDP1)  or (1<<WDP0)
	LDI        R27, 7
	OUT        WDTCR+0, R27
;Libs/PWM_timers_2017.mbas,413 :: 		end sub
L_end_WDT_on:
	RET
; end of _WDT_on

_dispaly_time:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 5
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Libs/PWM_timers_2017.mbas,419 :: 		sub procedure dispaly_time()
;Libs/PWM_timers_2017.mbas,421 :: 		if  (minutes_alarm_clock>target_min) or ((minutes_alarm_clock=target_min) and  (second_alarm_clock>target_sec))  then
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R16, _minutes_alarm_clock+0
	LDS        R17, _target_min+0
	CP         R17, R16
	LDI        R19, 0
	BRSH       L__dispaly_time99
	LDI        R19, 255
L__dispaly_time99:
	LDS        R16, _minutes_alarm_clock+0
	CP         R16, R17
	LDI        R18, 0
	BRNE       L__dispaly_time100
	LDI        R18, 255
L__dispaly_time100:
	LDS        R17, _second_alarm_clock+0
	LDS        R16, _target_sec+0
	CP         R16, R17
	LDI        R27, 0
	BRSH       L__dispaly_time101
	LDI        R27, 255
L__dispaly_time101:
	MOV        R16, R27
	AND        R16, R18
	OR         R16, R19
	BRNE       L__dispaly_time102
	JMP        L__dispaly_time46
L__dispaly_time102:
;Libs/PWM_timers_2017.mbas,423 :: 		PWM2_Set_Duty(0) end_flag=0
	CLR        R2
	CALL       _PWM2_Set_Duty+0
	LDS        R27, _end_flag+0
	CBR        R27, BitMask(_end_flag+0)
	STS        _end_flag+0, R27
;Libs/PWM_timers_2017.mbas,424 :: 		Display_Number_2(0,"END") Display_Number_2(0,"    ")
	LDI        R27, 69
	STD        Y+0, R27
	LDI        R27, 78
	STD        Y+1, R27
	LDI        R27, 68
	STD        Y+2, R27
	LDI        R27, 0
	STD        Y+3, R27
	MOVW       R16, R28
	MOVW       R4, R16
	CLR        R2
	CLR        R3
	CALL       _Display_Number_2+0
	MOVW       R30, R28
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
	MOVW       R4, R16
	CLR        R2
	CLR        R3
	CALL       _Display_Number_2+0
;Libs/PWM_timers_2017.mbas,425 :: 		end_flag=0
	LDS        R27, _end_flag+0
	CBR        R27, BitMask(_end_flag+0)
	STS        _end_flag+0, R27
	JMP        L__dispaly_time47
;Libs/PWM_timers_2017.mbas,427 :: 		else
L__dispaly_time46:
;Libs/PWM_timers_2017.mbas,428 :: 		Display_Number(minutes_alarm_clock*100+second_alarm_clock)
	LDS        R16, _minutes_alarm_clock+0
	LDI        R17, 0
	LDI        R20, 100
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDS        R18, _second_alarm_clock+0
	ADD        R16, R18
	LDI        R27, 0
	ADC        R17, R27
	MOVW       R2, R16
	CALL       _Display_Number+0
;Libs/PWM_timers_2017.mbas,429 :: 		end if
L__dispaly_time47:
;Libs/PWM_timers_2017.mbas,431 :: 		end sub
L_end_dispaly_time:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 4
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _dispaly_time

_motor_on_off:

;Libs/PWM_timers_2017.mbas,432 :: 		sub procedure motor_on_off()
;Libs/PWM_timers_2017.mbas,434 :: 		jj=1  dispaly_time()
	PUSH       R2
	PUSH       R3
	LDI        R27, 1
	STS        _jj+0, R27
	CALL       _dispaly_time+0
;Libs/PWM_timers_2017.mbas,435 :: 		while (minutes_alarm_clock<target_min) or ((minutes_alarm_clock=target_min) and  (second_alarm_clock<target_sec))
L__motor_on_off50:
	LDS        R16, _minutes_alarm_clock+0
	LDS        R17, _target_min+0
	CP         R16, R17
	LDI        R19, 0
	BRSH       L__motor_on_off104
	LDI        R19, 255
L__motor_on_off104:
	LDS        R16, _minutes_alarm_clock+0
	CP         R16, R17
	LDI        R18, 0
	BRNE       L__motor_on_off105
	LDI        R18, 255
L__motor_on_off105:
	LDS        R17, _second_alarm_clock+0
	LDS        R16, _target_sec+0
	CP         R17, R16
	LDI        R16, 0
	BRSH       L__motor_on_off106
	LDI        R16, 255
L__motor_on_off106:
	AND        R16, R18
	OR         R16, R19
	BRNE       L__motor_on_off107
	JMP        L__motor_on_off51
L__motor_on_off107:
;Libs/PWM_timers_2017.mbas,436 :: 		Display_Number(minutes_alarm_clock*100+second_alarm_clock)
	LDS        R16, _minutes_alarm_clock+0
	LDI        R17, 0
	LDI        R20, 100
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDS        R18, _second_alarm_clock+0
	ADD        R16, R18
	LDI        R27, 0
	ADC        R17, R27
	MOVW       R2, R16
	CALL       _Display_Number+0
;Libs/PWM_timers_2017.mbas,437 :: 		if jj=1 then
	LDS        R16, _jj+0
	CPI        R16, 1
	BREQ       L__motor_on_off108
	JMP        L__motor_on_off55
L__motor_on_off108:
;Libs/PWM_timers_2017.mbas,438 :: 		for j=0 to 5
	LDI        R27, 0
	STS        _j+0, R27
L__motor_on_off58:
;Libs/PWM_timers_2017.mbas,439 :: 		PWM2_Set_Duty(integer (j*255/10)) delay_ms(100)dispaly_time()
	LDS        R16, _j+0
	LDI        R17, 0
	LDI        R20, 255
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_U+0
	MOVW       R16, R24
	MOV        R2, R16
	CALL       _PWM2_Set_Duty+0
	LDI        R18, lo_addr(R5)
	LDI        R17, lo_addr(R15)
	LDI        R16, 242
L__motor_on_off62:
	DEC        R16
	BRNE       L__motor_on_off62
	DEC        R17
	BRNE       L__motor_on_off62
	DEC        R18
	BRNE       L__motor_on_off62
	CALL       _dispaly_time+0
;Libs/PWM_timers_2017.mbas,440 :: 		next j
	LDS        R16, _j+0
	CPI        R16, 5
	BRNE       L__motor_on_off109
	JMP        L__motor_on_off61
L__motor_on_off109:
	LDS        R16, _j+0
	SUBI       R16, 255
	STS        _j+0, R16
	JMP        L__motor_on_off58
L__motor_on_off61:
L__motor_on_off55:
;Libs/PWM_timers_2017.mbas,443 :: 		Start_seconds=second_alarm_clock  jj=0
	LDS        R16, _second_alarm_clock+0
	STS        _Start_seconds+0, R16
	LDI        R27, 0
	STS        _jj+0, R27
;Libs/PWM_timers_2017.mbas,444 :: 		while  second_alarm_clock<=Start_seconds+target_interval
L__motor_on_off65:
	LDS        R17, _Start_seconds+0
	LDS        R16, _target_interval+0
	ADD        R17, R16
	LDS        R16, _second_alarm_clock+0
	CP         R17, R16
	BRSH       L__motor_on_off110
	JMP        L__motor_on_off66
L__motor_on_off110:
;Libs/PWM_timers_2017.mbas,445 :: 		if jj=0 then
	LDS        R16, _jj+0
	CPI        R16, 0
	BREQ       L__motor_on_off111
	JMP        L__motor_on_off70
L__motor_on_off111:
;Libs/PWM_timers_2017.mbas,446 :: 		jj=1
	LDI        R27, 1
	STS        _jj+0, R27
;Libs/PWM_timers_2017.mbas,447 :: 		for j=motor_power to 0 step -1
	LDI        R27, 5
	STS        _j+0, R27
L__motor_on_off73:
;Libs/PWM_timers_2017.mbas,448 :: 		PWM2_Set_Duty(integer (j*255/10))  delay_ms(100)  dispaly_time()
	LDS        R16, _j+0
	LDI        R17, 0
	LDI        R20, 255
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_U+0
	MOVW       R16, R24
	MOV        R2, R16
	CALL       _PWM2_Set_Duty+0
	LDI        R18, lo_addr(R5)
	LDI        R17, lo_addr(R15)
	LDI        R16, 242
L__motor_on_off77:
	DEC        R16
	BRNE       L__motor_on_off77
	DEC        R17
	BRNE       L__motor_on_off77
	DEC        R18
	BRNE       L__motor_on_off77
	CALL       _dispaly_time+0
;Libs/PWM_timers_2017.mbas,449 :: 		next j
	LDS        R16, _j+0
	CPI        R16, 0
	BRNE       L__motor_on_off112
	JMP        L__motor_on_off76
L__motor_on_off112:
	LDS        R16, _j+0
	SUBI       R16, 1
	STS        _j+0, R16
	JMP        L__motor_on_off73
L__motor_on_off76:
L__motor_on_off70:
;Libs/PWM_timers_2017.mbas,451 :: 		PWM2_Set_Duty(0)  dispaly_time()
	CLR        R2
	CALL       _PWM2_Set_Duty+0
	CALL       _dispaly_time+0
;Libs/PWM_timers_2017.mbas,452 :: 		wend
	JMP        L__motor_on_off65
L__motor_on_off66:
;Libs/PWM_timers_2017.mbas,456 :: 		wend
	JMP        L__motor_on_off50
L__motor_on_off51:
;Libs/PWM_timers_2017.mbas,457 :: 		dispaly_time()
	CALL       _dispaly_time+0
;Libs/PWM_timers_2017.mbas,464 :: 		end sub
L_end_motor_on_off:
	POP        R3
	POP        R2
	RET
; end of _motor_on_off
