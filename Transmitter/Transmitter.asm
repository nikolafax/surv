_draw_frame:
;Transmitter.c,35 :: 		void draw_frame(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,36 :: 		TFT_Init_ILI9341_8bit (320,240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Transmitter.c,37 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Transmitter.c,38 :: 		TFT_Write_Text("BOARD ID :", 140, 40);    // Display string on TFT
MOVW	R0, #lo_addr(?lstr1_Transmitter+0)
MOVT	R0, #hi_addr(?lstr1_Transmitter+0)
MOVS	R2, #40
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Transmitter.c,39 :: 		TFT_Write_Text("Button 1 :", 140, 80);
MOVW	R0, #lo_addr(?lstr2_Transmitter+0)
MOVT	R0, #hi_addr(?lstr2_Transmitter+0)
MOVS	R2, #80
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Transmitter.c,40 :: 		TFT_Write_Text("Button 2 :", 140, 120);
MOVW	R0, #lo_addr(?lstr3_Transmitter+0)
MOVT	R0, #hi_addr(?lstr3_Transmitter+0)
MOVS	R2, #120
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Transmitter.c,41 :: 		TFT_Write_Text("ANALOG 1 :", 140, 160);
MOVW	R0, #lo_addr(?lstr4_Transmitter+0)
MOVT	R0, #hi_addr(?lstr4_Transmitter+0)
MOVS	R2, #160
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Transmitter.c,43 :: 		DATA_RX[2] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
STRB	R1, [R0, #0]
;Transmitter.c,44 :: 		}
L_end_draw_frame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_frame
_parse_analog:
;Transmitter.c,46 :: 		void parse_analog()
SUB	SP, SP, #4
;Transmitter.c,48 :: 		adc_l = adc_result % 256;
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
;Transmitter.c,49 :: 		adc_h = (adc_result - adc_l) / 265;
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
;Transmitter.c,50 :: 		sendByteTwo = adc_l;
UXTB	R1, R3
MOVW	R0, #lo_addr(_sendByteTwo+0)
MOVT	R0, #hi_addr(_sendByteTwo+0)
STRB	R1, [R0, #0]
;Transmitter.c,51 :: 		sendByteOne |= adc_h;
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
;Transmitter.c,55 :: 		void display_on_screen(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,57 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Transmitter.c,59 :: 		ByteToStr(sendByteThree,&txt);
MOVW	R0, #lo_addr(_sendByteThree+0)
MOVT	R0, #hi_addr(_sendByteThree+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,60 :: 		TFT_Write_Text(txt, 215, 40);
MOVS	R2, #40
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,62 :: 		ByteToStr(state1,&txt);      // Convert byte to string
MOVW	R0, #lo_addr(_state1+0)
MOVT	R0, #hi_addr(_state1+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,63 :: 		TFT_Write_Text(txt, 215, 80);    // Display string on TFT
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,65 :: 		ByteToStr(state2,&txt);
MOVW	R0, #lo_addr(_state2+0)
MOVT	R0, #hi_addr(_state2+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,66 :: 		TFT_Write_Text(txt, 215, 120);
MOVS	R2, #120
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,68 :: 		IntToStr(adc_result_screen,&txt);
MOVW	R0, #lo_addr(_adc_result_screen+0)
MOVT	R0, #hi_addr(_adc_result_screen+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_IntToStr+0
;Transmitter.c,69 :: 		TFT_Write_Text(txt, 215, 160);
MOVS	R2, #160
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,71 :: 		delay_ms(1000);
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
;Transmitter.c,74 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Transmitter.c,76 :: 		ByteToStr(sendByteThree,&txt);
MOVW	R0, #lo_addr(_sendByteThree+0)
MOVT	R0, #hi_addr(_sendByteThree+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,77 :: 		TFT_Write_Text(txt, 215, 40);
MOVS	R2, #40
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,79 :: 		ByteToStr(state1,&txt);
MOVW	R0, #lo_addr(_state1+0)
MOVT	R0, #hi_addr(_state1+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,80 :: 		TFT_Write_Text(txt, 215, 80);
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,82 :: 		ByteToStr(state2,&txt);
MOVW	R0, #lo_addr(_state2+0)
MOVT	R0, #hi_addr(_state2+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,83 :: 		TFT_Write_Text(txt, 215, 120);
MOVS	R2, #120
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,85 :: 		ByteToStr(adc_result_screen,&txt);
MOVW	R0, #lo_addr(_adc_result_screen+0)
MOVT	R0, #hi_addr(_adc_result_screen+0)
LDRSH	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,86 :: 		TFT_Write_Text(adc_result_screen, 215, 160);
MOVW	R0, #lo_addr(_adc_result_screen+0)
MOVT	R0, #hi_addr(_adc_result_screen+0)
LDRSH	R0, [R0, #0]
MOVS	R2, #160
MOVS	R1, #215
BL	_TFT_Write_Text+0
;Transmitter.c,87 :: 		}
L_end_display_on_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _display_on_screen
_read_sensors:
;Transmitter.c,89 :: 		void read_sensors(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,90 :: 		if (Button(&GPIOD_IDR, 0, 1, 1)){                      // detect logical one on PA0 pin
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_read_sensors2
;Transmitter.c,91 :: 		if (state1 == 0){
MOVW	R0, #lo_addr(_state1+0)
MOVT	R0, #hi_addr(_state1+0)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_read_sensors3
;Transmitter.c,92 :: 		state1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_state1+0)
MOVT	R0, #hi_addr(_state1+0)
STRB	R1, [R0, #0]
;Transmitter.c,93 :: 		sendByteOne ^= 0b00100000;
MOVW	R1, #lo_addr(_sendByteOne+0)
MOVT	R1, #hi_addr(_sendByteOne+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #32
STRB	R0, [R1, #0]
;Transmitter.c,94 :: 		}
IT	AL
BAL	L_read_sensors4
L_read_sensors3:
;Transmitter.c,96 :: 		state1 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_state1+0)
MOVT	R0, #hi_addr(_state1+0)
STRB	R1, [R0, #0]
;Transmitter.c,97 :: 		sendByteOne ^= 0b00100000;
MOVW	R1, #lo_addr(_sendByteOne+0)
MOVT	R1, #hi_addr(_sendByteOne+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #32
STRB	R0, [R1, #0]
;Transmitter.c,98 :: 		}
L_read_sensors4:
;Transmitter.c,99 :: 		}
L_read_sensors2:
;Transmitter.c,100 :: 		if (Button(&GPIOD_IDR, 1, 1, 1)){                      // detect logical one on PA0 pin
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_read_sensors5
;Transmitter.c,101 :: 		if (state2 == 0){
MOVW	R0, #lo_addr(_state2+0)
MOVT	R0, #hi_addr(_state2+0)
LDRSB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_read_sensors6
;Transmitter.c,102 :: 		state2 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_state2+0)
MOVT	R0, #hi_addr(_state2+0)
STRB	R1, [R0, #0]
;Transmitter.c,103 :: 		sendByteOne ^= 0b00010000;
MOVW	R1, #lo_addr(_sendByteOne+0)
MOVT	R1, #hi_addr(_sendByteOne+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #16
STRB	R0, [R1, #0]
;Transmitter.c,104 :: 		}
IT	AL
BAL	L_read_sensors7
L_read_sensors6:
;Transmitter.c,106 :: 		state2 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_state2+0)
MOVT	R0, #hi_addr(_state2+0)
STRB	R1, [R0, #0]
;Transmitter.c,107 :: 		sendByteOne ^= 0b00010000;
MOVW	R1, #lo_addr(_sendByteOne+0)
MOVT	R1, #hi_addr(_sendByteOne+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #16
STRB	R0, [R1, #0]
;Transmitter.c,108 :: 		}
L_read_sensors7:
;Transmitter.c,109 :: 		}
L_read_sensors5:
;Transmitter.c,111 :: 		adc_result = ADC1_Get_Sample(3);                          // Get ADC value from corresponding channel
MOVS	R0, #3
BL	_ADC1_Get_Sample+0
MOVW	R1, #lo_addr(_adc_result+0)
MOVT	R1, #hi_addr(_adc_result+0)
STRH	R0, [R1, #0]
;Transmitter.c,112 :: 		parse_analog();
BL	_parse_analog+0
;Transmitter.c,113 :: 		Delay_ms(20);
MOVW	R7, #43391
MOVT	R7, #3
NOP
NOP
L_read_sensors8:
SUBS	R7, R7, #1
BNE	L_read_sensors8
NOP
NOP
NOP
;Transmitter.c,115 :: 		}
L_end_read_sensors:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _read_sensors
_listen_for_id:
;Transmitter.c,117 :: 		void listen_for_id(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,119 :: 		if (sendByteThree == 0 && Debounce_INT() == 0){
MOVW	R0, #lo_addr(_sendByteThree+0)
MOVT	R0, #hi_addr(_sendByteThree+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__listen_for_id20
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L__listen_for_id19
L__listen_for_id18:
;Transmitter.c,120 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Transmitter.c,121 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Transmitter.c,123 :: 		if(DATA_RX[0] == 127){
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #127
IT	NE
BNE	L_listen_for_id13
;Transmitter.c,124 :: 		sendByteThree = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_sendByteThree+0)
MOVT	R0, #hi_addr(_sendByteThree+0)
STRB	R1, [R0, #0]
;Transmitter.c,125 :: 		}
L_listen_for_id13:
;Transmitter.c,119 :: 		if (sendByteThree == 0 && Debounce_INT() == 0){
L__listen_for_id20:
L__listen_for_id19:
;Transmitter.c,127 :: 		}
L_end_listen_for_id:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _listen_for_id
_run_transmitter:
;Transmitter.c,129 :: 		void run_transmitter() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,130 :: 		read_sensors();
BL	_read_sensors+0
;Transmitter.c,133 :: 		DATA_TX[0] = sendByteOne;
MOVW	R0, #lo_addr(_sendByteOne+0)
MOVT	R0, #hi_addr(_sendByteOne+0)
LDRB	R0, [R0, #0]
MOVW	R3, #lo_addr(_DATA_TX+0)
MOVT	R3, #hi_addr(_DATA_TX+0)
STRB	R0, [R3, #0]
;Transmitter.c,134 :: 		DATA_TX[1] = sendByteTwo;
MOVW	R0, #lo_addr(_sendByteTwo+0)
MOVT	R0, #hi_addr(_sendByteTwo+0)
LDRB	R0, [R0, #0]
MOVW	R2, #lo_addr(_DATA_TX+1)
MOVT	R2, #hi_addr(_DATA_TX+1)
STRB	R0, [R2, #0]
;Transmitter.c,135 :: 		DATA_TX[2] = sendByteThree;
MOVW	R0, #lo_addr(_sendByteThree+0)
MOVT	R0, #hi_addr(_sendByteThree+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+2)
MOVT	R0, #hi_addr(_DATA_TX+2)
STRB	R1, [R0, #0]
;Transmitter.c,137 :: 		adc_result_screen = ((DATA_TX[0] & 0b00001111) * 256) + DATA_TX[1];
MOV	R0, R3
LDRSB	R0, [R0, #0]
AND	R0, R0, #15
SXTB	R0, R0
LSLS	R1, R0, #8
SXTH	R1, R1
MOV	R0, R2
LDRSB	R0, [R0, #0]
ADDS	R1, R1, R0
MOVW	R0, #lo_addr(_adc_result_screen+0)
MOVT	R0, #hi_addr(_adc_result_screen+0)
STRH	R1, [R0, #0]
;Transmitter.c,140 :: 		write_TX_normal_FIFO();          // Transmiting
BL	_write_TX_normal_FIFO+0
;Transmitter.c,143 :: 		display_on_screen();
BL	_display_on_screen+0
;Transmitter.c,144 :: 		}
L_end_run_transmitter:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _run_transmitter
_main:
;Transmitter.c,146 :: 		void main() {
SUB	SP, SP, #4
;Transmitter.c,147 :: 		Initialize();                      // Initialize MCU and Bee click board
BL	_Initialize+0
;Transmitter.c,148 :: 		draw_frame();
BL	_draw_frame+0
;Transmitter.c,150 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Transmitter.c,151 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_3);                     // Choose ADC channel
MOVW	R0, #8
BL	_ADC_Set_Input_Channel+0
;Transmitter.c,152 :: 		ADC1_Init();                                               // Init
BL	_ADC1_Init+0
;Transmitter.c,153 :: 		Delay_ms(100);
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
;Transmitter.c,154 :: 		while(1) {
L_main16:
;Transmitter.c,156 :: 		listen_for_id();
BL	_listen_for_id+0
;Transmitter.c,159 :: 		run_transmitter();
BL	_run_transmitter+0
;Transmitter.c,160 :: 		}
IT	AL
BAL	L_main16
;Transmitter.c,161 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
