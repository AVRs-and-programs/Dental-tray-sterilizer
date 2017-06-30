
Libs/Alarm_clock_Key_Port_Init:

;Libs/Alarm_clock.mbas,21 :: 		sub procedure Key_Port_Init()
;Libs/Alarm_clock.mbas,31 :: 		end sub
L_end_Key_Port_Init:
	RET
; end of Libs/Alarm_clock_Key_Port_Init

_timer1_init:

;Libs/Alarm_clock.mbas,53 :: 		sub procedure timer1_init()
;Libs/Alarm_clock.mbas,54 :: 		counter1=0
	LDI        R27, 0
	STS        _counter1+0, R27
;Libs/Alarm_clock.mbas,55 :: 		DDB7_BIT=1 PORTB7_bit=not PORTB7_bit      ' toggle PORTD6_bit
	IN         R27, DDB7_bit+0
	SBR        R27, 128
	OUT        DDB7_bit+0, R27
	IN         R0, PORTB7_bit+0
	LDI        R27, 128
	EOR        R0, R27
	OUT        PORTB7_bit+0, R0
;Libs/Alarm_clock.mbas,56 :: 		second_alarm_clock=0 minutes_alarm_clock=0 hours_alarm_clock=0
	LDI        R27, 0
	STS        _second_alarm_clock+0, R27
	LDI        R27, 0
	STS        _minutes_alarm_clock+0, R27
	LDI        R27, 0
	STS        _hours_alarm_clock+0, R27
;Libs/Alarm_clock.mbas,57 :: 		Start_seconds=0 Start_minutes=0 Start_hours=0
	LDI        R27, 0
	STS        _Start_seconds+0, R27
	LDI        R27, 0
	STS        _Start_minutes+0, R27
	LDI        R27, 0
	STS        _Start_hours+0, R27
;Libs/Alarm_clock.mbas,59 :: 		SREG_I_bit = 1             ' Interrupt enable
	IN         R27, SREG_I_bit+0
	SBR        R27, 128
	OUT        SREG_I_bit+0, R27
;Libs/Alarm_clock.mbas,60 :: 		TOIE1_bit  = 1             ' Timer1 overflow interrupt enable
	IN         R27, TOIE1_bit+0
	SBR        R27, 4
	OUT        TOIE1_bit+0, R27
;Libs/Alarm_clock.mbas,61 :: 		TCCR1B = 2                 ' Start timer with 8 prescaler
	LDI        R27, 2
	OUT        TCCR1B+0, R27
;Libs/Alarm_clock.mbas,62 :: 		end sub
L_end_timer1_init:
	RET
; end of _timer1_init

_timer2_init:

;Libs/Alarm_clock.mbas,63 :: 		sub procedure timer2_init()
;Libs/Alarm_clock.mbas,72 :: 		ASSR=0x00
	LDI        R27, 0
	OUT        ASSR+0, R27
;Libs/Alarm_clock.mbas,73 :: 		TCCR2=0x04
	LDI        R27, 4
	OUT        TCCR2+0, R27
;Libs/Alarm_clock.mbas,74 :: 		TCNT2=0x06
	LDI        R27, 6
	OUT        TCNT2+0, R27
;Libs/Alarm_clock.mbas,76 :: 		TOIE2_bit  = 1             ' Timer1 overflow interrupt enable
	IN         R27, TOIE2_bit+0
	SBR        R27, 64
	OUT        TOIE2_bit+0, R27
;Libs/Alarm_clock.mbas,79 :: 		TIMSK=0x80
	LDI        R27, 128
	OUT        TIMSK+0, R27
;Libs/Alarm_clock.mbas,82 :: 		SREG_I_bit = 1                                   '' // Enable Interrupts
	IN         R27, SREG_I_bit+0
	SBR        R27, 128
	OUT        SREG_I_bit+0, R27
;Libs/Alarm_clock.mbas,83 :: 		TOIE2_bit = 1                                   ''// Timer2 overflow interrupt enable
	IN         R27, TOIE2_bit+0
	SBR        R27, 64
	OUT        TOIE2_bit+0, R27
