_usbCommunication:
;Kominikator.c,31 :: 		void usbCommunication() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,32 :: 		USB_Polling_Proc();
BL	_USB_Polling_Proc+0
;Kominikator.c,34 :: 		if (HID_Read() != 0) {                                    //usb data recived
BL	_HID_Read+0
CMP	R0, #0
IT	EQ
BEQ	L_usbCommunication0
;Kominikator.c,35 :: 		if (readbuff[2] == 0) { //Read request from server - usb polling protocol
MOVW	R0, #lo_addr(_readbuff+2)
MOVT	R0, #hi_addr(_readbuff+2)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_usbCommunication1
;Kominikator.c,36 :: 		usbSend();
BL	_usbSend+0
;Kominikator.c,37 :: 		} else {                                      //Data recived form server
IT	AL
BAL	L_usbCommunication2
L_usbCommunication1:
;Kominikator.c,38 :: 		beeSend();
BL	_beeSend+0
;Kominikator.c,39 :: 		}
L_usbCommunication2:
;Kominikator.c,40 :: 		}
L_usbCommunication0:
;Kominikator.c,41 :: 		}
L_end_usbCommunication:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _usbCommunication
_usbSend:
;Kominikator.c,43 :: 		void usbSend() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Kominikator.c,44 :: 		writebuff[0] = BEE_RECIVED_DATA[0];
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;Kominikator.c,45 :: 		writebuff[1] = BEE_RECIVED_DATA[1];
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+1)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+1)
STR	R0, [SP, #8]
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+1)
MOVT	R0, #hi_addr(_writebuff+1)
STRB	R1, [R0, #0]
;Kominikator.c,46 :: 		writebuff[2] = BEE_RECIVED_DATA[2];
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+2)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+2)
STR	R0, [SP, #4]
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
STRB	R1, [R0, #0]
;Kominikator.c,48 :: 		HID_Write(&writebuff, 64);
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
;Kominikator.c,50 :: 		BEE_RECIVED_DATA[0] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+0)
STRB	R1, [R0, #0]
;Kominikator.c,51 :: 		BEE_RECIVED_DATA[1] = 0;
MOVS	R1, #0
SXTB	R1, R1
LDR	R0, [SP, #8]
STRB	R1, [R0, #0]
;Kominikator.c,52 :: 		BEE_RECIVED_DATA[2] = 0;
MOVS	R1, #0
SXTB	R1, R1
LDR	R0, [SP, #4]
STRB	R1, [R0, #0]
;Kominikator.c,53 :: 		}
L_end_usbSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _usbSend
_beeSend:
;Kominikator.c,55 :: 		void beeSend() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Kominikator.c,57 :: 		DATA_TX[0] = readbuff[0];
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Kominikator.c,58 :: 		DATA_TX[1] = readbuff[1];
MOVW	R0, #lo_addr(_readbuff+1)
MOVT	R0, #hi_addr(_readbuff+1)
STR	R0, [SP, #8]
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
;Kominikator.c,59 :: 		DATA_TX[2] = readbuff[2];
MOVW	R0, #lo_addr(_readbuff+2)
MOVT	R0, #hi_addr(_readbuff+2)
STR	R0, [SP, #4]
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+2)
MOVT	R0, #hi_addr(_DATA_TX+2)
STRB	R1, [R0, #0]
;Kominikator.c,61 :: 		write_TX_normal_FIFO();
BL	_write_TX_normal_FIFO+0
;Kominikator.c,63 :: 		readbuff[0] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
STRB	R1, [R0, #0]
;Kominikator.c,64 :: 		readbuff[1] = 0;
MOVS	R1, #0
LDR	R0, [SP, #8]
STRB	R1, [R0, #0]
;Kominikator.c,65 :: 		readbuff[2] = 0;
MOVS	R1, #0
LDR	R0, [SP, #4]
STRB	R1, [R0, #0]
;Kominikator.c,67 :: 		}
L_end_beeSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _beeSend
_beeRecive:
;Kominikator.c,69 :: 		void beeRecive() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,70 :: 		if (Debounce_INT() == 0) {             // Debounce line INT
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L_beeRecive3
;Kominikator.c,71 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Kominikator.c,72 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Kominikator.c,73 :: 		BEE_RECIVED_DATA[0] = DATA_RX[0];
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+0)
STRB	R1, [R0, #0]
;Kominikator.c,74 :: 		BEE_RECIVED_DATA[1] = DATA_RX[1];
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+1)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+1)
STRB	R1, [R0, #0]
;Kominikator.c,75 :: 		BEE_RECIVED_DATA[2] = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+2)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+2)
STRB	R1, [R0, #0]
;Kominikator.c,76 :: 		DrawFrame();
BL	_DrawFrame+0
;Kominikator.c,77 :: 		}
L_beeRecive3:
;Kominikator.c,78 :: 		}
L_end_beeRecive:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _beeRecive
_DrawFrame:
;Kominikator.c,79 :: 		void DrawFrame() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,80 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Kominikator.c,81 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Kominikator.c,83 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Kominikator.c,84 :: 		ByteToStr(DATA_RX[0], &txt);         // Convert third byte to string
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,86 :: 		TFT_Write_Text(txt, 195, 80);       // Display string on TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,88 :: 		ByteToStr(DATA_RX[1], &txt);
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,89 :: 		TFT_Write_Text(txt, 195, 90);
MOVS	R2, #90
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,91 :: 		ByteToStr(DATA_RX[2], &txt);
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,92 :: 		TFT_Write_Text(txt, 195, 100);
MOVS	R2, #100
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,94 :: 		}
L_end_DrawFrame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawFrame
_clearDataFromScreen:
;Kominikator.c,96 :: 		void clearDataFromScreen() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,97 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Kominikator.c,98 :: 		ByteToStr(DATA_RX[0], &txt);
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,99 :: 		TFT_Write_Text(txt, 195, 80);       // Delete string from TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,101 :: 		ByteToStr(DATA_RX[1], &txt);
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,102 :: 		TFT_Write_Text(txt, 195, 90);
MOVS	R2, #90
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,104 :: 		ByteToStr(DATA_RX[2], &txt);
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,105 :: 		TFT_Write_Text(txt, 195, 100);
MOVS	R2, #100
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,106 :: 		}
L_end_clearDataFromScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _clearDataFromScreen
_main:
;Kominikator.c,108 :: 		void main() {
;Kominikator.c,110 :: 		BEE_RECIVED_DATA[0] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+0)
STRB	R1, [R0, #0]
;Kominikator.c,111 :: 		BEE_RECIVED_DATA[1] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+1)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+1)
STRB	R1, [R0, #0]
;Kominikator.c,112 :: 		BEE_RECIVED_DATA[2] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_BEE_RECIVED_DATA+2)
MOVT	R0, #hi_addr(_BEE_RECIVED_DATA+2)
STRB	R1, [R0, #0]
;Kominikator.c,114 :: 		USB_RECIVED_DATA[0] = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_USB_RECIVED_DATA+0)
MOVT	R0, #hi_addr(_USB_RECIVED_DATA+0)
STRB	R1, [R0, #0]
;Kominikator.c,115 :: 		USB_RECIVED_DATA[1] = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_USB_RECIVED_DATA+1)
MOVT	R0, #hi_addr(_USB_RECIVED_DATA+1)
STRB	R1, [R0, #0]
;Kominikator.c,116 :: 		USB_RECIVED_DATA[2] = 2;
MOVS	R1, #2
SXTB	R1, R1
MOVW	R0, #lo_addr(_USB_RECIVED_DATA+2)
MOVT	R0, #hi_addr(_USB_RECIVED_DATA+2)
STRB	R1, [R0, #0]
;Kominikator.c,118 :: 		HID_Enable(&readbuff, &writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;Kominikator.c,120 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0); // Set PA0 as digital input
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Kominikator.c,121 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_1); // Set PA0 as digital input
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Kominikator.c,123 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;Kominikator.c,124 :: 		GPIOC_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;Kominikator.c,126 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
;Kominikator.c,128 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_LOW);
MOVW	R1, #255
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;Kominikator.c,130 :: 		Initialize();
BL	_Initialize+0
;Kominikator.c,131 :: 		DrawFrame();
BL	_DrawFrame+0
;Kominikator.c,133 :: 		do {
L_main6:
;Kominikator.c,134 :: 		beeRecive();
BL	_beeRecive+0
;Kominikator.c,135 :: 		usbCommunication();
BL	_usbCommunication+0
;Kominikator.c,136 :: 		} while (1);
IT	AL
BAL	L_main6
;Kominikator.c,138 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
