_enable_interrupt:
;Misc_Routines.c,11 :: 		void enable_interrupt() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,12 :: 		write_ZIGBEE_short(INTCON_M, 0x00);   //0x00  all INTerrupts are enable
MOVS	R1, #0
SXTB	R1, R1
MOVS	R0, #50
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,13 :: 		}
L_end_enable_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _enable_interrupt
_set_channel:
;Misc_Routines.c,18 :: 		void set_channel(short int channel_number) {               // 11-26 possible channels
; channel_number start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; channel_number end address is: 0 (R0)
; channel_number start address is: 0 (R0)
;Misc_Routines.c,19 :: 		if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
CMP	R0, #26
IT	GT
BGT	L__set_channel57
CMP	R0, #11
IT	LT
BLT	L__set_channel56
; channel_number end address is: 0 (R0)
IT	AL
BAL	L_set_channel2
L__set_channel57:
L__set_channel56:
; channel_number start address is: 0 (R0)
MOVS	R0, #11
SXTB	R0, R0
; channel_number end address is: 0 (R0)
L_set_channel2:
;Misc_Routines.c,20 :: 		switch(channel_number) {
; channel_number start address is: 0 (R0)
IT	AL
BAL	L_set_channel3
; channel_number end address is: 0 (R0)
;Misc_Routines.c,21 :: 		case 11:
L_set_channel5:
;Misc_Routines.c,22 :: 		write_ZIGBEE_long(RFCON0, 0x02);  // 0x02 for 11. channel
MOVS	R1, #2
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,23 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,24 :: 		case 12:
L_set_channel6:
;Misc_Routines.c,25 :: 		write_ZIGBEE_long(RFCON0, 0x12);  // 0x12 for 12. channel
MOVS	R1, #18
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,26 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,27 :: 		case 13:
L_set_channel7:
;Misc_Routines.c,28 :: 		write_ZIGBEE_long(RFCON0, 0x22);  // 0x22 for 13. channel
MOVS	R1, #34
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,29 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,30 :: 		case 14:
L_set_channel8:
;Misc_Routines.c,31 :: 		write_ZIGBEE_long(RFCON0, 0x32);  // 0x32 for 14. channel
MOVS	R1, #50
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,32 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,33 :: 		case 15:
L_set_channel9:
;Misc_Routines.c,34 :: 		write_ZIGBEE_long(RFCON0, 0x42);  // 0x42 for 15. channel
MOVS	R1, #66
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,35 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,36 :: 		case 16:
L_set_channel10:
;Misc_Routines.c,37 :: 		write_ZIGBEE_long(RFCON0, 0x52);  // 0x52 for 16. channel
MOVS	R1, #82
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,38 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,39 :: 		case 17:
L_set_channel11:
;Misc_Routines.c,40 :: 		write_ZIGBEE_long(RFCON0, 0x62);  // 0x62 for 17. channel
MOVS	R1, #98
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,41 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,42 :: 		case 18:
L_set_channel12:
;Misc_Routines.c,43 :: 		write_ZIGBEE_long(RFCON0, 0x72);  // 0x72 for 18. channel
MOVS	R1, #114
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,44 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,45 :: 		case 19:
L_set_channel13:
;Misc_Routines.c,46 :: 		write_ZIGBEE_long(RFCON0, 0x82);  // 0x82 for 19. channel
MOVS	R1, #130
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,47 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,48 :: 		case 20:
L_set_channel14:
;Misc_Routines.c,49 :: 		write_ZIGBEE_long(RFCON0, 0x92);  // 0x92 for 20. channel
MOVS	R1, #146
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,50 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,51 :: 		case 21:
L_set_channel15:
;Misc_Routines.c,52 :: 		write_ZIGBEE_long(RFCON0, 0xA2);  // 0xA2 for 21. channel
MOVS	R1, #162
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,53 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,54 :: 		case 22:
L_set_channel16:
;Misc_Routines.c,55 :: 		write_ZIGBEE_long(RFCON0, 0xB2);  // 0xB2 for 22. channel
MOVS	R1, #178
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,56 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,57 :: 		case 23:
L_set_channel17:
;Misc_Routines.c,58 :: 		write_ZIGBEE_long(RFCON0, 0xC2);  // 0xC2 for 23. channel
MOVS	R1, #194
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,59 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,60 :: 		case 24:
L_set_channel18:
;Misc_Routines.c,61 :: 		write_ZIGBEE_long(RFCON0, 0xD2);  // 0xD2 for 24. channel
MOVS	R1, #210
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,62 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,63 :: 		case 25:
L_set_channel19:
;Misc_Routines.c,64 :: 		write_ZIGBEE_long(RFCON0, 0xE2);  // 0xE2 for 25. channel
MOVS	R1, #226
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,65 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,66 :: 		case 26:
L_set_channel20:
;Misc_Routines.c,67 :: 		write_ZIGBEE_long(RFCON0, 0xF2);  // 0xF2 for 26. channel
MOVS	R1, #242
SXTB	R1, R1
MOVW	R0, #512
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,68 :: 		break;
IT	AL
BAL	L_set_channel4
;Misc_Routines.c,69 :: 		}
L_set_channel3:
; channel_number start address is: 0 (R0)
CMP	R0, #11
IT	EQ
BEQ	L_set_channel5
CMP	R0, #12
IT	EQ
BEQ	L_set_channel6
CMP	R0, #13
IT	EQ
BEQ	L_set_channel7
CMP	R0, #14
IT	EQ
BEQ	L_set_channel8
CMP	R0, #15
IT	EQ
BEQ	L_set_channel9
CMP	R0, #16
IT	EQ
BEQ	L_set_channel10
CMP	R0, #17
IT	EQ
BEQ	L_set_channel11
CMP	R0, #18
IT	EQ
BEQ	L_set_channel12
CMP	R0, #19
IT	EQ
BEQ	L_set_channel13
CMP	R0, #20
IT	EQ
BEQ	L_set_channel14
CMP	R0, #21
IT	EQ
BEQ	L_set_channel15
CMP	R0, #22
IT	EQ
BEQ	L_set_channel16
CMP	R0, #23
IT	EQ
BEQ	L_set_channel17
CMP	R0, #24
IT	EQ
BEQ	L_set_channel18
CMP	R0, #25
IT	EQ
BEQ	L_set_channel19
CMP	R0, #26
IT	EQ
BEQ	L_set_channel20
; channel_number end address is: 0 (R0)
L_set_channel4:
;Misc_Routines.c,70 :: 		RF_reset();
BL	_RF_reset+0
;Misc_Routines.c,71 :: 		}
L_end_set_channel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_channel
_set_CCA_mode:
;Misc_Routines.c,76 :: 		void set_CCA_mode(short int CCA_mode) {
; CCA_mode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; CCA_mode end address is: 0 (R0)
; CCA_mode start address is: 0 (R0)
;Misc_Routines.c,77 :: 		short int temp = 0;
;Misc_Routines.c,78 :: 		switch(CCA_mode) {
IT	AL
BAL	L_set_CCA_mode21
; CCA_mode end address is: 0 (R0)
;Misc_Routines.c,79 :: 		case 1: {                               // ENERGY ABOVE THRESHOLD
L_set_CCA_mode23:
;Misc_Routines.c,80 :: 		temp = read_ZIGBEE_short(BBREG2);
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,81 :: 		temp = temp | 0x80;                   // 0x80 mask
ORR	R1, R0, #128
;Misc_Routines.c,82 :: 		temp = temp & 0xDF;                   // 0xDF mask
SXTB	R1, R1
AND	R1, R1, #223
;Misc_Routines.c,83 :: 		write_ZIGBEE_short(BBREG2, temp);
SXTB	R1, R1
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,84 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
MOVS	R1, #96
SXTB	R1, R1
MOVS	R0, #63
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,86 :: 		break;
IT	AL
BAL	L_set_CCA_mode22
;Misc_Routines.c,88 :: 		case 2: {                               // CARRIER SENSE ONLY
L_set_CCA_mode24:
;Misc_Routines.c,89 :: 		temp = read_ZIGBEE_short(BBREG2);
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,90 :: 		temp = temp | 0x40;                   // 0x40 mask
ORR	R1, R0, #64
SXTB	R1, R1
;Misc_Routines.c,91 :: 		temp = temp & 0x7F;                   // 0x7F mask
AND	R1, R1, #127
;Misc_Routines.c,92 :: 		write_ZIGBEE_short(BBREG2, temp);
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,94 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,95 :: 		temp = temp | 0x38;
ORR	R1, R0, #56
SXTB	R1, R1
;Misc_Routines.c,96 :: 		temp = temp & 0xFB;
AND	R1, R1, #251
;Misc_Routines.c,97 :: 		write_ZIGBEE_short(BBREG2, temp);
SXTB	R1, R1
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,99 :: 		break;
IT	AL
BAL	L_set_CCA_mode22
;Misc_Routines.c,101 :: 		case 3: {                               // CARRIER SENSE AND ENERGY ABOVE THRESHOLD
L_set_CCA_mode25:
;Misc_Routines.c,102 :: 		temp = read_ZIGBEE_short(BBREG2);
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,103 :: 		temp = temp | 0xC0;                   // 0xC0 mask
ORR	R1, R0, #192
;Misc_Routines.c,104 :: 		write_ZIGBEE_short(BBREG2, temp);
SXTB	R1, R1
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,106 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
MOVS	R0, #58
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,107 :: 		temp = temp | 0x38;                   // 0x38 mask
ORR	R1, R0, #56
SXTB	R1, R1
;Misc_Routines.c,108 :: 		temp = temp & 0xFB;                   // 0xFB mask
AND	R1, R1, #251
;Misc_Routines.c,109 :: 		write_ZIGBEE_short(BBREG2, temp);
SXTB	R1, R1
MOVS	R0, #58
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,111 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
MOVS	R1, #96
SXTB	R1, R1
MOVS	R0, #63
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,113 :: 		break;
IT	AL
BAL	L_set_CCA_mode22
;Misc_Routines.c,114 :: 		}
L_set_CCA_mode21:
; CCA_mode start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_set_CCA_mode23
CMP	R0, #2
IT	EQ
BEQ	L_set_CCA_mode24
CMP	R0, #3
IT	EQ
BEQ	L_set_CCA_mode25
; CCA_mode end address is: 0 (R0)
L_set_CCA_mode22:
;Misc_Routines.c,115 :: 		}
L_end_set_CCA_mode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_CCA_mode
_set_RSSI_mode:
;Misc_Routines.c,120 :: 		void set_RSSI_mode(short int RSSI_mode) {       // 1 for RSSI1, 2 for RSSI2 mode
; RSSI_mode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; RSSI_mode end address is: 0 (R0)
; RSSI_mode start address is: 0 (R0)
;Misc_Routines.c,121 :: 		short int temp = 0;
;Misc_Routines.c,123 :: 		switch(RSSI_mode) {
IT	AL
BAL	L_set_RSSI_mode26
; RSSI_mode end address is: 0 (R0)
;Misc_Routines.c,124 :: 		case 1: {
L_set_RSSI_mode28:
;Misc_Routines.c,125 :: 		temp = read_ZIGBEE_short(BBREG6);
MOVS	R0, #62
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,126 :: 		temp = temp | 0x80;                       // 0x80 mask for RSSI1 mode
ORR	R1, R0, #128
;Misc_Routines.c,127 :: 		write_ZIGBEE_short(BBREG6, temp);
SXTB	R1, R1
MOVS	R0, #62
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,129 :: 		break;
IT	AL
BAL	L_set_RSSI_mode27
;Misc_Routines.c,131 :: 		case 2:
L_set_RSSI_mode29:
;Misc_Routines.c,132 :: 		write_ZIGBEE_short(BBREG6, 0x40);         // 0x40 data for RSSI2 mode
MOVS	R1, #64
SXTB	R1, R1
MOVS	R0, #62
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,133 :: 		break;
IT	AL
BAL	L_set_RSSI_mode27
;Misc_Routines.c,134 :: 		}
L_set_RSSI_mode26:
; RSSI_mode start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_set_RSSI_mode28
CMP	R0, #2
IT	EQ
BEQ	L_set_RSSI_mode29
; RSSI_mode end address is: 0 (R0)
L_set_RSSI_mode27:
;Misc_Routines.c,135 :: 		}
L_end_set_RSSI_mode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_RSSI_mode
_nonbeacon_PAN_coordinator_device:
;Misc_Routines.c,140 :: 		void nonbeacon_PAN_coordinator_device() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,141 :: 		short int temp = 0;
;Misc_Routines.c,143 :: 		temp = read_ZIGBEE_short(RXMCR);
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,144 :: 		temp = temp | 0x08;                 // 0x08 mask for PAN coordinator
ORR	R0, R0, #8
;Misc_Routines.c,145 :: 		write_ZIGBEE_short(RXMCR, temp);
SXTB	R1, R0
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,147 :: 		temp = read_ZIGBEE_short(TXMCR);
MOVS	R0, #17
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,148 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
AND	R0, R0, #223
;Misc_Routines.c,149 :: 		write_ZIGBEE_short(TXMCR, temp);
SXTB	R1, R0
MOVS	R0, #17
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,151 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO are 15
MOVS	R1, #255
SXTB	R1, R1
MOVS	R0, #16
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,152 :: 		}
L_end_nonbeacon_PAN_coordinator_device:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _nonbeacon_PAN_coordinator_device
_nonbeacon_coordinator_device:
;Misc_Routines.c,154 :: 		void nonbeacon_coordinator_device() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,155 :: 		short int temp = 0;
;Misc_Routines.c,157 :: 		temp = read_ZIGBEE_short(RXMCR);
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,158 :: 		temp = temp | 0x04;                 // 0x04 mask for coordinator
ORR	R0, R0, #4
;Misc_Routines.c,159 :: 		write_ZIGBEE_short(RXMCR, temp);
SXTB	R1, R0
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,161 :: 		temp = read_ZIGBEE_short(TXMCR);
MOVS	R0, #17
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,162 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
AND	R0, R0, #223
;Misc_Routines.c,163 :: 		write_ZIGBEE_short(TXMCR, temp);
SXTB	R1, R0
MOVS	R0, #17
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,165 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO  are 15
MOVS	R1, #255
SXTB	R1, R1
MOVS	R0, #16
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,166 :: 		}
L_end_nonbeacon_coordinator_device:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _nonbeacon_coordinator_device
_nonbeacon_device:
;Misc_Routines.c,168 :: 		void nonbeacon_device() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,169 :: 		short int temp = 0;
;Misc_Routines.c,171 :: 		temp = read_ZIGBEE_short(RXMCR);
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,172 :: 		temp = temp & 0xF3;                 // 0xF3 mask for PAN coordinator and coordinator
AND	R0, R0, #243
;Misc_Routines.c,173 :: 		write_ZIGBEE_short(RXMCR, temp);
SXTB	R1, R0
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,175 :: 		temp = read_ZIGBEE_short(TXMCR);
MOVS	R0, #17
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,176 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
AND	R0, R0, #223
;Misc_Routines.c,177 :: 		write_ZIGBEE_short(TXMCR, temp);
SXTB	R1, R0
MOVS	R0, #17
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,178 :: 		}
L_end_nonbeacon_device:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _nonbeacon_device
_set_ACK:
;Misc_Routines.c,183 :: 		void set_ACK() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,184 :: 		short int temp = 0;
;Misc_Routines.c,186 :: 		temp = read_ZIGBEE_short(TXNCON);
MOVS	R0, #27
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,187 :: 		temp = temp | 0x04;                 // 0x04 mask for set ACK
ORR	R0, R0, #4
;Misc_Routines.c,188 :: 		write_ZIGBEE_short(TXNCON, temp);
SXTB	R1, R0
MOVS	R0, #27
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,189 :: 		}
L_end_set_ACK:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_ACK
_set_not_ACK:
;Misc_Routines.c,191 :: 		void set_not_ACK() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,192 :: 		short int temp = 0;
;Misc_Routines.c,194 :: 		temp = read_ZIGBEE_short(TXNCON);
MOVS	R0, #27
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,195 :: 		temp = temp & (!0x04);              // 0x04 mask for set not ACK
AND	R0, R0, #0
;Misc_Routines.c,196 :: 		write_ZIGBEE_short(TXNCON, temp);
SXTB	R1, R0
MOVS	R0, #27
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,197 :: 		}
L_end_set_not_ACK:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_not_ACK
_set_encrypt:
;Misc_Routines.c,202 :: 		void set_encrypt() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,203 :: 		short int temp = 0;
;Misc_Routines.c,205 :: 		temp = read_ZIGBEE_short(TXNCON);
MOVS	R0, #27
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,206 :: 		temp = temp | 0x02;                 // mask for set encrypt
ORR	R0, R0, #2
;Misc_Routines.c,207 :: 		write_ZIGBEE_short(TXNCON, temp);
SXTB	R1, R0
MOVS	R0, #27
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,208 :: 		}
L_end_set_encrypt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_encrypt
_set_not_encrypt:
;Misc_Routines.c,210 :: 		void set_not_encrypt(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,211 :: 		short int temp = 0;
;Misc_Routines.c,213 :: 		temp = read_ZIGBEE_short(TXNCON);
MOVS	R0, #27
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,214 :: 		temp = temp & (!0x02);              // mask for set not encrypt
AND	R0, R0, #0
;Misc_Routines.c,215 :: 		write_ZIGBEE_short(TXNCON, temp);
SXTB	R1, R0
MOVS	R0, #27
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,216 :: 		}
L_end_set_not_encrypt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_not_encrypt
_set_IFS_recomended:
;Misc_Routines.c,221 :: 		void set_IFS_recomended() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,222 :: 		short int temp = 0;
;Misc_Routines.c,224 :: 		write_ZIGBEE_short(RXMCR, 0x93);    // Min SIFS Period
MOVS	R1, #147
SXTB	R1, R1
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,226 :: 		temp = read_ZIGBEE_short(TXPEND);
MOVS	R0, #33
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,227 :: 		temp = temp | 0x7C;                 // MinLIFSPeriod
ORR	R0, R0, #124
;Misc_Routines.c,228 :: 		write_ZIGBEE_short(TXPEND, temp);
SXTB	R1, R0
MOVS	R0, #33
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,230 :: 		temp = read_ZIGBEE_short(TXSTBL);
MOVS	R0, #46
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,231 :: 		temp = temp | 0x90;                 // MinLIFSPeriod
ORR	R0, R0, #144
;Misc_Routines.c,232 :: 		write_ZIGBEE_short(TXSTBL, temp);
SXTB	R1, R0
MOVS	R0, #46
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,234 :: 		temp = read_ZIGBEE_short(TXTIME);
MOVS	R0, #39
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,235 :: 		temp = temp | 0x31;                 // TurnaroundTime
ORR	R0, R0, #49
;Misc_Routines.c,236 :: 		write_ZIGBEE_short(TXTIME, temp);
SXTB	R1, R0
MOVS	R0, #39
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,237 :: 		}
L_end_set_IFS_recomended:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_IFS_recomended
_set_IFS_default:
;Misc_Routines.c,239 :: 		void set_IFS_default() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,240 :: 		short int temp = 0;
;Misc_Routines.c,242 :: 		write_ZIGBEE_short(RXMCR, 0x75);    // Min SIFS Period
MOVS	R1, #117
SXTB	R1, R1
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,244 :: 		temp = read_ZIGBEE_short(TXPEND);
MOVS	R0, #33
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,245 :: 		temp = temp | 0x84;                 // Min LIFS Period
ORR	R0, R0, #132
;Misc_Routines.c,246 :: 		write_ZIGBEE_short(TXPEND, temp);
SXTB	R1, R0
MOVS	R0, #33
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,248 :: 		temp = read_ZIGBEE_short(TXSTBL);
MOVS	R0, #46
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,249 :: 		temp = temp | 0x50;                 // Min LIFS Period
ORR	R0, R0, #80
;Misc_Routines.c,250 :: 		write_ZIGBEE_short(TXSTBL, temp);
SXTB	R1, R0
MOVS	R0, #46
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,252 :: 		temp = read_ZIGBEE_short(TXTIME);
MOVS	R0, #39
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,253 :: 		temp = temp | 0x41;                 // Turnaround Time
ORR	R0, R0, #65
;Misc_Routines.c,254 :: 		write_ZIGBEE_short(TXTIME, temp);
SXTB	R1, R0
MOVS	R0, #39
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,255 :: 		}
L_end_set_IFS_default:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_IFS_default
_set_reception_mode:
;Misc_Routines.c,260 :: 		void set_reception_mode(short int r_mode) { // 1 normal, 2 error, 3 promiscuous mode
; r_mode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; r_mode end address is: 0 (R0)
; r_mode start address is: 0 (R0)
;Misc_Routines.c,261 :: 		short int temp = 0;
;Misc_Routines.c,263 :: 		switch(r_mode) {
IT	AL
BAL	L_set_reception_mode30
; r_mode end address is: 0 (R0)
;Misc_Routines.c,264 :: 		case 1: {
L_set_reception_mode32:
;Misc_Routines.c,265 :: 		temp = read_ZIGBEE_short(RXMCR);      // normal mode
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,266 :: 		temp = temp & (!0x03);                // mask for normal mode
AND	R1, R0, #0
;Misc_Routines.c,267 :: 		write_ZIGBEE_short(RXMCR, temp);
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,269 :: 		break;
IT	AL
BAL	L_set_reception_mode31
;Misc_Routines.c,271 :: 		case 2: {
L_set_reception_mode33:
;Misc_Routines.c,272 :: 		temp = read_ZIGBEE_short(RXMCR);      // error mode
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,273 :: 		temp = temp & (!0x01);                // mask for error mode
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,274 :: 		temp = temp | 0x02;                   // mask for error mode
ORR	R1, R1, #2
;Misc_Routines.c,275 :: 		write_ZIGBEE_short(RXMCR, temp);
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,277 :: 		break;
IT	AL
BAL	L_set_reception_mode31
;Misc_Routines.c,279 :: 		case 3: {
L_set_reception_mode34:
;Misc_Routines.c,280 :: 		temp = read_ZIGBEE_short(RXMCR);      // promiscuous mode
MOVS	R0, #0
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,281 :: 		temp = temp & (!0x02);                // mask for promiscuous mode
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,282 :: 		temp = temp | 0x01;                   // mask for promiscuous mode
ORR	R1, R1, #1
;Misc_Routines.c,283 :: 		write_ZIGBEE_short(RXMCR, temp);
MOVS	R0, #0
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,285 :: 		break;
IT	AL
BAL	L_set_reception_mode31
;Misc_Routines.c,286 :: 		}
L_set_reception_mode30:
; r_mode start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_set_reception_mode32
CMP	R0, #2
IT	EQ
BEQ	L_set_reception_mode33
CMP	R0, #3
IT	EQ
BEQ	L_set_reception_mode34
; r_mode end address is: 0 (R0)
L_set_reception_mode31:
;Misc_Routines.c,287 :: 		}
L_end_set_reception_mode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_reception_mode
_set_frame_format_filter:
;Misc_Routines.c,292 :: 		void set_frame_format_filter(short int fff_mode) {   // 1 all frames, 2 command only, 3 data only, 4 beacon only
; fff_mode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; fff_mode end address is: 0 (R0)
; fff_mode start address is: 0 (R0)
;Misc_Routines.c,293 :: 		short int temp = 0;
;Misc_Routines.c,295 :: 		switch(fff_mode) {
IT	AL
BAL	L_set_frame_format_filter35
; fff_mode end address is: 0 (R0)
;Misc_Routines.c,296 :: 		case 1: {
L_set_frame_format_filter37:
;Misc_Routines.c,297 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // all frames
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,298 :: 		temp = temp & (!0x0E);                  // mask for all frames
AND	R1, R0, #0
;Misc_Routines.c,299 :: 		write_ZIGBEE_short(RXFLUSH, temp);
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,301 :: 		break;
IT	AL
BAL	L_set_frame_format_filter36
;Misc_Routines.c,303 :: 		case 2: {
L_set_frame_format_filter38:
;Misc_Routines.c,304 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // command only
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,305 :: 		temp = temp & (!0x06);                  // mask for command only
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,306 :: 		temp = temp | 0x08;                     // mask for command only
ORR	R1, R1, #8
;Misc_Routines.c,307 :: 		write_ZIGBEE_short(RXFLUSH, temp);
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,309 :: 		break;
IT	AL
BAL	L_set_frame_format_filter36
;Misc_Routines.c,311 :: 		case 3: {
L_set_frame_format_filter39:
;Misc_Routines.c,312 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // data only
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,313 :: 		temp = temp & (!0x0A);                  // mask for data only
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,314 :: 		temp = temp | 0x04;                     // mask for data only
ORR	R1, R1, #4
;Misc_Routines.c,315 :: 		write_ZIGBEE_short(RXFLUSH, temp);
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,317 :: 		break;
IT	AL
BAL	L_set_frame_format_filter36
;Misc_Routines.c,319 :: 		case 4: {
L_set_frame_format_filter40:
;Misc_Routines.c,320 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // beacon only
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,321 :: 		temp = temp & (!0x0C);                  // mask for beacon only
AND	R1, R0, #0
SXTB	R1, R1
;Misc_Routines.c,322 :: 		temp = temp | 0x02;                     // mask for beacon only
ORR	R1, R1, #2
;Misc_Routines.c,323 :: 		write_ZIGBEE_short(RXFLUSH, temp);
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,325 :: 		break;
IT	AL
BAL	L_set_frame_format_filter36
;Misc_Routines.c,326 :: 		}
L_set_frame_format_filter35:
; fff_mode start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_set_frame_format_filter37
CMP	R0, #2
IT	EQ
BEQ	L_set_frame_format_filter38
CMP	R0, #3
IT	EQ
BEQ	L_set_frame_format_filter39
CMP	R0, #4
IT	EQ
BEQ	L_set_frame_format_filter40
; fff_mode end address is: 0 (R0)
L_set_frame_format_filter36:
;Misc_Routines.c,327 :: 		}
L_end_set_frame_format_filter:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_frame_format_filter
_flush_RX_FIFO_pointer:
;Misc_Routines.c,332 :: 		void flush_RX_FIFO_pointer() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,335 :: 		temp = read_ZIGBEE_short(RXFLUSH);
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,336 :: 		temp = temp | 0x01;                        // mask for flush RX FIFO
ORR	R0, R0, #1
;Misc_Routines.c,337 :: 		write_ZIGBEE_short(RXFLUSH, temp);
SXTB	R1, R0
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,338 :: 		}
L_end_flush_RX_FIFO_pointer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _flush_RX_FIFO_pointer
_set_short_address:
;Misc_Routines.c,343 :: 		void set_short_address(short int * address) {
; address start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; address end address is: 0 (R0)
; address start address is: 0 (R0)
;Misc_Routines.c,344 :: 		write_ZIGBEE_short(SADRL, address[0]);
LDRSB	R1, [R0, #0]
STR	R0, [SP, #4]
MOVS	R0, #3
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
LDR	R0, [SP, #4]
;Misc_Routines.c,345 :: 		write_ZIGBEE_short(SADRH, address[1]);
ADDS	R1, R0, #1
; address end address is: 0 (R0)
LDRSB	R1, [R1, #0]
MOVS	R0, #4
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,346 :: 		}
L_end_set_short_address:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_short_address
_set_long_address:
;Misc_Routines.c,348 :: 		void set_long_address(short int * address) {
; i start address is: 12 (R3)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Misc_Routines.c,351 :: 		for(i = 0; i < 8; i++) {
;Misc_Routines.c,348 :: 		void set_long_address(short int * address) {
;Misc_Routines.c,351 :: 		for(i = 0; i < 8; i++) {
;Misc_Routines.c,348 :: 		void set_long_address(short int * address) {
STR	R0, [SP, #8]
; i end address is: 12 (R3)
;Misc_Routines.c,349 :: 		short int i = 0;
;Misc_Routines.c,351 :: 		for(i = 0; i < 8; i++) {
; i start address is: 12 (R3)
MOVS	R3, #0
SXTB	R3, R3
; i end address is: 12 (R3)
SXTB	R0, R3
L_set_long_address41:
; i start address is: 0 (R0)
CMP	R0, #8
IT	GE
BGE	L_set_long_address42
;Misc_Routines.c,352 :: 		write_ZIGBEE_short(EADR0 + i, address[i]);   // 0x05 address of EADR0
LDR	R1, [SP, #8]
ADDS	R1, R1, R0
LDRSB	R1, [R1, #0]
SXTB	R2, R1
ADDS	R1, R0, #5
STRB	R0, [SP, #4]
SXTB	R0, R1
SXTB	R1, R2
BL	_write_ZIGBEE_short+0
LDRSB	R0, [SP, #4]
;Misc_Routines.c,351 :: 		for(i = 0; i < 8; i++) {
ADDS	R1, R0, #1
; i end address is: 0 (R0)
; i start address is: 12 (R3)
SXTB	R3, R1
;Misc_Routines.c,353 :: 		}
SXTB	R0, R3
; i end address is: 12 (R3)
IT	AL
BAL	L_set_long_address41
L_set_long_address42:
;Misc_Routines.c,354 :: 		}
L_end_set_long_address:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _set_long_address
_set_PAN_ID:
;Misc_Routines.c,356 :: 		void set_PAN_ID(short int * address) {
; address start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; address end address is: 0 (R0)
; address start address is: 0 (R0)
;Misc_Routines.c,357 :: 		write_ZIGBEE_short(PANIDL, address[0]);
LDRSB	R1, [R0, #0]
STR	R0, [SP, #4]
MOVS	R0, #1
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
LDR	R0, [SP, #4]
;Misc_Routines.c,358 :: 		write_ZIGBEE_short(PANIDH, address[1]);
ADDS	R1, R0, #1
; address end address is: 0 (R0)
LDRSB	R1, [R1, #0]
MOVS	R0, #2
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,359 :: 		}
L_end_set_PAN_ID:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_PAN_ID
_set_wake_from_pin:
;Misc_Routines.c,364 :: 		void set_wake_from_pin() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,365 :: 		short int temp = 0;
;Misc_Routines.c,367 :: 		WAKE_ = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(WAKE_+0)
MOVT	R0, #hi_addr(WAKE_+0)
STR	R1, [R0, #0]
;Misc_Routines.c,368 :: 		temp = read_ZIGBEE_short(RXFLUSH);
MOVS	R0, #13
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,369 :: 		temp = temp | 0x60;                     // mask
ORR	R0, R0, #96
;Misc_Routines.c,370 :: 		write_ZIGBEE_short(RXFLUSH, temp);
SXTB	R1, R0
MOVS	R0, #13
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,372 :: 		temp = read_ZIGBEE_short(WAKECON);
MOVS	R0, #34
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
;Misc_Routines.c,373 :: 		temp = temp | 0x80;
ORR	R0, R0, #128
;Misc_Routines.c,374 :: 		write_ZIGBEE_short(WAKECON, temp);
SXTB	R1, R0
MOVS	R0, #34
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,375 :: 		}
L_end_set_wake_from_pin:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_wake_from_pin
_pin_wake:
;Misc_Routines.c,377 :: 		void pin_wake() {
;Misc_Routines.c,378 :: 		WAKE_ = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(WAKE_+0)
MOVT	R0, #hi_addr(WAKE_+0)
STR	R1, [R0, #0]
;Misc_Routines.c,379 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_pin_wake44:
SUBS	R7, R7, #1
BNE	L_pin_wake44
NOP
NOP
NOP
;Misc_Routines.c,380 :: 		}
L_end_pin_wake:
BX	LR
; end of _pin_wake
_enable_PLL:
;Misc_Routines.c,385 :: 		void enable_PLL() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,386 :: 		write_ZIGBEE_long(RFCON2, 0x80);       // mask for PLL enable
MOVS	R1, #128
SXTB	R1, R1
MOVW	R0, #514
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,387 :: 		}
L_end_enable_PLL:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _enable_PLL
_disable_PLL:
;Misc_Routines.c,389 :: 		void disable_PLL() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,390 :: 		write_ZIGBEE_long(RFCON2, 0x00);       // mask for PLL disable
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #514
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,391 :: 		}
L_end_disable_PLL:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _disable_PLL
_set_TX_power:
;Misc_Routines.c,396 :: 		void set_TX_power(unsigned short int power) {             // 0-31 possible variants
; power start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; power end address is: 0 (R0)
; power start address is: 0 (R0)
;Misc_Routines.c,397 :: 		if((power < 0) || (power > 31))
CMP	R0, #0
IT	CC
BCC	L__set_TX_power60
CMP	R0, #31
IT	HI
BHI	L__set_TX_power59
; power end address is: 0 (R0)
IT	AL
BAL	L_set_TX_power48
L__set_TX_power60:
L__set_TX_power59:
;Misc_Routines.c,398 :: 		power = 31;
; power start address is: 0 (R0)
MOVS	R0, #31
; power end address is: 0 (R0)
L_set_TX_power48:
;Misc_Routines.c,399 :: 		power = 31 - power;                                     // 0 max, 31 min -> 31 max, 0 min
; power start address is: 0 (R0)
RSB	R1, R0, #31
; power end address is: 0 (R0)
;Misc_Routines.c,400 :: 		power = ((power & 0b00011111) << 3) & 0b11111000;       // calculating power
UXTB	R1, R1
AND	R1, R1, #31
UXTB	R1, R1
LSLS	R1, R1, #3
UXTH	R1, R1
AND	R1, R1, #248
;Misc_Routines.c,401 :: 		write_ZIGBEE_long(RFCON3, power);
SXTB	R1, R1
MOVW	R0, #515
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,402 :: 		}
L_end_set_TX_power:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_TX_power
_init_ZIGBEE_basic:
;Misc_Routines.c,407 :: 		void init_ZIGBEE_basic() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,408 :: 		write_ZIGBEE_short(PACON2, 0x98);   // Initialize FIFOEN = 1 and TXONTS = 0x6
MOVS	R1, #152
SXTB	R1, R1
MOVS	R0, #24
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,409 :: 		write_ZIGBEE_short(TXSTBL, 0x95);   // Initialize RFSTBL = 0x9
MOVS	R1, #149
SXTB	R1, R1
MOVS	R0, #46
SXTB	R0, R0
BL	_write_ZIGBEE_short+0
;Misc_Routines.c,410 :: 		write_ZIGBEE_long(RFCON1, 0x01);    // Initialize VCOOPT = 0x01
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #513
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,411 :: 		enable_PLL();                       // Enable PLL (PLLEN = 1)
BL	_enable_PLL+0
;Misc_Routines.c,412 :: 		write_ZIGBEE_long(RFCON6, 0x90);    // Initialize TXFIL = 1 and 20MRECVR = 1
MOVS	R1, #144
SXTB	R1, R1
MOVW	R0, #518
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,413 :: 		write_ZIGBEE_long(RFCON7, 0x80);    // Initialize SLPCLKSEL = 0x2 (100 kHz Internal oscillator)
MOVS	R1, #128
SXTB	R1, R1
MOVW	R0, #519
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,414 :: 		write_ZIGBEE_long(RFCON8, 0x10);    // Initialize RFVCO = 1
MOVS	R1, #16
SXTB	R1, R1
MOVW	R0, #520
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,415 :: 		write_ZIGBEE_long(SLPCON1, 0x21);   // Initialize CLKOUTEN = 1 and SLPCLKDIV = 0x01
MOVS	R1, #33
SXTB	R1, R1
MOVW	R0, #544
SXTH	R0, R0
BL	_write_ZIGBEE_long+0
;Misc_Routines.c,416 :: 		}
L_end_init_ZIGBEE_basic:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_ZIGBEE_basic
_init_ZIGBEE_nonbeacon:
;Misc_Routines.c,418 :: 		void init_ZIGBEE_nonbeacon() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Misc_Routines.c,419 :: 		init_ZIGBEE_basic();
BL	_init_ZIGBEE_basic+0
;Misc_Routines.c,420 :: 		set_CCA_mode(1);     // Set CCA mode to ED and set threshold
MOVS	R0, #1
SXTB	R0, R0
BL	_set_CCA_mode+0
;Misc_Routines.c,421 :: 		set_RSSI_mode(2);    // RSSI2 mode
MOVS	R0, #2
SXTB	R0, R0
BL	_set_RSSI_mode+0
;Misc_Routines.c,422 :: 		enable_interrupt();  // Enables all interrupts
BL	_enable_interrupt+0
;Misc_Routines.c,423 :: 		set_channel(11);     // Channel 11
MOVS	R0, #11
SXTB	R0, R0
BL	_set_channel+0
;Misc_Routines.c,424 :: 		RF_reset();
BL	_RF_reset+0
;Misc_Routines.c,425 :: 		}
L_end_init_ZIGBEE_nonbeacon:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_ZIGBEE_nonbeacon
_Debounce_INT:
;Misc_Routines.c,427 :: 		char Debounce_INT() {
;Misc_Routines.c,428 :: 		char i = 0, j = 0, intn_d = 0;
; j start address is: 8 (R2)
MOVS	R2, #0
;Misc_Routines.c,429 :: 		for(i = 0; i < 5; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; j end address is: 8 (R2)
; i end address is: 4 (R1)
L_Debounce_INT49:
; i start address is: 4 (R1)
; j start address is: 8 (R2)
CMP	R1, #5
IT	CS
BCS	L_Debounce_INT50
;Misc_Routines.c,430 :: 		intn_d = INT;
MOVW	R0, #lo_addr(INT+0)
MOVT	R0, #hi_addr(INT+0)
; intn_d start address is: 0 (R0)
LDR	R0, [R0, #0]
;Misc_Routines.c,431 :: 		if (intn_d == 1)
CMP	R0, #1
IT	NE
BNE	L__Debounce_INT61
; intn_d end address is: 0 (R0)
;Misc_Routines.c,432 :: 		j++;
ADDS	R2, R2, #1
UXTB	R2, R2
; j end address is: 8 (R2)
IT	AL
BAL	L_Debounce_INT52
L__Debounce_INT61:
;Misc_Routines.c,431 :: 		if (intn_d == 1)
;Misc_Routines.c,432 :: 		j++;
L_Debounce_INT52:
;Misc_Routines.c,429 :: 		for(i = 0; i < 5; i++) {
; j start address is: 8 (R2)
ADDS	R1, R1, #1
UXTB	R1, R1
;Misc_Routines.c,433 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_Debounce_INT49
L_Debounce_INT50:
;Misc_Routines.c,434 :: 		if (j > 2)
CMP	R2, #2
IT	LS
BLS	L_Debounce_INT53
; j end address is: 8 (R2)
;Misc_Routines.c,435 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_Debounce_INT
L_Debounce_INT53:
;Misc_Routines.c,437 :: 		return 0;
MOVS	R0, #0
;Misc_Routines.c,438 :: 		}
L_end_Debounce_INT:
BX	LR
; end of _Debounce_INT