;Libs/Alarm_clock.mbas,84 :: 		Delay_ms(100)
	LDI        R18, lo_addr(R5)
	LDI        R17, lo_addr(R15)
	LDI        R16, 242
L__timer2_init3:
	DEC        R16
	BRNE       L__timer2_init3
	DEC        R17
	BRNE       L__timer2_init3
	DEC        R18
	BRNE       L__timer2_init3
;Libs/Alarm_clock.mbas,85 :: 		DDB7_BIT=1 PORTB7_bit=not PORTB7_bit      ' toggle PORTD6_bit
	IN         R27, DDB7_bit+0
	SBR        R27, 128
	OUT        DDB7_bit+0, R27
	IN         R0, PORTB7_bit+0
	LDI        R27, 128
	EOR        R0, R27
	OUT        PORTB7_bit+0, R0
;Libs/Alarm_clock.mbas,86 :: 		second_alarm_clock=5 minutes_alarm_clock=0 hours_alarm_clock=0
	LDI        R27, 5
	STS        _second_alarm_clock+0, R27
	LDI        R27, 0
	STS        _minutes_alarm_clock+0, R27
	LDI        R27, 0
	STS        _hours_alarm_clock+0, R27
;Libs/Alarm_clock.mbas,87 :: 		Start_seconds=0 Start_minutes=0 Start_hours=0
	LDI        R27, 0
	STS        _Start_seconds+0, R27
	LDI        R27, 0
	STS        _Start_minutes+0, R27
	LDI        R27, 0
	STS        _Start_hours+0, R27
;Libs/Alarm_clock.mbas,92 :: 		end   sub
L_end_timer2_init:
	RET
; end of _timer2_init

Libs/Alarm_clock_Timer2Overflow_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Libs/Alarm_clock.mbas,116 :: 		sub procedure Timer2Overflow_ISR iv IVT_ADDR_TIMER2_OVF
;Libs/Alarm_clock.mbas,118 :: 		TCNT2=0x06
	LDI        R27, 6
	OUT        TCNT2+0, R27
;Libs/Alarm_clock.mbas,120 :: 		if (counter1 >= _THRESHOLD) then
	LDS        R16, _counter1+0
	CPI        R16, __THRESHOLD
	BRSH       L_Libs/Alarm_clock_Timer2Overflow_ISR84
	JMP        L_Libs/Alarm_clock_Timer2Overflow_ISR7
L_Libs/Alarm_clock_Timer2Overflow_ISR84:
;Libs/Alarm_clock.mbas,121 :: 		counter1 = 0              ' reset counter
	LDI        R27, 0
	STS        _counter1+0, R27
;Libs/Alarm_clock.mbas,122 :: 		inc(second_alarm_clock)
	LDS        R16, _second_alarm_clock+0
	MOV        R17, R16
	SUBI       R17, 255
	STS        _second_alarm_clock+0, R17
;Libs/Alarm_clock.mbas,123 :: 		if  second_alarm_clock>59 then
	LDI        R16, 59
	CP         R16, R17
	BRLO       L_Libs/Alarm_clock_Timer2Overflow_ISR85
	JMP        L_Libs/Alarm_clock_Timer2Overflow_ISR10
L_Libs/Alarm_clock_Timer2Overflow_ISR85:
;Libs/Alarm_clock.mbas,124 :: 		second_alarm_clock=0   inc(minutes_alarm_clock) ' reset  second_alarm_clock
	LDI        R27, 0
	STS        _second_alarm_clock+0, R27
	LDS        R16, _minutes_alarm_clock+0
	SUBI       R16, 255
	STS        _minutes_alarm_clock+0, R16
L_Libs/Alarm_clock_Timer2Overflow_ISR10:
;Libs/Alarm_clock.mbas,126 :: 		if minutes_alarm_clock>59 then
	LDS        R17, _minutes_alarm_clock+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L_Libs/Alarm_clock_Timer2Overflow_ISR86
	JMP        L_Libs/Alarm_clock_Timer2Overflow_ISR13
