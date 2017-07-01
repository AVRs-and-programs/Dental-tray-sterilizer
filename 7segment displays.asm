
_port_ini:

;7segment displays.mbas,56 :: 		sub procedure  port_ini()
;7segment displays.mbas,57 :: 		DDB0_BIT=0           PORTB0_BIT=0
	IN         R27, DDB0_bit+0
	CBR        R27, 1
	OUT        DDB0_bit+0, R27
	IN         R27, PORTB0_bit+0
	CBR        R27, 1
	OUT        PORTB0_bit+0, R27
;7segment displays.mbas,58 :: 		DDB4_BIT=0           PORTB4_BIT=0
	IN         R27, DDB4_bit+0
	CBR        R27, 16
	OUT        DDB4_bit+0, R27
	IN         R27, PORTB4_bit+0
	CBR        R27, 16
	OUT        PORTB4_bit+0, R27
;7segment displays.mbas,59 :: 		DDB5_BIT=0           PORTB5_BIT=0
	IN         R27, DDB5_bit+0
	CBR        R27, 32
	OUT        DDB5_bit+0, R27
	IN         R27, PORTB5_bit+0
	CBR        R27, 32
	OUT        PORTB5_bit+0, R27
;7segment displays.mbas,60 :: 		END SUB
L_end_port_ini:
	RET
; end of _port_ini

_seven_segment_add:

;7segment displays.mbas,62 :: 		sub procedure  seven_segment_add()
;7segment displays.mbas,63 :: 		terget_final=integer(target_min*100)+integer(target_sec) Display_Number(terget_final) ''delay_us(100)
	PUSH       R2
	PUSH       R3
	LDS        R16, _target_min+0
	LDI        R17, 0
	LDI        R20, 100
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDS        R18, _target_sec+0
	LDI        R19, 0
	ADD        R16, R18
	ADC        R17, R19
	STS        _terget_final+0, R16
	STS        _terget_final+1, R17
	MOVW       R2, R16
	CALL       _Display_Number+0
;7segment displays.mbas,64 :: 		END SUB
L_end_seven_segment_add:
	POP        R3
	POP        R2
	RET
; end of _seven_segment_add

_ok:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 5
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;7segment displays.mbas,66 :: 		sub procedure ok()
;7segment displays.mbas,67 :: 		while_state=0 Start_seconds=second_alarm_clock
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	LDI        R27, 0
	STS        _while_state+0, R27
	LDS        R16, _second_alarm_clock+0
	STS        _Start_seconds+0, R16
;7segment displays.mbas,68 :: 		oldstate_setting=0    while_state_setting=11
	LDS        R27, _oldstate_setting+0
	CBR        R27, BitMask(_oldstate_setting+0)
	STS        _oldstate_setting+0, R27
	LDI        R27, 11
	STS        _while_state_setting+0, R27
;7segment displays.mbas,71 :: 		if (end_flag=1) then
	LDS        R27, _end_flag+0
	SBRS       R27, BitPos(_end_flag+0)
	JMP        L__ok4
;7segment displays.mbas,72 :: 		Display_Number_2(0,"redy") Display_Number_2(0,"    ")
	MOVW       R30, R28
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 121
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
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
L__ok4:
;7segment displays.mbas,74 :: 		if (end_flag=0) then
	LDS        R27, _end_flag+0
	SBRC       R27, BitPos(_end_flag+0)
	JMP        L__ok7
;7segment displays.mbas,76 :: 		for j=1 to 40
	LDI        R27, 1
	STS        _j+0, R27
L__ok10:
;7segment displays.mbas,77 :: 		Display_Number(minutes_alarm_clock*100+second_alarm_clock)
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
;7segment displays.mbas,78 :: 		next j
	LDS        R16, _j+0
	CPI        R16, 40
	BRNE       L__ok122
	JMP        L__ok13
L__ok122:
	LDS        R16, _j+0
	SUBI       R16, 255
	STS        _j+0, R16
	JMP        L__ok10
