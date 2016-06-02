_pin_reset:
;Reset_Routines.c,12 :: 		void pin_reset() {
;Reset_Routines.c,13 :: 		RST = 0;  // activate reset
MOVS	R1, #0
MOVW	R0, #lo_addr(RST+0)
MOVT	R0, #hi_addr(RST+0)
STR	R1, [R0, #0]
;Reset_Routines.c,14 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_pin_reset0:
SUBS	R7, R7, #1
BNE	L_pin_reset0
NOP
NOP
NOP
;Reset_Routines.c,15 :: 		RST = 1;  // deactivate reset
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RST+0)
MOVT	R0, #hi_addr(RST+0)
STR	R1, [R0, #0]
;Reset_Routines.c,16 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_pin_reset2:
SUBS	R7, R7, #1
BNE	L_pin_reset2
NOP
NOP
NOP
;Reset_Routines.c,17 :: 		}
L_end_pin_reset:
BX	LR
; end of _pin_reset
_PWR_reset:
;Reset_Routines.c,19 :: 		void PWR_reset() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reset_Routines.c,20 :: 		write_ZIGBEE_short(SOFTRST, 0x04);   // 0x04  mask for RSTPWR bit
MOVS	R1, #4
SXTB	R1, R1
MOVS	R0, #42
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Reset_Routines.c,21 :: 		}
L_end_PWR_reset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _PWR_reset
_BB_reset:
;Reset_Routines.c,23 :: 		void BB_reset() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reset_Routines.c,24 :: 		write_ZIGBEE_short(SOFTRST, 0x02);   // 0x02 mask for RSTBB bit
MOVS	R1, #2
SXTB	R1, R1
MOVS	R0, #42
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Reset_Routines.c,25 :: 		}
L_end_BB_reset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _BB_reset
_MAC_reset:
;Reset_Routines.c,27 :: 		void MAC_reset() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reset_Routines.c,28 :: 		write_ZIGBEE_short(SOFTRST, 0x01);   // 0x01 mask for RSTMAC bit
MOVS	R1, #1
SXTB	R1, R1
MOVS	R0, #42
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Reset_Routines.c,29 :: 		}
L_end_MAC_reset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MAC_reset
_software_reset:
;Reset_Routines.c,31 :: 		void software_reset() {                // PWR_reset,BB_reset and MAC_reset at once
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reset_Routines.c,32 :: 		write_ZIGBEE_short(SOFTRST, 0x07);
MOVS	R1, #7
SXTB	R1, R1
MOVS	R0, #42
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Reset_Routines.c,33 :: 		}
L_end_software_reset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _software_reset
_RF_reset:
;Reset_Routines.c,35 :: 		void RF_reset() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Reset_Routines.c,36 :: 		short int temp = 0;
;Reset_Routines.c,37 :: 		temp = read_ZIGBEE_short(RFCTL);
MOVS	R0, #54
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Reset_Routines.c,38 :: 		temp = temp | 0x04;                  // mask for RFRST bit
ORR	R0, R0, #4
; temp start address is: 4 (R1)
SXTB	R1, R0
;Reset_Routines.c,39 :: 		write_ZIGBEE_short(RFCTL, temp);
STRB	R1, [SP, #4]
SXTB	R1, R0
MOVS	R0, #54
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
LDRSB	R1, [SP, #4]
;Reset_Routines.c,40 :: 		temp = temp & (!0x04);               // mask for RFRST bit
AND	R0, R1, #0
; temp end address is: 4 (R1)
;Reset_Routines.c,41 :: 		write_ZIGBEE_short(RFCTL, temp);
SXTB	R1, R0
MOVS	R0, #54
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Reset_Routines.c,42 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_RF_reset4:
SUBS	R7, R7, #1
BNE	L_RF_reset4
NOP
NOP
NOP
;Reset_Routines.c,43 :: 		}
L_end_RF_reset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _RF_reset