L_Libs/Alarm_clock_Timer2Overflow_ISR86:
;Libs/Alarm_clock.mbas,127 :: 		minutes_alarm_clock=0 inc(hours_alarm_clock)
	LDI        R27, 0
	STS        _minutes_alarm_clock+0, R27
	LDS        R16, _hours_alarm_clock+0
	SUBI       R16, 255
	STS        _hours_alarm_clock+0, R16
L_Libs/Alarm_clock_Timer2Overflow_ISR13:
;Libs/Alarm_clock.mbas,129 :: 		if hours_alarm_clock>23 then
	LDS        R17, _hours_alarm_clock+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L_Libs/Alarm_clock_Timer2Overflow_ISR87
	JMP        L_Libs/Alarm_clock_Timer2Overflow_ISR16
L_Libs/Alarm_clock_Timer2Overflow_ISR87:
;Libs/Alarm_clock.mbas,130 :: 		hours_alarm_clock=0
	LDI        R27, 0
	STS        _hours_alarm_clock+0, R27
L_Libs/Alarm_clock_Timer2Overflow_ISR16:
;Libs/Alarm_clock.mbas,131 :: 		end if
	JMP        L_Libs/Alarm_clock_Timer2Overflow_ISR8
;Libs/Alarm_clock.mbas,134 :: 		else
L_Libs/Alarm_clock_Timer2Overflow_ISR7:
;Libs/Alarm_clock.mbas,135 :: 		Inc(counter1)           ' increment counter
	LDS        R16, _counter1+0
	SUBI       R16, 255
	STS        _counter1+0, R16
;Libs/Alarm_clock.mbas,137 :: 		end if
L_Libs/Alarm_clock_Timer2Overflow_ISR8:
;Libs/Alarm_clock.mbas,138 :: 		PORTB7_bit=not PORTB7_bit      ' toggle PORTD6_bit
	IN         R0, PORTB7_bit+0
	LDI        R27, 128
	EOR        R0, R27
	OUT        PORTB7_bit+0, R0
;Libs/Alarm_clock.mbas,140 :: 		end sub
L_end_Timer2Overflow_ISR:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of Libs/Alarm_clock_Timer2Overflow_ISR

Libs/Alarm_clock_Timer1Overflow_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;Libs/Alarm_clock.mbas,143 :: 		sub procedure Timer1Overflow_ISR iv IVT_ADDR_TIMER1_OVF
;Libs/Alarm_clock.mbas,145 :: 		TCNT1L=0x06
	LDI        R27, 6
	OUT        TCNT1L+0, R27
;Libs/Alarm_clock.mbas,147 :: 		if (counter1 >= _THRESHOLD) then
	LDS        R16, _counter1+0
	CPI        R16, __THRESHOLD
	BRSH       L_Libs/Alarm_clock_Timer1Overflow_ISR91
	JMP        L_Libs/Alarm_clock_Timer1Overflow_ISR20
L_Libs/Alarm_clock_Timer1Overflow_ISR91:
;Libs/Alarm_clock.mbas,149 :: 		inc(second_alarm_clock)
	LDS        R16, _second_alarm_clock+0
	MOV        R17, R16
	SUBI       R17, 255
	STS        _second_alarm_clock+0, R17
;Libs/Alarm_clock.mbas,150 :: 		if  second_alarm_clock>59 then
	LDI        R16, 59
	CP         R16, R17
	BRLO       L_Libs/Alarm_clock_Timer1Overflow_ISR92
	JMP        L_Libs/Alarm_clock_Timer1Overflow_ISR23
L_Libs/Alarm_clock_Timer1Overflow_ISR92:
;Libs/Alarm_clock.mbas,151 :: 		second_alarm_clock=0   inc(minutes_alarm_clock) ' reset  second_alarm_clock
	LDI        R27, 0
	STS        _second_alarm_clock+0, R27
	LDS        R16, _minutes_alarm_clock+0
	SUBI       R16, 255
	STS        _minutes_alarm_clock+0, R16