L__ok13:
;7segment displays.mbas,79 :: 		if  minutes_alarm_clock<target_min+Ready_min_interval then
	LDS        R16, _target_min+0
	MOV        R17, R16
	SUBI       R17, 253
	LDS        R16, _minutes_alarm_clock+0
	CP         R16, R17
	BRLO       L__ok123
	JMP        L__ok15
L__ok123:
;7segment displays.mbas,80 :: 		Display_Number_2(0,"END") Display_Number_2(0,"    ")
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
	JMP        L__ok16
;7segment displays.mbas,81 :: 		else
L__ok15:
;7segment displays.mbas,82 :: 		Display_Number_2(0,"redy") Display_Number_2(0,"    ")
	MOVW       R30, R28
	LDI        R27, 114
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 100
	ST         Z+, R27
	LDI        R27, 121
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
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
;7segment displays.mbas,83 :: 		end if
L__ok16:
L__ok7:
;7segment displays.mbas,85 :: 		while_state_setting_2=11  while_state_help=0
	LDI        R27, 11
	STS        _while_state_setting_2+0, R27
	LDI        R27, 0
	STS        _while_state_help+0, R27
;7segment displays.mbas,86 :: 		oldstate_1=0 oldstate_2=0 oldstate_3=0
	LDS        R27, _oldstate_1+0
	CBR        R27, BitMask(_oldstate_1+0)
	STS        _oldstate_1+0, R27
	LDS        R27, _oldstate_2+0
	CBR        R27, BitMask(_oldstate_2+0)
	STS        _oldstate_2+0, R27
	LDS        R27, _oldstate_3+0
	CBR        R27, BitMask(_oldstate_3+0)
	STS        _oldstate_3+0, R27
;7segment displays.mbas,87 :: 		while (while_state<11)
L__ok18:
	LDS        R16, _while_state+0
	CPI        R16, 11
	BRLO       L__ok124
	JMP        L__ok19
L__ok124:
;7segment displays.mbas,88 :: 		inc(while_state)
	LDS        R16, _while_state+0
	SUBI       R16, 255
	STS        _while_state+0, R16
;7segment displays.mbas,90 :: 		for j=1 to 4
	LDI        R27, 1
	STS        _j+0, R27
L__ok23:
;7segment displays.mbas,91 :: 		if (Button(Start_SW_Port, Start_SW_bit, 70, 1)) then    ' Detect logical one up key
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 70
	MOV        R5, R27
	CLR        R4
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__ok125
	JMP        L__ok28
L__ok125:
;7segment displays.mbas,92 :: 		oldstate_1 = 1                      ' Update flag
	LDS        R27, _oldstate_1+0
	SBR        R27, BitMask(_oldstate_1+0)
	STS        _oldstate_1+0, R27
L__ok28:
;7segment displays.mbas,94 :: 		next j
	LDS        R16, _j+0
	CPI        R16, 4
	BRNE       L__ok126
	JMP        L__ok26
L__ok126:
	LDS        R16, _j+0
	SUBI       R16, 255
	STS        _j+0, R16
	JMP        L__ok23
L__ok26:
;7segment displays.mbas,95 :: 		if (oldstate_1 and Button(Start_SW_Port, Start_SW_bit,50,0)) then
	CLR        R6
	LDI        R27, 50
	MOV        R5, R27
	CLR        R4
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	LDS        R0, _oldstate_1+0
	CLR        R17
	SBRC       R0, BitPos(_oldstate_1+0)
	INC        R17
	AND        R16, R17
	BRNE       L__ok127
	JMP        L__ok31
L__ok127:
;7segment displays.mbas,96 :: 		oldstate_1=0   while_state=14
	LDS        R27, _oldstate_1+0
	CBR        R27, BitMask(_oldstate_1+0)
	STS        _oldstate_1+0, R27
	LDI        R27, 14
	STS        _while_state+0, R27
;7segment displays.mbas,97 :: 		reset_alarm_clock()                           'Reset laram click for better counting
	CALL       _reset_alarm_clock+0
;7segment displays.mbas,99 :: 		motor_on_off()
	CALL       _motor_on_off+0
