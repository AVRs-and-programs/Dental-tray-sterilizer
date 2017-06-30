
_int_eeprom_ini:

;Libs/EEProm.mbas,11 :: 		sub procedure int_eeprom_ini()     ''internal eeprm of avr
;Libs/EEProm.mbas,14 :: 		if  (EEPROM_Read(0x00)=12)   then
	PUSH       R2
	PUSH       R3
	PUSH       R4
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	CPI        R16, 12
	BREQ       L__int_eeprom_ini9
	JMP        L__int_eeprom_ini2
L__int_eeprom_ini9:
;Libs/EEProm.mbas,15 :: 		eeprom_call_back()
	CALL       _eeprom_call_back+0
	JMP        L__int_eeprom_ini3
;Libs/EEProm.mbas,16 :: 		else
L__int_eeprom_ini2:
;Libs/EEProm.mbas,17 :: 		EEPROM_Write(0x00 ,12 )
	LDI        R27, 12
	MOV        R4, R27
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;Libs/EEProm.mbas,19 :: 		target_enable=1  target_sec=18      target_min=0
	LDI        R27, 1
	STS        _target_enable+0, R27
	LDI        R27, 18
	STS        _target_sec+0, R27
	LDI        R27, 0
	STS        _target_min+0, R27
;Libs/EEProm.mbas,20 :: 		target_pwm =10    target_interval=4
	LDI        R27, 10
	STS        _target_pwm+0, R27
	LDI        R27, 4
	STS        _target_interval+0, R27
;Libs/EEProm.mbas,21 :: 		eeprom_save()
	CALL       _eeprom_save+0
;Libs/EEProm.mbas,25 :: 		end if
L__int_eeprom_ini3:
;Libs/EEProm.mbas,26 :: 		Delay_mS(1500)
	LDI        R18, 61
	LDI        R17, 225
	LDI        R16, 64
L__int_eeprom_ini4:
	DEC        R16
	BRNE       L__int_eeprom_ini4
	DEC        R17
	BRNE       L__int_eeprom_ini4
	DEC        R18
	BRNE       L__int_eeprom_ini4
	NOP
	NOP
;Libs/EEProm.mbas,27 :: 		end sub
L_end_int_eeprom_ini:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _int_eeprom_ini

_eeprom_call_back:

;Libs/EEProm.mbas,30 :: 		sub procedure eeprom_call_back()
;Libs/EEProm.mbas,32 :: 		Mot_On_mSec [0]=EEPROM_read(0x01 )
	PUSH       R2
	PUSH       R3
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Mot_On_mSec+0, R16
;Libs/EEProm.mbas,33 :: 		Mot_On_mSec [1]=EEPROM_read(0x02 )
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Mot_On_mSec+1, R16
;Libs/EEProm.mbas,34 :: 		Mot_On_mSec [2]=EEPROM_read(0x03 )
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Mot_On_mSec+2, R16
;Libs/EEProm.mbas,35 :: 		Mot_On_mSec [3]=EEPROM_read(0x04 )
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Mot_On_mSec+3, R16
;Libs/EEProm.mbas,36 :: 		Mot_On_mSec [4]=EEPROM_read(0x05 )
	LDI        R27, 5
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
	STS        _Mot_On_mSec+4, R16
;Libs/EEProm.mbas,39 :: 		target_enable=Mot_On_mSec[0]  target_sec=Mot_On_mSec[1]      target_min=Mot_On_mSec[2]
	LDS        R16, _Mot_On_mSec+0
	STS        _target_enable+0, R16
	LDS        R16, _Mot_On_mSec+1
	STS        _target_sec+0, R16
	LDS        R16, _Mot_On_mSec+2
	STS        _target_min+0, R16
;Libs/EEProm.mbas,40 :: 		target_pwm =Mot_On_mSec[3]    target_interval=Mot_On_mSec[4]
	LDS        R16, _Mot_On_mSec+3
	STS        _target_pwm+0, R16
	LDS        R16, _Mot_On_mSec+4
	STS        _target_interval+0, R16
;Libs/EEProm.mbas,41 :: 		end sub
L_end_eeprom_call_back:
	POP        R3
	POP        R2
	RET
; end of _eeprom_call_back

_eeprom_save:

;Libs/EEProm.mbas,44 :: 		sub procedure eeprom_save()
;Libs/EEProm.mbas,45 :: 		Mot_On_mSec[0]=target_enable Mot_On_mSec[1]=target_sec  Mot_On_mSec[2]=target_min
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDS        R16, _target_enable+0
	STS        _Mot_On_mSec+0, R16
	LDS        R16, _target_sec+0
	STS        _Mot_On_mSec+1, R16
	LDS        R16, _target_min+0
	STS        _Mot_On_mSec+2, R16
;Libs/EEProm.mbas,46 :: 		Mot_On_mSec[3]=target_pwm    Mot_On_mSec[4]=target_interval
	LDS        R16, _target_pwm+0
	STS        _Mot_On_mSec+3, R16
	LDS        R16, _target_interval+0
	STS        _Mot_On_mSec+4, R16
;Libs/EEProm.mbas,48 :: 		EEPROM_Write(0x01,Mot_On_mSec[0])
	LDS        R4, _Mot_On_mSec+0
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Libs/EEProm.mbas,49 :: 		EEPROM_Write(0x02,Mot_On_mSec[1])
	LDS        R4, _Mot_On_mSec+1
	LDI        R27, 2
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Libs/EEProm.mbas,50 :: 		EEPROM_Write(0x03,Mot_On_mSec[2])
	LDS        R4, _Mot_On_mSec+2
	LDI        R27, 3
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Libs/EEProm.mbas,51 :: 		EEPROM_Write(0x04,Mot_On_mSec[3])
	LDS        R4, _Mot_On_mSec+3
	LDI        R27, 4
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Libs/EEProm.mbas,52 :: 		EEPROM_Write(0x05,Mot_On_mSec[4])
	LDS        R4, _Mot_On_mSec+4
	LDI        R27, 5
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;Libs/EEProm.mbas,55 :: 		end sub
L_end_eeprom_save:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _eeprom_save
