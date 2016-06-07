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
;Reciver.c,39 :: 		TFT_Write_Text("BOARD ID :", 140, 40);    // Display string on TFT
MOVW	R0, #lo_addr(?lstr1_Reciver+0)
MOVT	R0, #hi_addr(?lstr1_Reciver+0)
MOVS	R2, #40
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Reciver.c,40 :: 		TFT_Write_Text("Button 1 :", 140, 80);
MOVW	R0, #lo_addr(?lstr2_Reciver+0)
MOVT	R0, #hi_addr(?lstr2_Reciver+0)
MOVS	R2, #80
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Reciver.c,41 :: 		TFT_Write_Text("Button 2 :", 140, 120);
MOVW	R0, #lo_addr(?lstr3_Reciver+0)
MOVT	R0, #hi_addr(?lstr3_Reciver+0)
MOVS	R2, #120
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Reciver.c,42 :: 		TFT_Write_Text("ANALOG 1 :", 140, 160);
MOVW	R0, #lo_addr(?lstr4_Reciver+0)
MOVT	R0, #hi_addr(?lstr4_Reciver+0)
MOVS	R2, #160
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Reciver.c,43 :: 		}
L_end_draw_frame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_frame
_parse_adc_values:
;Reciver.c,45 :: 		void parse_adc_values() {
;Reciver.c,46 :: 		adc_result = adc_h * 265;
MOVW	R0, #lo_addr(_adc_h+0)
MOVT	R0, #hi_addr(_adc_h+0)
LDRB	R1, [R0, #0]
MOVW	R0, #265
SXTH	R0, R0
MUL	R2, R1, R0
SXTH	R2, R2
MOVW	R1, #lo_addr(_adc_result+0)
MOVT	R1, #hi_addr(_adc_result+0)
STRH	R2, [R1, #0]
;Reciver.c,47 :: 		adc_result = adc_result + adc_l;
MOVW	R0, #lo_addr(_adc_l+0)
MOVT	R0, #hi_addr(_adc_l+0)
LDRB	R0, [R0, #0]
ADDS	R0, R2, R0
STRH	R0, [R1, #0]
;Reciver.c,49 :: 		}
L_end_parse_adc_values:
BX	LR
; end of _parse_adc_values
_display_on_screen:
;Reciver.c,51 :: 		void display_on_screen() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,53 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Reciver.c,55 :: 		ByteToStr(deviceIdByte, &txt);
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,56 :: 		TFT_Write_Text(txt, 215, 40);
MOVS	R2, #40
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,58 :: 		ByteToStr(button1, &txt);      // Convert byte to string
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,59 :: 		TFT_Write_Text(txt, 215, 80);    // Display string on TFT
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,61 :: 		ByteToStr(button2, &txt);
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,62 :: 		TFT_Write_Text(txt, 215, 120);
MOVS	R2, #120
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,64 :: 		parse_adc_values();
BL	_parse_adc_values+0
;Reciver.c,65 :: 		IntToStr(adc_result, &txt);
MOVW	R0, #lo_addr(_adc_result+0)
MOVT	R0, #hi_addr(_adc_result+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_IntToStr+0
;Reciver.c,66 :: 		TFT_Write_Text(txt, 215, 160);
MOVS	R2, #160
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,67 :: 		}
L_end_display_on_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _display_on_screen
_clearScreen:
;Reciver.c,69 :: 		void clearScreen() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,71 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Reciver.c,73 :: 		ByteToStr(deviceIdByte, &txt);
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,74 :: 		TFT_Write_Text(txt, 215, 40);
MOVS	R2, #40
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,76 :: 		ByteToStr(button1, &txt);
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,77 :: 		TFT_Write_Text(txt, 215, 80);
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,79 :: 		ByteToStr(button2, &txt);
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,80 :: 		TFT_Write_Text(txt, 215, 120);
MOVS	R2, #120
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,82 :: 		ByteToStr(adc_result, &txt);
MOVW	R0, #lo_addr(_adc_result+0)
MOVT	R0, #hi_addr(_adc_result+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Reciver.c,83 :: 		TFT_Write_Text(txt, 215, 160);
MOVS	R2, #160
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Reciver.c,84 :: 		}
L_end_clearScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _clearScreen
_listen_for_id:
;Reciver.c,86 :: 		void listen_for_id() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,87 :: 		brodcast_id_request();
BL	_brodcast_id_request+0
;Reciver.c,88 :: 		delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_listen_for_id0:
SUBS	R7, R7, #1
BNE	L_listen_for_id0
NOP
NOP
NOP
;Reciver.c,90 :: 		if (Debounce_INT() == 0) {
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L_listen_for_id2
;Reciver.c,91 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Reciver.c,92 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Reciver.c,94 :: 		if (DATA_RX[0] == 0x70) { //0xff is controler to senzor message id, which is send only for senzort to get id
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #112
IT	NE
BNE	L_listen_for_id3
;Reciver.c,95 :: 		deviceIdByte = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
STRB	R1, [R0, #0]
;Reciver.c,96 :: 		}
L_listen_for_id3:
;Reciver.c,97 :: 		}
L_listen_for_id2:
;Reciver.c,98 :: 		}
L_end_listen_for_id:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _listen_for_id
_brodcast_id_request:
;Reciver.c,100 :: 		void brodcast_id_request() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,103 :: 		DATA_TX[0] = 0x40;
MOVS	R1, #64
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Reciver.c,104 :: 		DATA_TX[1] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
;Reciver.c,105 :: 		DATA_TX[2] = deviceIdByte;
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+2)
MOVT	R0, #hi_addr(_DATA_TX+2)
STRB	R1, [R0, #0]
;Reciver.c,107 :: 		if (life_notifyer_counter > 50) {
MOVW	R0, #lo_addr(_life_notifyer_counter+0)
MOVT	R0, #hi_addr(_life_notifyer_counter+0)
LDRSH	R0, [R0, #0]
CMP	R0, #50
IT	LE
BLE	L_brodcast_id_request4
;Reciver.c,108 :: 		life_notifyer_counter = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_life_notifyer_counter+0)
MOVT	R0, #hi_addr(_life_notifyer_counter+0)
STRH	R1, [R0, #0]
;Reciver.c,109 :: 		}
L_brodcast_id_request4:
;Reciver.c,112 :: 		write_TX_normal_FIFO();          // Transmiting
BL	_write_TX_normal_FIFO+0
;Reciver.c,113 :: 		}
L_end_brodcast_id_request:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _brodcast_id_request
_processRecivedData:
;Reciver.c,115 :: 		void processRecivedData() {
;Reciver.c,116 :: 		button1 = DATA_RX[0] & 0x20;
MOVW	R2, #lo_addr(_DATA_RX+0)
MOVT	R2, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R2, #0]
AND	R1, R0, #32
MOVW	R0, #lo_addr(_button1+0)
MOVT	R0, #hi_addr(_button1+0)
STRB	R1, [R0, #0]
;Reciver.c,117 :: 		button2 = DATA_RX[0] & 0x19;
MOV	R0, R2
LDRSB	R0, [R0, #0]
AND	R1, R0, #25
MOVW	R0, #lo_addr(_button2+0)
MOVT	R0, #hi_addr(_button2+0)
STRB	R1, [R0, #0]
;Reciver.c,118 :: 		adc_h = DATA_RX[0] % 0x0f;
MOV	R0, R2
LDRSB	R2, [R0, #0]
MOVS	R0, #15
SXTB	R0, R0
SDIV	R1, R2, R0
MLS	R1, R0, R1, R2
MOVW	R0, #lo_addr(_adc_h+0)
MOVT	R0, #hi_addr(_adc_h+0)
STRB	R1, [R0, #0]
;Reciver.c,119 :: 		adc_l = DATA_RX[1];
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_adc_l+0)
MOVT	R0, #hi_addr(_adc_l+0)
STRB	R1, [R0, #0]
;Reciver.c,120 :: 		}
L_end_processRecivedData:
BX	LR
; end of _processRecivedData
_beeReciveData:
;Reciver.c,122 :: 		void beeReciveData() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Reciver.c,123 :: 		if (Debounce_INT() == 0) {
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L_beeReciveData5
;Reciver.c,124 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Reciver.c,125 :: 		read_RX_FIFO();
BL	_read_RX_FIFO+0
;Reciver.c,126 :: 		if (DATA_RX[2] == deviceIdByte) {
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R0, [R0, #0]
CMP	R0, R1
IT	NE
BNE	L_beeReciveData6
;Reciver.c,127 :: 		clearScreen();
BL	_clearScreen+0
;Reciver.c,128 :: 		processRecivedData();
BL	_processRecivedData+0
;Reciver.c,129 :: 		display_on_screen();
BL	_display_on_screen+0
;Reciver.c,130 :: 		}
L_beeReciveData6:
;Reciver.c,131 :: 		DATA_RX[2] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
STRB	R1, [R0, #0]
;Reciver.c,132 :: 		}
L_beeReciveData5:
;Reciver.c,134 :: 		}
L_end_beeReciveData:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _beeReciveData
_main:
;Reciver.c,136 :: 		void main() {
;Reciver.c,137 :: 		Initialize();                      // Initialize MCU and Bee click board
BL	_Initialize+0
;Reciver.c,138 :: 		draw_frame();
BL	_draw_frame+0
;Reciver.c,140 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Reciver.c,141 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main7:
SUBS	R7, R7, #1
BNE	L_main7
NOP
NOP
NOP
;Reciver.c,143 :: 		while (deviceIdByte == 0) {
L_main9:
MOVW	R0, #lo_addr(_deviceIdByte+0)
MOVT	R0, #hi_addr(_deviceIdByte+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main10
;Reciver.c,144 :: 		listen_for_id();
BL	_listen_for_id+0
;Reciver.c,146 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
NOP
;Reciver.c,147 :: 		}
IT	AL
BAL	L_main9
L_main10:
;Reciver.c,148 :: 		while (1) {
L_main13:
;Reciver.c,149 :: 		beeReciveData();
BL	_beeReciveData+0
;Reciver.c,151 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main15:
SUBS	R7, R7, #1
BNE	L_main15
NOP
NOP
NOP
;Reciver.c,152 :: 		life_notifyer_counter++;
MOVW	R1, #lo_addr(_life_notifyer_counter+0)
MOVT	R1, #hi_addr(_life_notifyer_counter+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;Reciver.c,153 :: 		if (life_notifyer_counter == 50) {
CMP	R0, #50
IT	NE
BNE	L_main17
;Reciver.c,154 :: 		brodcast_id_request();
BL	_brodcast_id_request+0
;Reciver.c,155 :: 		}
L_main17:
;Reciver.c,156 :: 		}
IT	AL
BAL	L_main13
;Reciver.c,157 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