;7segment displays.mbas,100 :: 		oldstate_1=0 while_state=14
	LDS        R27, _oldstate_1+0
	CBR        R27, BitMask(_oldstate_1+0)
	STS        _oldstate_1+0, R27
	LDI        R27, 14
	STS        _while_state+0, R27
L__ok31:
;7segment displays.mbas,110 :: 		if (Button(Up_SW_Port, Up_SW_bit, 5, 1))then
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 5
	MOV        R5, R27
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__ok128
	JMP        L__ok34
L__ok128:
;7segment displays.mbas,111 :: 		oldstate_2=1  while_state_setting=0
	LDS        R27, _oldstate_2+0
	SBR        R27, BitMask(_oldstate_2+0)
	STS        _oldstate_2+0, R27
	LDI        R27, 0
	STS        _while_state_setting+0, R27
L__ok34:
;7segment displays.mbas,113 :: 		if (Button(Down_SW_Port, Down_SW_bit, 5, 1)) then    ' Detect logical one up key
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 5
	MOV        R5, R27
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__ok129
	JMP        L__ok37
L__ok129:
;7segment displays.mbas,114 :: 		oldstate_3 = 1   while_state_setting=0           ' Update flag
	LDS        R27, _oldstate_3+0
	SBR        R27, BitMask(_oldstate_3+0)
	STS        _oldstate_3+0, R27
	LDI        R27, 0
	STS        _while_state_setting+0, R27
L__ok37:
;7segment displays.mbas,120 :: 		oldstate_setting=0
	LDS        R27, _oldstate_setting+0
	CBR        R27, BitMask(_oldstate_setting+0)
	STS        _oldstate_setting+0, R27
;7segment displays.mbas,121 :: 		while  (while_state_setting<11 or ((oldstate_2=1) or (oldstate_3=1)) or (while_state_help=1) )
L__ok43:
	SBR        R19, 1
	LDS        R16, _while_state_help+0
	CPI        R16, 1
	LDI        R17, 0
	BRNE       L__ok130
	LDI        R17, 255
L__ok130:
	CLR        R16
	SBRC       R19, 0
	INC        R16
	OR         R17, R16
	LDS        R16, _while_state_setting+0
	CP         R16, R17
	BRLO       L__ok131
	JMP        L__ok44
L__ok131:
;7segment displays.mbas,122 :: 		seven_segment_add()  while_state_help=1
	CALL       _seven_segment_add+0
	LDI        R27, 1
	STS        _while_state_help+0, R27
;7segment displays.mbas,124 :: 		if (Button(Start_SW_Port, Start_SW_bit, 100, 1)) then    ' Detect logical one up key
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 100
	MOV        R5, R27
	CLR        R4
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__ok132
	JMP        L__ok48
L__ok132:
;7segment displays.mbas,125 :: 		oldstate_setting = 1   while_state_setting_2=0                   ' Update flag
	LDS        R27, _oldstate_setting+0
	SBR        R27, BitMask(_oldstate_setting+0)
	STS        _oldstate_setting+0, R27
	LDI        R27, 0
	STS        _while_state_setting_2+0, R27
L__ok48:
;7segment displays.mbas,127 :: 		while while_state_setting_2=0
L__ok51:
	LDS        R16, _while_state_setting_2+0
	CPI        R16, 0
	BREQ       L__ok133
	JMP        L__ok52
L__ok133:
;7segment displays.mbas,128 :: 		if (oldstate_setting and Button(Start_SW_Port, Start_SW_bit,50,0)) then
	CLR        R6
	LDI        R27, 50
	MOV        R5, R27
	CLR        R4
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	LDS        R0, _oldstate_setting+0
	CLR        R17
	SBRC       R0, BitPos(_oldstate_setting+0)
	INC        R17
	AND        R16, R17
	BRNE       L__ok134
	JMP        L__ok56