L_Libs/Alarm_clock_Timer1Overflow_ISR23:
;Libs/Alarm_clock.mbas,153 :: 		if minutes_alarm_clock>59 then
	LDS        R17, _minutes_alarm_clock+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L_Libs/Alarm_clock_Timer1Overflow_ISR93
	JMP        L_Libs/Alarm_clock_Timer1Overflow_ISR26
L_Libs/Alarm_clock_Timer1Overflow_ISR93:
;Libs/Alarm_clock.mbas,154 :: 		minutes_alarm_clock=0 inc(hours_alarm_clock)
	LDI        R27, 0
	STS        _minutes_alarm_clock+0, R27
	LDS        R16, _hours_alarm_clock+0
	SUBI       R16, 255
	STS        _hours_alarm_clock+0, R16
L_Libs/Alarm_clock_Timer1Overflow_ISR26:
;Libs/Alarm_clock.mbas,156 :: 		if hours_alarm_clock>23 then
	LDS        R17, _hours_alarm_clock+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L_Libs/Alarm_clock_Timer1Overflow_ISR94
	JMP        L_Libs/Alarm_clock_Timer1Overflow_ISR29
L_Libs/Alarm_clock_Timer1Overflow_ISR94:
;Libs/Alarm_clock.mbas,157 :: 		hours_alarm_clock=0
	LDI        R27, 0
	STS        _hours_alarm_clock+0, R27
L_Libs/Alarm_clock_Timer1Overflow_ISR29:
;Libs/Alarm_clock.mbas,159 :: 		counter1 = 0
	LDI        R27, 0
	STS        _counter1+0, R27
	JMP        L_Libs/Alarm_clock_Timer1Overflow_ISR21
;Libs/Alarm_clock.mbas,162 :: 		else
L_Libs/Alarm_clock_Timer1Overflow_ISR20:
;Libs/Alarm_clock.mbas,163 :: 		Inc(counter1)           ' increment counter
	LDS        R16, _counter1+0
	SUBI       R16, 255
	STS        _counter1+0, R16
;Libs/Alarm_clock.mbas,165 :: 		end if
L_Libs/Alarm_clock_Timer1Overflow_ISR21:
;Libs/Alarm_clock.mbas,166 :: 		PORTB7_bit=not PORTB7_bit      ' toggle PORTD6_bit
	IN         R0, PORTB7_bit+0
	LDI        R27, 128
	EOR        R0, R27
	OUT        PORTB7_bit+0, R0
;Libs/Alarm_clock.mbas,168 :: 		end sub
L_end_Timer1Overflow_ISR:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of Libs/Alarm_clock_Timer1Overflow_ISR

_reset_alarm_clock:

;Libs/Alarm_clock.mbas,169 :: 		sub procedure reset_alarm_clock()
;Libs/Alarm_clock.mbas,170 :: 		second_alarm_clock=0 minutes_alarm_clock=0 hours_alarm_clock=0
	LDI        R27, 0
	STS        _second_alarm_clock+0, R27
	LDI        R27, 0
	STS        _minutes_alarm_clock+0, R27
	LDI        R27, 0
	STS        _hours_alarm_clock+0, R27
;Libs/Alarm_clock.mbas,171 :: 		end sub
L_end_reset_alarm_clock:
	RET
; end of _reset_alarm_clock

_timer_setting:

;Libs/Alarm_clock.mbas,174 :: 		sub procedure timer_setting(dim up_down as byte)
;Libs/Alarm_clock.mbas,175 :: 		if up_down=1 then             ' up_down=1 means up
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__timer_setting99
	JMP        L__timer_setting34
L__timer_setting99:
;Libs/Alarm_clock.mbas,178 :: 		inc(target_sec)
	LDS        R16, _target_sec+0
	MOV        R17, R16
	SUBI       R17, 255
	STS        _target_sec+0, R17
;Libs/Alarm_clock.mbas,179 :: 		if  target_sec>59 then
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__timer_setting100
	JMP        L__timer_setting37
L__timer_setting100:
;Libs/Alarm_clock.mbas,180 :: 		target_sec=0   inc(target_min) ' reset  second_alarm_clock
	LDI        R27, 0
	STS        _target_sec+0, R27
	LDS        R16, _target_min+0
	SUBI       R16, 255
	STS        _target_min+0, R16
