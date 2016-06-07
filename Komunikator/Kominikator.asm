_draw_frame:
;Kominikator.c,29 :: 		void draw_frame() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,30 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Kominikator.c,31 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Kominikator.c,33 :: 		TFT_Write_Text(">>> COMMUNICATOR <<<", 80, 20);
MOVW	R0, #lo_addr(?lstr1_Kominikator+0)
MOVT	R0, #hi_addr(?lstr1_Kominikator+0)
MOVS	R2, #20
MOVS	R1, #80
BL	_TFT_Write_Text+0
;Kominikator.c,34 :: 		TFT_Write_Text("Byte 1 :", 140, 80);
MOVW	R0, #lo_addr(?lstr2_Kominikator+0)
MOVT	R0, #hi_addr(?lstr2_Kominikator+0)
MOVS	R2, #80
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Kominikator.c,35 :: 		TFT_Write_Text("Byte 2 :", 140, 120);
MOVW	R0, #lo_addr(?lstr3_Kominikator+0)
MOVT	R0, #hi_addr(?lstr3_Kominikator+0)
MOVS	R2, #120
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Kominikator.c,36 :: 		TFT_Write_Text("Byte 3 :", 140, 160);
MOVW	R0, #lo_addr(?lstr4_Kominikator+0)
MOVT	R0, #hi_addr(?lstr4_Kominikator+0)
MOVS	R2, #160
MOVS	R1, #140
BL	_TFT_Write_Text+0
;Kominikator.c,38 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Kominikator.c,40 :: 		TFT_Set_Brush(1, CL_WHITE, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
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
;Kominikator.c,42 :: 		TFT_Set_Pen(CL_WHITE, 0);
MOVS	R1, #0
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;Kominikator.c,43 :: 		}
L_end_draw_frame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_frame
_display_on_screen:
;Kominikator.c,45 :: 		void display_on_screen() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,46 :: 		ByteToStr(DATA_TX[0], &txt);      // Convert byte to string
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,47 :: 		TFT_Write_Text(txt, 215, 80);    // Display string on TFT
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,49 :: 		ByteToStr(DATA_TX[1], &txt);
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,50 :: 		TFT_Write_Text(txt, 215, 120);
MOVS	R2, #120
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,52 :: 		ByteToStr(DATA_TX[2], &txt);
MOVW	R0, #lo_addr(_DATA_TX+2)
MOVT	R0, #hi_addr(_DATA_TX+2)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Kominikator.c,53 :: 		TFT_Write_Text(txt, 215, 160);
MOVS	R2, #160
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Kominikator.c,55 :: 		delay_ms(200);
MOVW	R7, #40703
MOVT	R7, #36
NOP
NOP
L_display_on_screen0:
SUBS	R7, R7, #1
BNE	L_display_on_screen0
NOP
NOP
NOP
;Kominikator.c,58 :: 		TFT_Rectangle(215, 40, 255, 180);
MOVS	R3, #180
SXTH	R3, R3
MOVS	R2, #255
SXTH	R2, R2
MOVS	R1, #40
SXTH	R1, R1
MOVS	R0, #215
SXTH	R0, R0
BL	_TFT_Rectangle+0
;Kominikator.c,60 :: 		}
L_end_display_on_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _display_on_screen
_usbCommunication:
;Kominikator.c,62 :: 		void usbCommunication() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,63 :: 		USB_Polling_Proc();
BL	_USB_Polling_Proc+0
;Kominikator.c,65 :: 		if (HID_Read() != 0) {                                    //usb data recived
BL	_HID_Read+0
CMP	R0, #0
IT	EQ
BEQ	L_usbCommunication2
;Kominikator.c,66 :: 		if (readbuff[2] == 0) { //Read request from server - usb polling protocol
MOVW	R0, #lo_addr(_readbuff+2)
MOVT	R0, #hi_addr(_readbuff+2)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_usbCommunication3
;Kominikator.c,67 :: 		usbSend();
BL	_usbSend+0
;Kominikator.c,68 :: 		} else {                                      //Data recived form server
IT	AL
BAL	L_usbCommunication4
L_usbCommunication3:
;Kominikator.c,69 :: 		beeSend();
BL	_beeSend+0
;Kominikator.c,70 :: 		}
L_usbCommunication4:
;Kominikator.c,71 :: 		}
L_usbCommunication2:
;Kominikator.c,72 :: 		}
L_end_usbCommunication:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _usbCommunication
_usbSend:
;Kominikator.c,74 :: 		void usbSend() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,76 :: 		writebuff[0] = DATA_RX[0];
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
STRB	R1, [R0, #0]
;Kominikator.c,77 :: 		writebuff[1] = DATA_RX[1];
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+1)
MOVT	R0, #hi_addr(_writebuff+1)
STRB	R1, [R0, #0]
;Kominikator.c,78 :: 		writebuff[2] = DATA_RX[2];
MOVW	R0, #lo_addr(_DATA_RX+2)
MOVT	R0, #hi_addr(_DATA_RX+2)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_writebuff+2)
MOVT	R0, #hi_addr(_writebuff+2)
STRB	R1, [R0, #0]
;Kominikator.c,80 :: 		HID_Write(&writebuff, 64);
MOVS	R1, #64
MOVW	R0, #lo_addr(_writebuff+0)
MOVT	R0, #hi_addr(_writebuff+0)
BL	_HID_Write+0
;Kominikator.c,81 :: 		}
L_end_usbSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _usbSend
_beeSend:
;Kominikator.c,83 :: 		void beeSend() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Kominikator.c,85 :: 		DATA_TX[0] = readbuff[0];
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Kominikator.c,86 :: 		DATA_TX[1] = readbuff[1];
MOVW	R0, #lo_addr(_readbuff+1)
MOVT	R0, #hi_addr(_readbuff+1)
STR	R0, [SP, #8]
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
;Kominikator.c,87 :: 		DATA_TX[2] = readbuff[2];
MOVW	R0, #lo_addr(_readbuff+2)
MOVT	R0, #hi_addr(_readbuff+2)
STR	R0, [SP, #4]
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+2)
MOVT	R0, #hi_addr(_DATA_TX+2)
STRB	R1, [R0, #0]
;Kominikator.c,89 :: 		write_TX_normal_FIFO();
BL	_write_TX_normal_FIFO+0
;Kominikator.c,91 :: 		readbuff[0] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
STRB	R1, [R0, #0]
;Kominikator.c,92 :: 		readbuff[1] = 0;
MOVS	R1, #0
LDR	R0, [SP, #8]
STRB	R1, [R0, #0]
;Kominikator.c,93 :: 		readbuff[2] = 0;
MOVS	R1, #0
LDR	R0, [SP, #4]
STRB	R1, [R0, #0]
;Kominikator.c,95 :: 		}
L_end_beeSend:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _beeSend
_beeRecive:
;Kominikator.c,97 :: 		void beeRecive() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Kominikator.c,98 :: 		if (Debounce_INT() == 0) {             // Debounce line INT
BL	_Debounce_INT+0
CMP	R0, #0
IT	NE
BNE	L_beeRecive5
;Kominikator.c,99 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
MOVS	R0, #49
SXTB	R0, R0
BL	_read_ZIGBEE_short+0
MOVW	R1, #lo_addr(_temp1+0)
MOVT	R1, #hi_addr(_temp1+0)
STRB	R0, [R1, #0]
;Kominikator.c,100 :: 		read_RX_FIFO();                     // Read receive data
BL	_read_RX_FIFO+0
;Kominikator.c,101 :: 		display_on_screen();
BL	_display_on_screen+0
;Kominikator.c,102 :: 		}
L_beeRecive5:
;Kominikator.c,103 :: 		}
L_end_beeRecive:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _beeRecive
_main:
;Kominikator.c,105 :: 		void main() {
;Kominikator.c,106 :: 		Initialize();
BL	_Initialize+0
;Kominikator.c,107 :: 		draw_frame();
BL	_draw_frame+0
;Kominikator.c,109 :: 		HID_Enable(&readbuff, &writebuff);
MOVW	R1, #lo_addr(_writebuff+0)
MOVT	R1, #hi_addr(_writebuff+0)
MOVW	R0, #lo_addr(_readbuff+0)
MOVT	R0, #hi_addr(_readbuff+0)
BL	_HID_Enable+0
;Kominikator.c,110 :: 		GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
BL	_GPIO_Digital_Input+0
;Kominikator.c,111 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
NOP
;Kominikator.c,112 :: 		do {
L_main8:
;Kominikator.c,113 :: 		beeRecive();
BL	_beeRecive+0
;Kominikator.c,114 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
NOP
;Kominikator.c,115 :: 		usbCommunication();
BL	_usbCommunication+0
;Kominikator.c,116 :: 		} while (1);
IT	AL
BAL	L_main8
;Kominikator.c,118 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