L__ok134:
;7segment displays.mbas,129 :: 		while_state_setting=11 oldstate_setting=0 while_state_setting_2=1 while_state_help=0
	LDI        R27, 11
	STS        _while_state_setting+0, R27
	LDS        R27, _oldstate_setting+0
	CBR        R27, BitMask(_oldstate_setting+0)
	STS        _oldstate_setting+0, R27
	LDI        R27, 1
	STS        _while_state_setting_2+0, R27
	LDI        R27, 0
	STS        _while_state_help+0, R27
;7segment displays.mbas,130 :: 		target_enable=1              nn=9999
	LDI        R27, 1
	STS        _target_enable+0, R27
	LDI        R27, 15
	STS        _nn+0, R27
	LDI        R27, 39
	STS        _nn+1, R27
;7segment displays.mbas,132 :: 		for j=1 to 5
	LDI        R27, 1
	STS        _j+0, R27
L__ok59:
;7segment displays.mbas,133 :: 		Display_Number_2(0,"save")
	MOVW       R30, R28
	LDI        R27, 115
	ST         Z+, R27
	LDI        R27, 97
	ST         Z+, R27
	LDI        R27, 118
	ST         Z+, R27
	LDI        R27, 101
	ST         Z+, R27
	LDI        R27, 0
	ST         Z+, R27
	MOVW       R16, R28
	MOVW       R4, R16
	CLR        R2
	CLR        R3
	CALL       _Display_Number_2+0
;7segment displays.mbas,134 :: 		next j
	LDS        R16, _j+0
	CPI        R16, 5
	BRNE       L__ok135
	JMP        L__ok62
L__ok135:
	LDS        R16, _j+0
	SUBI       R16, 255
	STS        _j+0, R16
	JMP        L__ok59
L__ok62:
;7segment displays.mbas,135 :: 		Display_Number_2(0,"    ")
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
;7segment displays.mbas,136 :: 		eeprom_save()
	CALL       _eeprom_save+0
L__ok56:
;7segment displays.mbas,138 :: 		wend
	JMP        L__ok51
L__ok52:
;7segment displays.mbas,143 :: 		if (Button(Up_SW_Port, Up_SW_bit, 40, 1))then    ' Detect logical one up key
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 40
	MOV        R5, R27
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__ok136
	JMP        L__ok64
L__ok136:
;7segment displays.mbas,144 :: 		oldstate_2 = 1                      ' Update flag
	LDS        R27, _oldstate_2+0
	SBR        R27, BitMask(_oldstate_2+0)
	STS        _oldstate_2+0, R27
;7segment displays.mbas,146 :: 		while_state_setting=1
	LDI        R27, 1
	STS        _while_state_setting+0, R27
L__ok64:
;7segment displays.mbas,148 :: 		if (oldstate_2 and Button(Up_SW_Port, Up_SW_bit,50,0)) then
	CLR        R6
	LDI        R27, 50
	MOV        R5, R27
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	LDS        R0, _oldstate_2+0
	CLR        R17
	SBRC       R0, BitPos(_oldstate_2+0)
	INC        R17
	AND        R16, R17
	BRNE       L__ok137
	JMP        L__ok67
L__ok137:
;7segment displays.mbas,149 :: 		oldstate_2=0 while_state_help=1
	LDS        R27, _oldstate_2+0
	CBR        R27, BitMask(_oldstate_2+0)
	STS        _oldstate_2+0, R27
	LDI        R27, 1
	STS        _while_state_help+0, R27
;7segment displays.mbas,150 :: 		timer_setting(1) seven_segment_add()
	LDI        R27, 1
	MOV        R2, R27
	CALL       _timer_setting+0
	CALL       _seven_segment_add+0
L__ok67:
;7segment displays.mbas,154 :: 		if (Button(Up_SW_Port, Up_SW_bit,200, 1))then    ' Detect logical one up key
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 200
	MOV        R5, R27
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__ok138
	JMP        L__ok70
L__ok138:
;7segment displays.mbas,155 :: 		oldstate_2 = 1                      ' Update flag
	LDS        R27, _oldstate_2+0
	SBR        R27, BitMask(_oldstate_2+0)
	STS        _oldstate_2+0, R27
