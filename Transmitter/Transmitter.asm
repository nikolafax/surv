_draw_frame:
;Transmitter.c,33 :: 		void draw_frame() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,34 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Transmitter.c,35 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Transmitter.c,36 :: 		TFT_Write_Text("BOARD ID :", 140, 40);    // Display string on TFT
MOVW	R0, #lo_addr(?lstr1_Transmitter+0)
MOVT	R0, #hi_addr(?lstr1_Transmitter+0)
MOVS	R2, #40
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Transmitter.c,37 :: 		TFT_Write_Text("Button 1 :", 140, 80);
MOVW	R0, #lo_addr(?lstr2_Transmitter+0)
MOVT	R0, #hi_addr(?lstr2_Transmitter+0)
MOVS	R2, #80
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Transmitter.c,38 :: 		TFT_Write_Text("Button 2 :", 140, 120);
MOVW	R0, #lo_addr(?lstr3_Transmitter+0)
MOVT	R0, #hi_addr(?lstr3_Transmitter+0)
MOVS	R2, #120
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Transmitter.c,39 :: 		TFT_Write_Text("ANALOG 1 :", 140, 160);
MOVW	R0, #lo_addr(?lstr4_Transmitter+0)
MOVT	R0, #hi_addr(?lstr4_Transmitter+0)
MOVS	R2, #160
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Transmitter.c,41 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Transmitter.c,43 :: 		TFT_Set_Brush(1, CL_WHITE, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
MOVW	R1, #4095
MOVW	R0, #4095
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #0
MOVW	R1, #65535
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;Transmitter.c,45 :: 		TFT_Set_Pen(CL_WHITE, 0);
MOVS	R1, #0
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;Transmitter.c,46 :: 		}
L_end_draw_frame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_frame
_parse_analog:
;Transmitter.c,48 :: 		void parse_analog() {
SUB	SP, SP, #4
;Transmitter.c,49 :: 		adc_l = adc_result % 256;
MOVW	R2, #lo_addr(_adc_result+0)
MOVT	R2, #hi_addr(_adc_result+0)
LDRSH	R1, [R2, #0]
MOVW	R0, #256
SXTH	R0, R0
SDIV	R3, R1, R0
MLS	R3, R0, R3, R1
MOVW	R0, #lo_addr(_adc_l+0)
MOVT	R0, #hi_addr(_adc_l+0)
STRB	R3, [R0, #0]
;Transmitter.c,50 :: 		adc_h = (adc_result - adc_l) / 265;
UXTB	R1, R3
MOV	R0, R2
LDRSH	R0, [R0, #0]
SUB	R1, R0, R1
SXTH	R1, R1
MOVW	R0, #265
SXTH	R0, R0
SDIV	R2, R1, R0
MOVW	R0, #lo_addr(_adc_h+0)
MOVT	R0, #hi_addr(_adc_h+0)
STRB	R2, [R0, #0]
;Transmitter.c,51 :: 		sendByteTwo = adc_l;
UXTB	R1, R3
MOVW	R0, #lo_addr(_sendByteTwo+0)
MOVT	R0, #hi_addr(_sendByteTwo+0)
STRB	R1, [R0, #0]
;Transmitter.c,52 :: 		sendByteOne |= adc_h;
UXTB	R2, R2
MOVW	R1, #lo_addr(_sendByteOne+0)
MOVT	R1, #hi_addr(_sendByteOne+0)
LDRB	R0, [R1, #0]
ORRS	R0, R2
STRB	R0, [R1, #0]
;Transmitter.c,53 :: 		}
L_end_parse_analog:
ADD	SP, SP, #4
BX	LR
; end of _parse_analog
_display_on_screen:
;Transmitter.c,55 :: 		void display_on_screen() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,56 :: 		ByteToStr(sendByteThree, &txt);  //Board ID
MOVW	R0, #lo_addr(_sendByteThree+0)
MOVT	R0, #hi_addr(_sendByteThree+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,57 :: 		TFT_Write_Text(txt, 215, 40);
MOVS	R2, #40
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,59 :: 		ByteToStr(button1, &txt);      // Convert byte to string
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,60 :: 		TFT_Write_Text(txt, 215, 80);    // Display string on TFT
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,62 :: 		ByteToStr(button2, &txt);
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,63 :: 		TFT_Write_Text(txt, 215, 120);
MOVS	R2, #120
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,65 :: 		IntToStr(adc_result, &txt);
MOVW	R0, #lo_addr(_adc_result+0)
MOVT	R0, #hi_addr(_adc_result+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_IntToStr+0
;Transmitter.c,66 :: 		TFT_Write_Text(txt, 215, 160);
MOVS	R2, #160
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,68 :: 		delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_display_on_screen0:
SUBS	R7, R7, #1
BNE	L_display_on_screen0
NOP
NOP
NOP
;Transmitter.c,71 :: 		TFT_Rectangle(215, 40, 255, 180);
MOVS	R3, #180
SXTH	R3, R3
MOVS	R2, #255
SXTH	R2, R2
MOVS	R1, #40
SXTH	R1, R1
MOVS	R0, #215
SXTH	R0, R0
BL	_TFT_Rectangle+0
;Transmitter.c,72 :: 		}
L_end_display_on_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _display_on_screen
_read_sensors:
;Transmitter.c,74 :: 		void read_sensors() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,76 :: 		if (Button(&GPIOD_IDR, 0, 1, 1) && button1 == 0) {          // detect logical one on PA0 pin
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__read_sensors30
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__read_sensors29
L__read_sensors28:
;Transmitter.c,77 :: 		button1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
STRB	R1, [R0, #0]
;Transmitter.c,78 :: 		sendByteOne |= 0b00100000;
MOVW	R1, #lo_addr(_sendByteOne+0)
MOVT	R1, #hi_addr(_sendByteOne+0)
LDRB	R0, [R1, #0]
ORR	R0, R0, #32
STRB	R0, [R1, #0]
;Transmitter.c,79 :: 		}
IT	AL
BAL	L_read_sensors5
;Transmitter.c,76 :: 		if (Button(&GPIOD_IDR, 0, 1, 1) && button1 == 0) {          // detect logical one on PA0 pin
L__read_sensors30:
L__read_sensors29:
;Transmitter.c,81 :: 		else if (!Button(&GPIOD_IDR, 0, 1, 1) && button1 == 1){
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	NE
BNE	L__read_sensors32
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
LDRSB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__read_sensors31
L__read_sensors27:
;Transmitter.c,82 :: 		button1 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
STRB	R1, [R0, #0]
;Transmitter.c,83 :: 		sendByteOne &= 0b11011111;
MOVW	R1, #lo_addr(_sendByteOne+0)
MOVT	R1, #hi_addr(_sendByteOne+0)
LDRB	R0, [R1, #0]
AND	R0, R0, #223
STRB	R0, [R1, #0]
;Transmitter.c,81 :: 		else if (!Button(&GPIOD_IDR, 0, 1, 1) && button1 == 1){
L__read_sensors32:
L__read_sensors31:
;Transmitter.c,84 :: 		}
L_read_sensors5:
;Transmitter.c,86 :: 		if (Button(&GPIOD_IDR, 1, 1, 1) && button2 == 0) {          // detect logical one on PA0 pin
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__read_sensors34
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__read_sensors33
L__read_sensors26:
;Transmitter.c,87 :: 		button2 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
STRB	R1, [R0, #0]
;Transmitter.c,88 :: 		sendByteOne |= 0b00010000;
MOVW	R1, #lo_addr(_sendByteOne+0)
MOVT	R1, #hi_addr(_sendByteOne+0)
LDRB	R0, [R1, #0]
ORR	R0, R0, #16
STRB	R0, [R1, #0]
;Transmitter.c,89 :: 		}
IT	AL
BAL	L_read_sensors12
;Transmitter.c,86 :: 		if (Button(&GPIOD_IDR, 1, 1, 1) && button2 == 0) {          // detect logical one on PA0 pin
L__read_sensors34:
L__read_sensors33:
;Transmitter.c,91 :: 		else if (!Button(&GPIOD_IDR, 1, 1, 1) && button2 == 1){
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	NE
BNE	L__read_sensors36
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
LDRSB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__read_sensors35
L__read_sensors25:
;Transmitter.c,92 :: 		button2 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
STRB	R1, [R0, #0]
;Transmitter.c,93 :: 		sendByteOne &= 0b11101111;
MOVW	R1, #lo_addr(_sendByteOne+0)
MOVT	R1, #hi_addr(_sendByteOne+0)
LDRB	R0, [R1, #0]
AND	R0, R0, #239
STRB	R0, [R1, #0]
;Transmitter.c,91 :: 		else if (!Button(&GPIOD_IDR, 1, 1, 1) && button2 == 1){
L__read_sensors36:
L__read_sensors35:
;Transmitter.c,94 :: 		}
L_read_sensors12:
;Transmitter.c,96 :: 		adc_result = ADC1_Get_Sample(3); // Get ADC value from corresponding channel
MOVS	R0, #3
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_adc_result+0)
MOVT	R1, #hi_addr(_adc_result+0)
STRH	R0, [R1, #0]
;Transmitter.c,97 :: 		parse_analog();
BL	_parse_analog+0
;Transmitter.c,99 :: 		}
L_end_read_sensors:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _read_sensors
_reset_values:
;Transmitter.c,101 :: 		void reset_values() {
SUB	SP, SP, #4
;Transmitter.c,102 :: 		sendByteOne = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_sendByteOne+0)
MOVT	R0, #hi_addr(_sendByteOne+0)
STRB	R1, [R0, #0]
;Transmitter.c,103 :: 		sendByteTwo = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_sendByteTwo+0)
MOVT	R0, #hi_addr(_sendByteTwo+0)
STRB	R1, [R0, #0]
;Transmitter.c,104 :: 		}
L_end_reset_values:
ADD	SP, SP, #4
BX	LR
; end of _reset_values
_run_transmitter:
;Transmitter.c,106 :: 		void run_transmitter() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,107 :: 		read_sensors();
BL	_read_sensors+0
;Transmitter.c,109 :: 		DATA_TX[0] = sendByteOne;
MOVW	R0, #lo_addr(_sendByteOne+0)
MOVT	R0, #hi_addr(_sendByteOne+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Transmitter.c,110 :: 		DATA_TX[1] = sendByteTwo;
MOVW	R0, #lo_addr(_sendByteTwo+0)
MOVT	R0, #hi_addr(_sendByteTwo+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
;Transmitter.c,111 :: 		DATA_TX[2] = sendByteThree;
MOVW	R0, #lo_addr(_sendByteThree+0)
MOVT	R0, #hi_addr(_sendByteThree+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+2)
MOVT	R0, #hi_addr(_DATA_TX+2)
STRB	R1, [R0, #0]
;Transmitter.c,114 :: 		write_TX_normal_FIFO();          // Transmiting
BL	_write_TX_normal_FIFO+0
;Transmitter.c,117 :: 		display_on_screen();
BL	_display_on_screen+0
;Transmitter.c,118 :: 		reset_values();
BL	_reset_values+0
;Transmitter.c,119 :: 		}
L_end_run_transmitter:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _run_transmitter
_listen_for_id:
;Transmitter.c,121 :: 		void listen_for_id() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,123 :: 		if (Debounce_INT() == 0 && DATA_RX[0] == 64 && sendByteThree == 0) {
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L__listen_for_id40
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #64
IT	NE
BNE	L__listen_for_id39
MOVW	R0, #lo_addr(_sendByteThree+0)
MOVT	R0, #hi_addr(_sendByteThree+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__listen_for_id38
L__listen_for_id37:
;Transmitter.c,124 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Transmitter.c,125 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Transmitter.c,126 :: 		sendByteThree = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_sendByteThree+0)
MOVT	R0, #hi_addr(_sendByteThree+0)
STRB	R1, [R0, #0]
;Transmitter.c,123 :: 		if (Debounce_INT() == 0 && DATA_RX[0] == 64 && sendByteThree == 0) {
L__listen_for_id40:
L__listen_for_id39:
L__listen_for_id38:
;Transmitter.c,128 :: 		}
L_end_listen_for_id:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _listen_for_id
_main:
;Transmitter.c,130 :: 		void main() {
SUB	SP, SP, #4
;Transmitter.c,131 :: 		Initialize();                      // Initialize MCU and Bee click board
BL	_Initialize+0
;Transmitter.c,132 :: 		draw_frame();
BL	_draw_frame+0
;Transmitter.c,134 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Transmitter.c,135 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_3);                 // Choose ADC channel
MOVW	R0, #8
BL	_ADC_Set_Input_Channel+0
;Transmitter.c,136 :: 		ADC1_Init();                                               // Init
BL	_ADC1_Init+0
;Transmitter.c,137 :: 		DATA_RX[2] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
STRB	R1, [R0, #0]
;Transmitter.c,138 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main19:
SUBS	R7, R7, #1
BNE	L_main19
NOP
NOP
NOP
;Transmitter.c,139 :: 		reset_values();
BL	_reset_values+0
;Transmitter.c,140 :: 		while (1) {
L_main21:
;Transmitter.c,142 :: 		listen_for_id();
BL	_listen_for_id+0
;Transmitter.c,144 :: 		run_transmitter();
BL	_run_transmitter+0
;Transmitter.c,146 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main23:
SUBS	R7, R7, #1
BNE	L_main23
NOP
NOP
NOP
;Transmitter.c,147 :: 		}
IT	AL
BAL	L_main21
;Transmitter.c,148 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
