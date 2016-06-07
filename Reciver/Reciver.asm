_draw_frame:
;Reciver.c,36 :: 		void draw_frame() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,37 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Reciver.c,38 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Reciver.c,39 :: 		TFT_Write_Text(">>> RECEIVER <<<", 80, 40);
MOVW	R0, #lo_addr(?lstr1_Reciver+0)
MOVT	R0, #hi_addr(?lstr1_Reciver+0)
MOVS	R2, #40
MOVS	R1, #80
BL	_TFT_Write_Text+0
;Reciver.c,40 :: 		TFT_Write_Text("BOARD ID :", 140, 80);
MOVW	R0, #lo_addr(?lstr2_Reciver+0)
MOVT	R0, #hi_addr(?lstr2_Reciver+0)
MOVS	R2, #80
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Reciver.c,41 :: 		TFT_Write_Text("Button 1 :", 140, 120);
MOVW	R0, #lo_addr(?lstr3_Reciver+0)
MOVT	R0, #hi_addr(?lstr3_Reciver+0)
MOVS	R2, #120
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Reciver.c,42 :: 		TFT_Write_Text("Button 2 :", 140, 160);
MOVW	R0, #lo_addr(?lstr4_Reciver+0)
MOVT	R0, #hi_addr(?lstr4_Reciver+0)
MOVS	R2, #160
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Reciver.c,43 :: 		TFT_Write_Text("ANALOG 1 :", 140, 200);
MOVW	R0, #lo_addr(?lstr5_Reciver+0)
MOVT	R0, #hi_addr(?lstr5_Reciver+0)
MOVS	R2, #200
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Reciver.c,46 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Reciver.c,48 :: 		TFT_Set_Brush(1, CL_WHITE, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
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
;Reciver.c,50 :: 		TFT_Set_Pen(CL_WHITE, 0);
MOVS	R1, #0
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;Reciver.c,51 :: 		}
L_end_draw_frame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_frame
_display_on_screen:
;Reciver.c,53 :: 		void display_on_screen() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,55 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Reciver.c,57 :: 		ByteToStr(deviceIdByte, &txt);
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,58 :: 		TFT_Write_Text(txt, 215, 80);
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,60 :: 		ByteToStr(button1, &txt);      // Convert byte to string
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,61 :: 		TFT_Write_Text(txt, 215, 120);    // Display string on TFT
MOVS	R2, #120
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,63 :: 		ByteToStr(button2, &txt);
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,64 :: 		TFT_Write_Text(txt, 215, 160);
MOVS	R2, #160
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,66 :: 		IntToStr(adc_result, &txt);
MOVW	R0, #lo_addr(_adc_result+0)
MOVT	R0, #hi_addr(_adc_result+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_IntToStr+0
;Reciver.c,67 :: 		TFT_Write_Text(txt, 215, 200);
MOVS	R2, #200
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,69 :: 		delay_ms(1000);
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
;Reciver.c,72 :: 		TFT_Rectangle(215, 80, 255, 220);
MOVS	R3, #220
SXTH	R3, R3
MOVS	R2, #255
SXTH	R2, R2
MOVS	R1, #80
SXTH	R1, R1
MOVS	R0, #215
SXTH	R0, R0
BL	_TFT_Rectangle+0
;Reciver.c,73 :: 		}
L_end_display_on_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _display_on_screen
_parse_adc_values:
;Reciver.c,75 :: 		void parse_adc_values() {
;Reciver.c,76 :: 		adc_h = DATA_RX[0] & 0b00001111;
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
AND	R2, R0, #15
SXTB	R2, R2
MOVW	R0, #lo_addr(_adc_h+0)
MOVT	R0, #hi_addr(_adc_h+0)
STRB	R2, [R0, #0]
;Reciver.c,77 :: 		adc_l = DATA_RX[1];
MOVW	R3, #lo_addr(_DATA_RX+1)
MOVT	R3, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R3, #0]
MOVW	R0, #lo_addr(_adc_l+0)
MOVT	R0, #hi_addr(_adc_l+0)
STRB	R1, [R0, #0]
;Reciver.c,78 :: 		adc_result = adc_h * 256;
UXTB	R0, R2
LSLS	R2, R0, #8
SXTH	R2, R2
MOVW	R1, #lo_addr(_adc_result+0)
MOVT	R1, #hi_addr(_adc_result+0)
STRH	R2, [R1, #0]
;Reciver.c,79 :: 		adc_result = adc_result + adc_l;
MOV	R0, R3
LDRB	R0, [R0, #0]
ADDS	R0, R2, R0
STRH	R0, [R1, #0]
;Reciver.c,80 :: 		}
L_end_parse_adc_values:
BX	LR
; end of _parse_adc_values
_listen_messages:
;Reciver.c,82 :: 		void listen_messages() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,83 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Reciver.c,84 :: 		read_RX_FIFO();
BL	_read_RX_FIFO+0
;Reciver.c,86 :: 		if (Debounce_INT() == 0 && (DATA_RX[0] & 0b11000000) == 128) {
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L__listen_messages24
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
AND	R0, R0, #192
SXTH	R0, R0
CMP	R0, #128
IT	NE
BNE	L__listen_messages23
L__listen_messages22:
;Reciver.c,88 :: 		if (DATA_RX[2] == deviceIdByte) {
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R0, [R0, #0]
CMP	R0, R1
IT	NE
BNE	L_listen_messages5
;Reciver.c,91 :: 		if ((DATA_RX[0] & 0x20) == 32){
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
AND	R0, R0, #32
SXTB	R0, R0
CMP	R0, #32
IT	NE
BNE	L_listen_messages6
;Reciver.c,92 :: 		button1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
STRB	R1, [R0, #0]
;Reciver.c,93 :: 		}
IT	AL
BAL	L_listen_messages7
L_listen_messages6:
;Reciver.c,95 :: 		else if ((DATA_RX[0] & 0x20) == 0){
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
AND	R0, R0, #32
SXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_listen_messages8
;Reciver.c,96 :: 		button1 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
STRB	R1, [R0, #0]
;Reciver.c,97 :: 		}
L_listen_messages8:
L_listen_messages7:
;Reciver.c,99 :: 		if ((DATA_RX[0] & 0x19) == 16){
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
AND	R0, R0, #25
SXTB	R0, R0
CMP	R0, #16
IT	NE
BNE	L_listen_messages9
;Reciver.c,100 :: 		button2 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
STRB	R1, [R0, #0]
;Reciver.c,101 :: 		}
IT	AL
BAL	L_listen_messages10
L_listen_messages9:
;Reciver.c,103 :: 		else if ((DATA_RX[0] & 0x20) == 0){
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
AND	R0, R0, #32
SXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_listen_messages11
;Reciver.c,104 :: 		button2 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
STRB	R1, [R0, #0]
;Reciver.c,105 :: 		}
L_listen_messages11:
L_listen_messages10:
;Reciver.c,107 :: 		parse_adc_values();
BL	_parse_adc_values+0
;Reciver.c,108 :: 		}
L_listen_messages5:
;Reciver.c,86 :: 		if (Debounce_INT() == 0 && (DATA_RX[0] & 0b11000000) == 128) {
L__listen_messages24:
L__listen_messages23:
;Reciver.c,111 :: 		display_on_screen();
BL	_display_on_screen+0
;Reciver.c,112 :: 		}
L_end_listen_messages:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _listen_messages
_brodcast_id_request:
;Reciver.c,114 :: 		void brodcast_id_request() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,116 :: 		DATA_TX[0] = 0xC0;
MOVS	R1, #192
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Reciver.c,117 :: 		DATA_TX[1] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
;Reciver.c,118 :: 		DATA_TX[2] = deviceIdByte;
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+2)
MOVT	R0, #hi_addr(_DATA_TX+2)
STRB	R1, [R0, #0]
;Reciver.c,121 :: 		write_TX_normal_FIFO();          // Transmiting
BL	_write_TX_normal_FIFO+0
;Reciver.c,122 :: 		}
L_end_brodcast_id_request:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _brodcast_id_request
_listen_for_id:
;Reciver.c,124 :: 		void listen_for_id() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,125 :: 		brodcast_id_request();
BL	_brodcast_id_request+0
;Reciver.c,126 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Reciver.c,127 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Reciver.c,129 :: 		if (Debounce_INT() == 0) {
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L_listen_for_id12
;Reciver.c,131 :: 		if (DATA_RX[0] == 112) {
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #112
IT	NE
BNE	L_listen_for_id13
;Reciver.c,132 :: 		deviceIdByte = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
STRB	R1, [R0, #0]
;Reciver.c,133 :: 		display_on_screen();
BL	_display_on_screen+0
;Reciver.c,134 :: 		}
L_listen_for_id13:
;Reciver.c,135 :: 		}
L_listen_for_id12:
;Reciver.c,136 :: 		}
L_end_listen_for_id:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _listen_for_id
_main:
;Reciver.c,138 :: 		void main() {
;Reciver.c,139 :: 		Initialize();                      // Initialize MCU and Bee click board
BL	_Initialize+0
;Reciver.c,140 :: 		draw_frame();
BL	_draw_frame+0
;Reciver.c,141 :: 		deviceIdByte = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
STRB	R1, [R0, #0]
;Reciver.c,142 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Reciver.c,143 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main14:
SUBS	R7, R7, #1
BNE	L_main14
NOP
NOP
NOP
;Reciver.c,145 :: 		while (1) {
L_main16:
;Reciver.c,146 :: 		if (deviceIdByte == 0){
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main18
;Reciver.c,148 :: 		listen_for_id();
BL	_listen_for_id+0
;Reciver.c,149 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_main19:
SUBS	R7, R7, #1
BNE	L_main19
NOP
NOP
NOP
;Reciver.c,150 :: 		}
L_main18:
;Reciver.c,152 :: 		listen_messages();
BL	_listen_messages+0
;Reciver.c,153 :: 		life_notifyer_counter++;
MOVW	R1, #lo_addr(_life_notifyer_counter+0)
MOVT	R1, #hi_addr(_life_notifyer_counter+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;Reciver.c,154 :: 		if (life_notifyer_counter > 2){
CMP	R0, #2
IT	LE
BLE	L_main21
;Reciver.c,155 :: 		life_notifyer_counter = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_life_notifyer_counter+0)
MOVT	R0, #hi_addr(_life_notifyer_counter+0)
STRH	R1, [R0, #0]
;Reciver.c,156 :: 		brodcast_id_request();
BL	_brodcast_id_request+0
;Reciver.c,157 :: 		}
L_main21:
;Reciver.c,158 :: 		}
IT	AL
BAL	L_main16
;Reciver.c,159 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