;7segment displays.mbas,157 :: 		while_state_setting_2=0
	LDI        R27, 0
	STS        _while_state_setting_2+0, R27
L__ok70:
;7segment displays.mbas,159 :: 		while while_state_setting_2=0
L__ok73:
	LDS        R16, _while_state_setting_2+0
	CPI        R16, 0
	BREQ       L__ok139
	JMP        L__ok74
L__ok139:
;7segment displays.mbas,160 :: 		timer_setting(1)  seven_segment_add()
	LDI        R27, 1
	MOV        R2, R27
	CALL       _timer_setting+0
	CALL       _seven_segment_add+0
;7segment displays.mbas,161 :: 		if (oldstate_2 and Button(Up_SW_Port, Up_SW_bit,50,0)) then
	CLR        R6
	LDI        R27, 50
	MOV        R5, R27
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	LDS        R0, _oldstate_2+0
	CLR        R17
	SBRC       R0, BitPos(_oldstate_2+0)
	INC        R17
	AND        R16, R17
	BRNE       L__ok140
	JMP        L__ok78
L__ok140:
;7segment displays.mbas,162 :: 		oldstate_2=0 while_state_setting_2=11 while_state=1 while_state_setting=1  while_state_help=1
	LDS        R27, _oldstate_2+0
	CBR        R27, BitMask(_oldstate_2+0)
	STS        _oldstate_2+0, R27
	LDI        R27, 11
	STS        _while_state_setting_2+0, R27
	LDI        R27, 1
	STS        _while_state+0, R27
	LDI        R27, 1
	STS        _while_state_setting+0, R27
	LDI        R27, 1
	STS        _while_state_help+0, R27
L__ok78:
;7segment displays.mbas,165 :: 		wend
	JMP        L__ok73
L__ok74:
;7segment displays.mbas,168 :: 		if (Button(Down_SW_Port, Down_SW_bit, 40, 1)) then    ' Detect logical one up key
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 40
	MOV        R5, R27
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__ok141
	JMP        L__ok81
L__ok141:
;7segment displays.mbas,169 :: 		oldstate_3 = 1                      ' Update flag
	LDS        R27, _oldstate_3+0
	SBR        R27, BitMask(_oldstate_3+0)
	STS        _oldstate_3+0, R27
L__ok81:
;7segment displays.mbas,171 :: 		if (oldstate_3 and Button(Down_SW_Port, Down_SW_bit,50,0)) then
	CLR        R6
	LDI        R27, 50
	MOV        R5, R27
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	LDS        R0, _oldstate_3+0
	CLR        R17
	SBRC       R0, BitPos(_oldstate_3+0)
	INC        R17
	AND        R16, R17
	BRNE       L__ok142
	JMP        L__ok84
L__ok142:
;7segment displays.mbas,172 :: 		oldstate_3=0
	LDS        R27, _oldstate_3+0
	CBR        R27, BitMask(_oldstate_3+0)
	STS        _oldstate_3+0, R27
;7segment displays.mbas,173 :: 		timer_setting(0) seven_segment_add() while_state_help=1
	CLR        R2
	CALL       _timer_setting+0
	CALL       _seven_segment_add+0
	LDI        R27, 1
	STS        _while_state_help+0, R27
L__ok84:
;7segment displays.mbas,179 :: 		if (Button(Down_SW_Port, Down_SW_bit,200, 1))then    ' Detect logical one up key
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, 200
	MOV        R5, R27
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	TST        R16
	BRNE       L__ok143
	JMP        L__ok87
L__ok143:
;7segment displays.mbas,180 :: 		oldstate_3 = 1                      ' Update flag
	LDS        R27, _oldstate_3+0
	SBR        R27, BitMask(_oldstate_3+0)
	STS        _oldstate_3+0, R27
;7segment displays.mbas,182 :: 		while_state_setting_2=0
	LDI        R27, 0
	STS        _while_state_setting_2+0, R27
L__ok87:
;7segment displays.mbas,184 :: 		while while_state_setting_2=0
L__ok90:
	LDS        R16, _while_state_setting_2+0
	CPI        R16, 0
	BREQ       L__ok144
	JMP        L__ok91