L__timer_setting37:
;Libs/Alarm_clock.mbas,182 :: 		if target_min>59 then
	LDS        R17, _target_min+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__timer_setting101
	JMP        L__timer_setting40
L__timer_setting101:
;Libs/Alarm_clock.mbas,183 :: 		target_min=0 inc(target_hr)
	LDI        R27, 0
	STS        _target_min+0, R27
	LDS        R16, _target_hr+0
	SUBI       R16, 255
	STS        _target_hr+0, R16
L__timer_setting40:
;Libs/Alarm_clock.mbas,185 :: 		if target_hr>23 then
	LDS        R17, _target_hr+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__timer_setting102
	JMP        L__timer_setting43
L__timer_setting102:
;Libs/Alarm_clock.mbas,186 :: 		target_hr=0
	LDI        R27, 0
	STS        _target_hr+0, R27
L__timer_setting43:
;Libs/Alarm_clock.mbas,187 :: 		end if
	JMP        L__timer_setting35
;Libs/Alarm_clock.mbas,190 :: 		else
L__timer_setting34:
;Libs/Alarm_clock.mbas,191 :: 		dec(target_sec)
	LDS        R17, _target_sec+0
	SUBI       R17, 1
	STS        _target_sec+0, R17
;Libs/Alarm_clock.mbas,192 :: 		if  target_sec>59 then
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__timer_setting103
	JMP        L__timer_setting46
L__timer_setting103:
;Libs/Alarm_clock.mbas,193 :: 		target_sec=59  dec(target_min) ' reset  second_alarm_clock
	LDI        R27, 59
	STS        _target_sec+0, R27
	LDS        R16, _target_min+0
	SUBI       R16, 1
	STS        _target_min+0, R16
L__timer_setting46:
;Libs/Alarm_clock.mbas,195 :: 		if target_min>59 then
	LDS        R17, _target_min+0
	LDI        R16, 59
	CP         R16, R17
	BRLO       L__timer_setting104
	JMP        L__timer_setting49
L__timer_setting104:
;Libs/Alarm_clock.mbas,196 :: 		target_min=59 dec(target_hr)
	LDI        R27, 59
	STS        _target_min+0, R27
	LDS        R16, _target_hr+0
	SUBI       R16, 1
	STS        _target_hr+0, R16
L__timer_setting49:
;Libs/Alarm_clock.mbas,198 :: 		if target_hr>23 then
	LDS        R17, _target_hr+0
	LDI        R16, 23
	CP         R16, R17
	BRLO       L__timer_setting105
	JMP        L__timer_setting52
L__timer_setting105:
;Libs/Alarm_clock.mbas,199 :: 		target_hr=23
	LDI        R27, 23
	STS        _target_hr+0, R27
L__timer_setting52:
;Libs/Alarm_clock.mbas,202 :: 		end if
L__timer_setting35:
;Libs/Alarm_clock.mbas,203 :: 		end sub
L_end_timer_setting:
	RET
; end of _timer_setting

_DS1307:

;Libs/Alarm_clock.mbas,204 :: 		sub procedure DS1307(dim hours, minutes, seconds as byte)
;Libs/Alarm_clock.mbas,212 :: 		if seconds>=Start_seconds+1 or ((seconds=0) and (Start_seconds=59))  then
	LDS        R16, _Start_seconds+0
	MOV        R18, R16
	SUBI       R18, 255
	LDI        R27, 0
	CP         R4, R27
	LDI        R17, 0
	BRNE       L__DS1307107
	LDI        R17, 255
L__DS1307107:
	LDS        R16, _Start_seconds+0
	CPI        R16, 59
	LDI        R27, 0
	BRNE       L__DS1307108
	LDI        R27, 255
L__DS1307108:
	MOV        R16, R27
	AND        R16, R17
	OR         R16, R18
	CP         R4, R16
	BRSH       L__DS1307109
	JMP        L__DS130756
