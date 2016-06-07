_usbCommunication:
;Kominikator.c,33 :: 		void usbCommunication() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,34 :: 		USB_Polling_Proc();
BL	_USB_Polling_Proc+0
;Kominikator.c,35 :: 		DrawFrame();
BL	_DrawFrame+0
;Kominikator.c,36 :: 		if (HID_Read() != 0) {                                    //usb data recived
BL	_HID_Read+0
CMP	R0, #0
IT	EQ
BEQ	L_usbCommunication0
;Kominikator.c,37 :: 		if (readbuff[2] == 0) { //Read request from server - usb polling protocol
MOVW	R0, #lo_addr(_readbuff+2)
MOVT	R0, #hi_addr(_readbuff+2)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_usbCommunication1
;Kominikator.c,38 :: 		usbSend();
BL	_usbSend+0
;Kominikator.c,39 :: 		} else {                                      //Data recived form server
IT	AL
BAL	L_usbCommunication2
L_usbCommunication1:
;Kominikator.c,40 :: 		beeSend();
BL	_beeSend+0
;Kominikator.c,41 :: 		}
L_usbCommunication2:
;Kominikator.c,42 :: 		}
L_usbCommunication0:
;Kominikator.c,43 :: 		}
L_end_usbCommunication:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _usbCommunication
_usbSend:
;Kominikator.c,45 :: 		void usbSend() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Kominikator.c,46 :: 		writebuff[0] = BEE_RECIVED_DATA[0];
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;Kominikator.c,47 :: 		writebuff[1] = BEE_RECIVED_DATA[1];
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+1)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+1)
STR	R0, [SP, #8]
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+1)
MOVT	R0, #hi_addr(_writebuff+1)
STRB	R1, [R0, #0]
;Kominikator.c,48 :: 		writebuff[2] = BEE_RECIVED_DATA[2];
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+2)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+2)
STR	R0, [SP, #4]
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
STRB	R1, [R0, #0]
;Kominikator.c,49 :: 		DrawFrame();
BL	_DrawFrame+0
;Kominikator.c,50 :: 		HID_Write(&writebuff, 64);
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
;Kominikator.c,51 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_usbSend3:
SUBS	R7, R7, #1
BNE	L_usbSend3
NOP
NOP
NOP
;Kominikator.c,52 :: 		clearDataFromScreen();
BL	_clearDataFromScreen+0
;Kominikator.c,53 :: 		BEE_RECIVED_DATA[0] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+0)
STRB	R1, [R0, #0]
;Kominikator.c,54 :: 		BEE_RECIVED_DATA[1] = 0;
MOVS	R1, #0
SXTB	R1, R1
LDR	R0, [SP, #8]
STRB	R1, [R0, #0]
;Kominikator.c,55 :: 		BEE_RECIVED_DATA[2] = 0;
MOVS	R1, #0
SXTB	R1, R1
LDR	R0, [SP, #4]
STRB	R1, [R0, #0]
;Kominikator.c,56 :: 		}
L_end_usbSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _usbSend
_beeSend:
;Kominikator.c,58 :: 		void beeSend() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Kominikator.c,60 :: 		DATA_TX[0] = readbuff[0];
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Kominikator.c,61 :: 		DATA_TX[1] = readbuff[1];
MOVW	R0, #lo_addr(_readbuff+1)
MOVT	R0, #hi_addr(_readbuff+1)
STR	R0, [SP, #8]
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
;Kominikator.c,62 :: 		DATA_TX[2] = readbuff[2];
MOVW	R0, #lo_addr(_readbuff+2)
MOVT	R0, #hi_addr(_readbuff+2)
STR	R0, [SP, #4]
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+2)
MOVT	R0, #hi_addr(_DATA_TX+2)
STRB	R1, [R0, #0]
;Kominikator.c,64 :: 		write_TX_normal_FIFO();
BL	_write_TX_normal_FIFO+0
;Kominikator.c,66 :: 		readbuff[0] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
STRB	R1, [R0, #0]
;Kominikator.c,67 :: 		readbuff[1] = 0;
MOVS	R1, #0
LDR	R0, [SP, #8]
STRB	R1, [R0, #0]
;Kominikator.c,68 :: 		readbuff[2] = 0;
MOVS	R1, #0
LDR	R0, [SP, #4]
STRB	R1, [R0, #0]
;Kominikator.c,70 :: 		}
L_end_beeSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _beeSend
_beeRecive:
;Kominikator.c,72 :: 		void beeRecive() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,73 :: 		if (Debounce_INT() == 0) {             // Debounce line INT
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L_beeRecive5
;Kominikator.c,74 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Kominikator.c,75 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Kominikator.c,77 :: 		messageDestination = BEE_RECIVED_DATA[0];
MOVW	R2, #lo_addr(_BEE_RECIVED_DATA+0)
MOVT	R2, #hi_addr(_BEE_RECIVED_DATA+0)
LDRSB	R0, [R2, #0]
MOVW	R1, #lo_addr(_messageDestination+0)
MOVT	R1, #hi_addr(_messageDestination+0)
STRB	R0, [R1, #0]
;Kominikator.c,78 :: 		messageDestination &= 0xC0;
MOV	R0, R2
LDRB	R0, [R0, #0]
AND	R0, R0, #192
UXTB	R0, R0
STRB	R0, [R1, #0]
;Kominikator.c,79 :: 		if (messageDestination == 0 || messageDestination == 192) {
CMP	R0, #0
IT	EQ
BEQ	L__beeRecive18
MOVW	R0, #lo_addr(_messageDestination+0)
MOVT	R0, #hi_addr(_messageDestination+0)
LDRB	R0, [R0, #0]
CMP	R0, #192
IT	EQ
BEQ	L__beeRecive17
IT	AL
BAL	L_beeRecive8
L__beeRecive18:
L__beeRecive17:
;Kominikator.c,80 :: 		BEE_RECIVED_DATA[0] = DATA_RX[0];
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+0)
STRB	R1, [R0, #0]
;Kominikator.c,81 :: 		BEE_RECIVED_DATA[1] = DATA_RX[1];
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+1)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+1)
STRB	R1, [R0, #0]
;Kominikator.c,82 :: 		BEE_RECIVED_DATA[2] = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+2)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+2)
STRB	R1, [R0, #0]
;Kominikator.c,84 :: 		}
L_beeRecive8:
;Kominikator.c,85 :: 		}
L_beeRecive5:
;Kominikator.c,86 :: 		}
L_end_beeRecive:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _beeRecive
_DrawFrame:
;Kominikator.c,87 :: 		void DrawFrame() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,88 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Kominikator.c,89 :: 		ByteToStr(writebuff[0], &txt);         // Convert third byte to string
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,90 :: 		TFT_Write_Text(txt, 195, 80);       // Display string on TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,92 :: 		ByteToStr(writebuff[1], &txt);
MOVW	R0, #lo_addr(_writebuff+1)
MOVT	R0, #hi_addr(_writebuff+1)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,93 :: 		TFT_Write_Text(txt, 195, 90);
MOVS	R2, #90
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,95 :: 		ByteToStr(writebuff[2], &txt);
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,96 :: 		TFT_Write_Text(txt, 195, 100);
MOVS	R2, #100
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,98 :: 		ByteToStr(writebuff[2], &txt);
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,99 :: 		TFT_Write_Text('a', 195, 120);
MOVS	R2, #120
MOVS	R1, #195
MOVS	R0, #97
BL	_TFT_Write_Text+0
;Kominikator.c,101 :: 		}
L_end_DrawFrame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawFrame
_clearDataFromScreen:
;Kominikator.c,103 :: 		void clearDataFromScreen() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,104 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Kominikator.c,105 :: 		ByteToStr(writebuff[0], &txt);
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,106 :: 		TFT_Write_Text(txt, 195, 80);       // Delete string from TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,108 :: 		ByteToStr(writebuff[1], &txt);
MOVW	R0, #lo_addr(_writebuff+1)
MOVT	R0, #hi_addr(_writebuff+1)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,109 :: 		TFT_Write_Text(txt, 195, 90);
MOVS	R2, #90
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,111 :: 		ByteToStr(writebuff[2], &txt);
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,112 :: 		TFT_Write_Text(txt, 195, 100);
MOVS	R2, #100
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,114 :: 		ByteToStr(writebuff[2], &txt);
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,115 :: 		TFT_Write_Text('a', 195, 120);
MOVS	R2, #120
MOVS	R1, #195
MOVS	R0, #97
BL	_TFT_Write_Text+0
;Kominikator.c,116 :: 		}
L_end_clearDataFromScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _clearDataFromScreen
_main:
;Kominikator.c,118 :: 		void main() {
;Kominikator.c,120 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Kominikator.c,121 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Kominikator.c,123 :: 		BEE_RECIVED_DATA[0] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+0)
STRB	R1, [R0, #0]
;Kominikator.c,124 :: 		BEE_RECIVED_DATA[1] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+1)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+1)
STRB	R1, [R0, #0]
;Kominikator.c,125 :: 		BEE_RECIVED_DATA[2] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+2)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+2)
STRB	R1, [R0, #0]
;Kominikator.c,127 :: 		USB_RECIVED_DATA[0] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_USB_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_USB_RECIVED_DATA+0)
STRB	R1, [R0, #0]
;Kominikator.c,128 :: 		USB_RECIVED_DATA[1] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_USB_RECIVED_DATA+1)
MOVT	R0, #hi_addr(_USB_RECIVED_DATA+1)
STRB	R1, [R0, #0]
;Kominikator.c,129 :: 		USB_RECIVED_DATA[2] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_USB_RECIVED_DATA+2)
MOVT	R0, #hi_addr(_USB_RECIVED_DATA+2)
STRB	R1, [R0, #0]
;Kominikator.c,131 :: 		HID_Enable(&readbuff, &writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;Kominikator.c,139 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main9:
SUBS	R7, R7, #1
BNE	L_main9
NOP
NOP
NOP
;Kominikator.c,143 :: 		Initialize();
BL	_Initialize+0
;Kominikator.c,147 :: 		TFT_Write_Text("xxx", 195, 80);
MOVW	R0, #lo_addr(?lstr1_Kominikator+0)
MOVT	R0, #hi_addr(?lstr1_Kominikator+0)
MOVS	R2, #80
MOVS	R1, #195
BL	_TFT_Write_Text+0
;Kominikator.c,148 :: 		Delay_ms(2000);
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
NOP
;Kominikator.c,149 :: 		do {
L_main13:
;Kominikator.c,150 :: 		beeRecive();
BL	_beeRecive+0
;Kominikator.c,151 :: 		usbCommunication();
BL	_usbCommunication+0
;Kominikator.c,152 :: 		} while (1);
IT	AL
BAL	L_main13
;Kominikator.c,154 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
