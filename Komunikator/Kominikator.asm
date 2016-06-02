_usbSend:
;Kominikator.c,23 :: 		void usbSend() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,24 :: 		USB_Polling_Proc();
BL	_USB_Polling_Proc+0
;Kominikator.c,26 :: 		for (cnt = 0; cnt < 64; cnt++) {
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
;Kominikator.c,27 :: 		writebuff[cnt] = 0;
MOVW	R2, #lo_addr(_cnt+0)
MOVT	R2, #hi_addr(_cnt+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;Kominikator.c,26 :: 		for (cnt = 0; cnt < 64; cnt++) {
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
;Kominikator.c,28 :: 		}
IT	AL
BAL	L_usbSend0
L_usbSend1:
;Kominikator.c,29 :: 		writebuff[0] = DATA_RX[0];
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;Kominikator.c,30 :: 		writebuff[1] = DATA_RX[1];
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+1)
MOVT	R0, #hi_addr(_writebuff+1)
STRB	R1, [R0, #0]
;Kominikator.c,31 :: 		writebuff[2] = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
STRB	R1, [R0, #0]
;Kominikator.c,33 :: 		HID_Write(&writebuff, 64);
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
;Kominikator.c,35 :: 		}
L_end_usbSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _usbSend
_usbRecive:
;Kominikator.c,37 :: 		void usbRecive() {
;Kominikator.c,39 :: 		}
L_end_usbRecive:
BX	LR
; end of _usbRecive
_beeSend:
;Kominikator.c,41 :: 		void beeSend() {
;Kominikator.c,43 :: 		}
L_end_beeSend:
BX	LR
; end of _beeSend
_beeRecive:
;Kominikator.c,45 :: 		void beeRecive() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,46 :: 		if (temp1 == 1 && Debounce_INT() == 0) {             // Debounce line INT
MOVW	R0, #lo_addr(_temp1+0)
MOVT	R0, #hi_addr(_temp1+0)
LDRSB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__beeRecive16
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L__beeRecive15
L__beeRecive14:
;Kominikator.c,47 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Kominikator.c,48 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Kominikator.c,50 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Kominikator.c,51 :: 		ByteToStr(DATA_RX[0], &txt);         // Convert third byte to string
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,52 :: 		TFT_Write_Text(txt, 195, 80);       // Display string on TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,54 :: 		ByteToStr(DATA_RX[1], &txt);
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,55 :: 		TFT_Write_Text(txt, 195, 90);
MOVS	R2, #90
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,57 :: 		ByteToStr(DATA_RX[2], &txt);
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,58 :: 		TFT_Write_Text(txt, 195, 100);
MOVS	R2, #100
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,60 :: 		delay_ms(500);
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_beeRecive6:
SUBS	R7, R7, #1
BNE	L_beeRecive6
NOP
NOP
NOP
;Kominikator.c,61 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Kominikator.c,62 :: 		ByteToStr(DATA_RX[0], &txt);
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,63 :: 		TFT_Write_Text(txt, 195, 80);       // Delete string from TFT
MOVS	R2, #80
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,65 :: 		ByteToStr(DATA_RX[1], &txt);
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,66 :: 		TFT_Write_Text(txt, 195, 90);
MOVS	R2, #90
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,68 :: 		ByteToStr(DATA_RX[2], &txt);
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,69 :: 		TFT_Write_Text(txt, 195, 100);
MOVS	R2, #100
MOVS	R1, #195
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,71 :: 		GPIOD_ODR = DATA_RX[0];
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Kominikator.c,46 :: 		if (temp1 == 1 && Debounce_INT() == 0) {             // Debounce line INT
L__beeRecive16:
L__beeRecive15:
;Kominikator.c,73 :: 		}
L_end_beeRecive:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _beeRecive
_DrawFrame:
;Kominikator.c,74 :: 		void DrawFrame() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,75 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Kominikator.c,76 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Kominikator.c,77 :: 		}
L_end_DrawFrame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawFrame
_main:
;Kominikator.c,78 :: 		void main() {
;Kominikator.c,80 :: 		HID_Enable(&readbuff, &writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;Kominikator.c,82 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0); // Set PA0 as digital input
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Kominikator.c,83 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_1); // Set PA0 as digital input
MOVW	R1, #2
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Kominikator.c,85 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;Kominikator.c,86 :: 		GPIOC_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;Kominikator.c,88 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main8:
SUBS	R7, R7, #1
BNE	L_main8
NOP
NOP
NOP
;Kominikator.c,90 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_LOW);
MOVW	R1, #255
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;Kominikator.c,92 :: 		Initialize();
BL	_Initialize+0
;Kominikator.c,93 :: 		DrawFrame();
BL	_DrawFrame+0
;Kominikator.c,95 :: 		do {
L_main10:
;Kominikator.c,96 :: 		beeRecive();
BL	_beeRecive+0
;Kominikator.c,97 :: 		kk = HID_Read();
BL	_HID_Read+0
MOVW	R1, #lo_addr(_kk+0)
MOVT	R1, #hi_addr(_kk+0)
STRB	R0, [R1, #0]
;Kominikator.c,98 :: 		if (kk != 0) {
CMP	R0, #0
IT	EQ
BEQ	L_main13
;Kominikator.c,99 :: 		usbSend();
BL	_usbSend+0
;Kominikator.c,100 :: 		}
L_main13:
;Kominikator.c,102 :: 		} while (1);
IT	AL
BAL	L_main10
;Kominikator.c,104 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