L__DS1307109:
;Libs/Alarm_clock.mbas,213 :: 		target_sec=target_sec+1   Start_seconds=seconds
	LDS        R16, _target_sec+0
	SUBI       R16, 255
	STS        _target_sec+0, R16
	STS        _Start_seconds+0, R4
	JMP        L__DS130757
;Libs/Alarm_clock.mbas,214 :: 		else if seconds<>Start_seconds  then
L__DS130756:
	LDS        R16, _Start_seconds+0
	CP         R4, R16
	BRNE       L__DS1307110
	JMP        L__DS130759
L__DS1307110:
;Libs/Alarm_clock.mbas,215 :: 		Start_seconds=seconds
	STS        _Start_seconds+0, R4
L__DS130759:
;Libs/Alarm_clock.mbas,217 :: 		end if
L__DS130757:
;Libs/Alarm_clock.mbas,218 :: 		if minutes>=Start_minutes+1 or ((minutes=0) and (Start_minutes=59))  then
	LDS        R16, _Start_minutes+0
	MOV        R18, R16
	SUBI       R18, 255
	LDI        R27, 0
	CP         R3, R27
	LDI        R17, 0
	BRNE       L__DS1307111
	LDI        R17, 255
L__DS1307111:
	LDS        R16, _Start_minutes+0
	CPI        R16, 59
	LDI        R27, 0
	BRNE       L__DS1307112
	LDI        R27, 255
L__DS1307112:
	MOV        R16, R27
	AND        R16, R17
	OR         R16, R18
	CP         R3, R16
	BRSH       L__DS1307113
	JMP        L__DS130762
L__DS1307113:
;Libs/Alarm_clock.mbas,219 :: 		Start_minutes=minutes
	STS        _Start_minutes+0, R3
	JMP        L__DS130763
;Libs/Alarm_clock.mbas,221 :: 		else if minutes<>Start_minutes  then
L__DS130762:
	LDS        R16, _Start_minutes+0
	CP         R3, R16
	BRNE       L__DS1307114
	JMP        L__DS130765
L__DS1307114:
;Libs/Alarm_clock.mbas,222 :: 		Start_minutes=minutes
	STS        _Start_minutes+0, R3
L__DS130765:
;Libs/Alarm_clock.mbas,224 :: 		end if
L__DS130763:
;Libs/Alarm_clock.mbas,234 :: 		if target_sec>=60 then
	LDS        R16, _target_sec+0
	CPI        R16, 60
	BRSH       L__DS1307115
	JMP        L__DS130768
L__DS1307115:
;Libs/Alarm_clock.mbas,235 :: 		target_sec=0         target_min=target_min+1
	LDI        R27, 0
	STS        _target_sec+0, R27
	LDS        R16, _target_min+0
	SUBI       R16, 255
	STS        _target_min+0, R16
L__DS130768:
;Libs/Alarm_clock.mbas,237 :: 		if target_min>=60 then
	LDS        R16, _target_min+0
	CPI        R16, 60
	BRSH       L__DS1307116
	JMP        L__DS130771
L__DS1307116:
;Libs/Alarm_clock.mbas,238 :: 		target_min=0  target_sec=0       target_hr=target_hr+1
	LDI        R27, 0
	STS        _target_min+0, R27
	LDI        R27, 0
	STS        _target_sec+0, R27
	LDS        R16, _target_hr+0
	SUBI       R16, 255
	STS        _target_hr+0, R16
L__DS130771:
;Libs/Alarm_clock.mbas,240 :: 		if target_hr>=24 then
	LDS        R16, _target_hr+0
	CPI        R16, 24
	BRSH       L__DS1307117
	JMP        L__DS130774
L__DS1307117:
;Libs/Alarm_clock.mbas,241 :: 		target_hr=0 target_min=0 target_sec=0
	LDI        R27, 0
	STS        _target_hr+0, R27
	LDI        R27, 0
	STS        _target_min+0, R27
	LDI        R27, 0
	STS        _target_sec+0, R27
L__DS130774:
;Libs/Alarm_clock.mbas,257 :: 		end sub
L_end_DS1307:
	RET
; end of _DS1307