L__ok144:
;7segment displays.mbas,186 :: 		timer_setting(0) seven_segment_add()
	CLR        R2
	CALL       _timer_setting+0
	CALL       _seven_segment_add+0
;7segment displays.mbas,187 :: 		if (oldstate_3 and Button(Down_SW_Port,Down_SW_bit,50,0)) then
	CLR        R6
	LDI        R27, 50
	MOV        R5, R27
	LDI        R27, 5
	MOV        R4, R27
	LDI        R27, #lo_addr(PINB+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PINB+0)
	MOV        R3, R27
	CALL       _Button+0
	LDS        R0, _oldstate_3+0
	CLR        R17
	SBRC       R0, BitPos(_oldstate_3+0)
	INC        R17
	AND        R16, R17
	BRNE       L__ok145
	JMP        L__ok95
L__ok145:
;7segment displays.mbas,188 :: 		oldstate_3=0 while_state_setting_2=11  while_state=1 while_state_setting=1  while_state_help=1
	LDS        R27, _oldstate_3+0
	CBR        R27, BitMask(_oldstate_3+0)
	STS        _oldstate_3+0, R27
	LDI        R27, 11
	STS        _while_state_setting_2+0, R27
	LDI        R27, 1
	STS        _while_state+0, R27
	LDI        R27, 1
	STS        _while_state_setting+0, R27
	LDI        R27, 1
	STS        _while_state_help+0, R27
L__ok95:
;7segment displays.mbas,191 :: 		wend
	JMP        L__ok90
L__ok91:
;7segment displays.mbas,193 :: 		wend
	JMP        L__ok43
L__ok44:
;7segment displays.mbas,198 :: 		wend
	JMP        L__ok18
L__ok19:
;7segment displays.mbas,199 :: 		end sub
L_end_ok:
	POP        R6
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
; end of _ok

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;7segment displays.mbas,203 :: 		main:
;7segment displays.mbas,217 :: 		timer1_init()  port_ini() ' int_eeprom_ini()
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	CALL       _timer1_init+0
	CALL       _port_ini+0
;7segment displays.mbas,219 :: 		PWM_Port_Initialize () PWM2_Init(_PWM2_PHASE_CORRECT_MODE, _PWM2_PRESCALER_8, _PWM2_NON_INVERTED,0)
	CALL       _PWM_Port_Initialize+0
	CLR        R5
	LDI        R27, 32
	MOV        R4, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 64
	MOV        R2, R27
	CALL       _PWM2_Init+0
;7segment displays.mbas,220 :: 		int_eeprom_ini()
	CALL       _int_eeprom_ini+0
;7segment displays.mbas,230 :: 		seconds=0 minutes=0 hours=0  '' target_sec=12      target_min=0
	LDI        R27, 0
	STS        _seconds+0, R27
	LDI        R27, 0
	STS        _minutes+0, R27
	LDI        R27, 0
	STS        _hours+0, R27
;7segment displays.mbas,231 :: 		n=0  end_flag=1
	LDI        R27, 0
	STS        _n+0, R27
	STS        _n+1, R27
	LDS        R27, _end_flag+0
	SBR        R27, BitMask(_end_flag+0)
	STS        _end_flag+0, R27
;7segment displays.mbas,232 :: 		Display_Init()
	CALL       _Display_Init+0
;7segment displays.mbas,233 :: 		delay_ms(100)
	LDI        R18, lo_addr(R5)
	LDI        R17, lo_addr(R15)
	LDI        R16, 242
L__main98:
	DEC        R16
	BRNE       L__main98
	DEC        R17
	BRNE       L__main98
	DEC        R18
	BRNE       L__main98
;7segment displays.mbas,238 :: 		while TRUE
L__main101:
;7segment displays.mbas,243 :: 		ok()
	CALL       _ok+0
;7segment displays.mbas,266 :: 		wend
	JMP        L__main101
;7segment displays.mbas,277 :: 		wend
L_end_main:
	JMP        L_end_main
; end of _main
