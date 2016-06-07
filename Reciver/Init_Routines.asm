_Initialize:
;Init_Routines.c,12 :: 		void Initialize() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Init_Routines.c,13 :: 		short int i = 0;
;Init_Routines.c,15 :: 		LQI = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_LQI+0)
MOVT	R0, #hi_addr(_LQI+0)
STRB	R1, [R0, #0]
;Init_Routines.c,16 :: 		RSSI2 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_RSSI2+0)
MOVT	R0, #hi_addr(_RSSI2+0)
STRB	R1, [R0, #0]
;Init_Routines.c,17 :: 		SEQ_NUMBER = 0x23;
MOVS	R1, #35
SXTB	R1, R1
MOVW	R0, #lo_addr(_SEQ_NUMBER+0)
MOVT	R0, #hi_addr(_SEQ_NUMBER+0)
STRB	R1, [R0, #0]
;Init_Routines.c,18 :: 		lost_data = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_lost_data+0)
MOVT	R0, #hi_addr(_lost_data+0)
STRB	R1, [R0, #0]
;Init_Routines.c,19 :: 		address_RX_FIFO = 0x300;
MOVW	R1, #768
SXTH	R1, R1
MOVW	R0, #lo_addr(_address_RX_FIFO+0)
MOVT	R0, #hi_addr(_address_RX_FIFO+0)
STRH	R1, [R0, #0]
;Init_Routines.c,20 :: 		address_TX_normal_FIFO = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_address_TX_normal_FIFO+0)
MOVT	R0, #hi_addr(_address_TX_normal_FIFO+0)
STRH	R1, [R0, #0]
;Init_Routines.c,22 :: 		for (i = 0; i < 2; i++) {
; i start address is: 8 (R2)
MOVS	R2, #0
SXTB	R2, R2
; i end address is: 8 (R2)
L_Initialize0:
; i start address is: 8 (R2)
CMP	R2, #2
IT	GE
BGE	L_Initialize1
;Init_Routines.c,23 :: 		ADDRESS_short_1[i] = 1;
MOVW	R0, #lo_addr(_ADDRESS_short_1+0)
MOVT	R0, #hi_addr(_ADDRESS_short_1+0)
ADDS	R1, R0, R2
MOVS	R0, #1
SXTB	R0, R0
STRB	R0, [R1, #0]
;Init_Routines.c,24 :: 		ADDRESS_short_2[i] = 2;
MOVW	R0, #lo_addr(_ADDRESS_short_2+0)
MOVT	R0, #hi_addr(_ADDRESS_short_2+0)
ADDS	R1, R0, R2
MOVS	R0, #2
SXTB	R0, R0
STRB	R0, [R1, #0]
;Init_Routines.c,25 :: 		PAN_ID_1[i] = 3;
MOVW	R0, #lo_addr(_PAN_ID_1+0)
MOVT	R0, #hi_addr(_PAN_ID_1+0)
ADDS	R1, R0, R2
MOVS	R0, #3
SXTB	R0, R0
STRB	R0, [R1, #0]
;Init_Routines.c,26 :: 		PAN_ID_2[i] = 3;
MOVW	R0, #lo_addr(_PAN_ID_2+0)
MOVT	R0, #hi_addr(_PAN_ID_2+0)
ADDS	R1, R0, R2
MOVS	R0, #3
SXTB	R0, R0
STRB	R0, [R1, #0]
;Init_Routines.c,22 :: 		for (i = 0; i < 2; i++) {
ADDS	R2, R2, #1
SXTB	R2, R2
;Init_Routines.c,27 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_Initialize0
L_Initialize1:
;Init_Routines.c,29 :: 		for (i = 0; i < 8; i++) {
; i start address is: 8 (R2)
MOVS	R2, #0
SXTB	R2, R2
; i end address is: 8 (R2)
L_Initialize3:
; i start address is: 8 (R2)
CMP	R2, #8
IT	GE
BGE	L_Initialize4
;Init_Routines.c,30 :: 		ADDRESS_long_1[i] = 1;
MOVW	R0, #lo_addr(_ADDRESS_long_1+0)
MOVT	R0, #hi_addr(_ADDRESS_long_1+0)
ADDS	R1, R0, R2
MOVS	R0, #1
SXTB	R0, R0
STRB	R0, [R1, #0]
;Init_Routines.c,31 :: 		ADDRESS_long_2[i] = 2;
MOVW	R0, #lo_addr(_ADDRESS_long_2+0)
MOVT	R0, #hi_addr(_ADDRESS_long_2+0)
ADDS	R1, R0, R2
MOVS	R0, #2
SXTB	R0, R0
STRB	R0, [R1, #0]
;Init_Routines.c,29 :: 		for (i = 0; i < 8; i++) {
ADDS	R2, R2, #1
SXTB	R2, R2
;Init_Routines.c,32 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_Initialize3
L_Initialize4:
;Init_Routines.c,35 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_13);
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;Init_Routines.c,36 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_10);
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;Init_Routines.c,37 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_2);
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;Init_Routines.c,40 :: 		GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Input+0
;Init_Routines.c,42 :: 		DATA_TX[0] = 0;        // Initialize first byte
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Init_Routines.c,44 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_Initialize6:
SUBS	R7, R7, #1
BNE	L_Initialize6
NOP
NOP
NOP
;Init_Routines.c,50 :: 		&_GPIO_MODULE_SPI3_PC10_11_12);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
;Init_Routines.c,49 :: 		_SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1,
MOVW	R1, #772
;Init_Routines.c,47 :: 		SPI3_Init_Advanced(_SPI_FPCLK_DIV4, _SPI_MASTER  | _SPI_8_BIT |
MOVS	R0, #1
;Init_Routines.c,50 :: 		&_GPIO_MODULE_SPI3_PC10_11_12);
BL	_SPI3_Init_Advanced+0
;Init_Routines.c,51 :: 		TFT_BLED = 1;                             // Turn on TFT Backlight
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TFT_BLED+0)
MOVT	R0, #hi_addr(TFT_BLED+0)
STR	R1, [R0, #0]
;Init_Routines.c,53 :: 		TFT_Init(320, 240);                       // Initialize TFT display
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init+0
;Init_Routines.c,54 :: 		TFT_Fill_Screen(CL_WHITE);                // Clear Screen
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Init_Routines.c,56 :: 		pin_reset();                              // Activate reset from pin
BL	_pin_reset+0
;Init_Routines.c,57 :: 		software_reset();                         // Activate software reset
BL	_software_reset+0
;Init_Routines.c,58 :: 		RF_reset();                               // RF reset
BL	_RF_reset+0
;Init_Routines.c,59 :: 		set_WAKE_from_pin();                      // Set wake from pin
BL	_set_wake_from_pin+0
;Init_Routines.c,61 :: 		set_long_address(ADDRESS_long_1);         // Set long address
MOVW	R0, #lo_addr(_ADDRESS_long_1+0)
MOVT	R0, #hi_addr(_ADDRESS_long_1+0)
BL	_set_long_address+0
;Init_Routines.c,62 :: 		set_short_address(ADDRESS_short_1);       // Set short address
MOVW	R0, #lo_addr(_ADDRESS_short_1+0)
MOVT	R0, #hi_addr(_ADDRESS_short_1+0)
BL	_set_short_address+0
;Init_Routines.c,63 :: 		set_PAN_ID(PAN_ID_1);                     // Set PAN_ID
MOVW	R0, #lo_addr(_PAN_ID_1+0)
MOVT	R0, #hi_addr(_PAN_ID_1+0)
BL	_set_PAN_ID+0
;Init_Routines.c,65 :: 		init_ZIGBEE_nonbeacon();                  // Initialize ZigBee module
BL	_init_ZIGBEE_nonbeacon+0
;Init_Routines.c,66 :: 		nonbeacon_PAN_coordinator_device();
BL	_nonbeacon_PAN_coordinator_device+0
;Init_Routines.c,67 :: 		set_TX_power(31);                         // Set max TX power
MOVS	R0, #31
BL	_set_TX_power+0
;Init_Routines.c,68 :: 		set_frame_format_filter(1);               // 1 all frames, 3 data frame only
MOVS	R0, #1
SXTB	R0, R0
BL	_set_frame_format_filter+0
;Init_Routines.c,69 :: 		set_reception_mode(1);                    // 1 normal mode
MOVS	R0, #1
SXTB	R0, R0
BL	_set_reception_mode+0
;Init_Routines.c,71 :: 		pin_wake();                               // Wake from pin
BL	_pin_wake+0
;Init_Routines.c,72 :: 		}
L_end_Initialize:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Initialize
