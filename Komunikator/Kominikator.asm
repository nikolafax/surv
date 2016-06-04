_usbSend:
;Kominikator.c,26 :: 		void usbSend() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,28 :: 		for (cnt = 0; cnt < 64; cnt++) {
MOVS	R1, #0
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
STRB	R1, [R0, #0]
L_usbSend0:
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRB	R0, [R0, #0]
CMP	R0, #64
IT	CS
BCS	L_usbSend1
;Kominikator.c,29 :: 		writebuff[cnt] = 0;
MOVW	R2, #lo_addr(_cnt+0)
MOVT	R2, #hi_addr(_cnt+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;Kominikator.c,28 :: 		for (cnt = 0; cnt < 64; cnt++) {
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
;Kominikator.c,30 :: 		}
IT	AL
BAL	L_usbSend0
L_usbSend1:
;Kominikator.c,31 :: 		writebuff[0] = DATA_RX[0];
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;Kominikator.c,32 :: 		writebuff[1] = DATA_RX[1];
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+1)
MOVT	R0, #hi_addr(_writebuff+1)
STRB	R1, [R0, #0]
;Kominikator.c,33 :: 		writebuff[2] = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
STRB	R1, [R0, #0]
;Kominikator.c,35 :: 		HID_Write(&writebuff, 64);
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
;Kominikator.c,37 :: 		}
L_end_usbSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _usbSend
_usbRecive:
;Kominikator.c,39 :: 		void usbRecive() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,40 :: 		USB_Polling_Proc();
BL	_USB_Polling_Proc+0
;Kominikator.c,42 :: 		kk = HID_Read();
BL	_HID_Read+0
MOVW	R1, #lo_addr(_kk+0)
MOVT	R1, #hi_addr(_kk+0)
STRB	R0, [R1, #0]
;Kominikator.c,43 :: 		if(kk != 0){
CMP	R0, #0
IT	EQ
BEQ	L_usbRecive3
;Kominikator.c,44 :: 		beeSend();
BL	_beeSend+0
;Kominikator.c,45 :: 		writebuff[0] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;Kominikator.c,46 :: 		HID_Write(&writebuff,64);
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
;Kominikator.c,47 :: 		}
L_usbRecive3:
;Kominikator.c,48 :: 		}
L_end_usbRecive:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _usbRecive
_beeSend:
;Kominikator.c,50 :: 		void beeSend() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,51 :: 		DATA_TX[0] = writebuff[0];
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Kominikator.c,52 :: 		DATA_TX[1] = writebuff[1];
MOVW	R0, #lo_addr(_writebuff+1)
MOVT	R0, #hi_addr(_writebuff+1)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
;Kominikator.c,53 :: 		DATA_TX[2] = writebuff[2];
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+2)
MOVT	R0, #hi_addr(_DATA_TX+2)
STRB	R1, [R0, #0]
;Kominikator.c,54 :: 		write_TX_normal_FIFO();
BL	_write_TX_normal_FIFO+0
;Kominikator.c,55 :: 		}
L_end_beeSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _beeSend
_beeRecive:
;Kominikator.c,57 :: 		void beeRecive() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,58 :: 		if (Debounce_INT() == 0) {             // Debounce line INT
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L_beeRecive4
;Kominikator.c,59 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Kominikator.c,60 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Kominikator.c,62 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Kominikator.c,63 :: 		ByteToStr(DATA_RX[0], &txt);         // Convert third byte to string
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,64 :: 		TFT_Write_Text(txt, 195, 80);       // Display string on TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,66 :: 		ByteToStr(DATA_RX[1], &txt);
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,67 :: 		TFT_Write_Text(txt, 195, 90);
MOVS	R2, #90
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,69 :: 		ByteToStr(DATA_RX[2], &txt);
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,70 :: 		TFT_Write_Text(txt, 195, 100);
MOVS	R2, #100
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,72 :: 		delay_ms(500);
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_beeRecive5:
SUBS	R7, R7, #1
BNE	L_beeRecive5
NOP
NOP
NOP
;Kominikator.c,73 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Kominikator.c,74 :: 		ByteToStr(DATA_RX[0], &txt);
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,75 :: 		TFT_Write_Text(txt, 195, 80);       // Delete string from TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,77 :: 		ByteToStr(DATA_RX[1], &txt);
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,78 :: 		TFT_Write_Text(txt, 195, 90);
MOVS	R2, #90
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,80 :: 		ByteToStr(DATA_RX[2], &txt);
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,81 :: 		TFT_Write_Text(txt, 195, 100);
MOVS	R2, #100
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,83 :: 		GPIOD_ODR = DATA_RX[0];
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Kominikator.c,84 :: 		}
L_beeRecive4:
;Kominikator.c,85 :: 		}
L_end_beeRecive:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _beeRecive
_DrawFrame:
;Kominikator.c,86 :: 		void DrawFrame() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,87 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Kominikator.c,88 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Kominikator.c,89 :: 		}
L_end_DrawFrame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawFrame
_main:
;Kominikator.c,90 :: 		void main() {
;Kominikator.c,92 :: 		HID_Enable(&readbuff, &writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;Kominikator.c,94 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0); // Set PA0 as digital input
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Kominikator.c,95 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_1); // Set PA0 as digital input
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Kominikator.c,97 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;Kominikator.c,98 :: 		GPIOC_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;Kominikator.c,100 :: 		Delay_ms(100);
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
;Kominikator.c,102 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_LOW);
MOVW	R1, #255
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;Kominikator.c,104 :: 		Initialize();
BL	_Initialize+0
;Kominikator.c,105 :: 		DrawFrame();
BL	_DrawFrame+0
;Kominikator.c,107 :: 		do {
L_main9:
;Kominikator.c,108 :: 		beeRecive();
BL	_beeRecive+0
;Kominikator.c,110 :: 		USB_Polling_Proc();
BL	_USB_Polling_Proc+0
;Kominikator.c,111 :: 		kk = HID_Read();
BL	_HID_Read+0
MOVW	R1, #lo_addr(_kk+0)
MOVT	R1, #hi_addr(_kk+0)
STRB	R0, [R1, #0]
;Kominikator.c,112 :: 		if (kk != 0) {
CMP	R0, #0
IT	EQ
BEQ	L_main12
;Kominikator.c,113 :: 		usbSend();
BL	_usbSend+0
;Kominikator.c,114 :: 		}
L_main12:
;Kominikator.c,116 :: 		USB_Polling_Proc();
BL	_USB_Polling_Proc+0
;Kominikator.c,118 :: 		usbRecive();
BL	_usbRecive+0
;Kominikator.c,121 :: 		} while (1);
IT	AL
BAL	L_main9
;Kominikator.c,123 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
