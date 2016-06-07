#include "resources.h"
#include "registers.h"
#include "ReadWrite_Routines.h"
#include "Reset_Routines.h"
#include "Misc_Routines.h"
#include "Init_Routines.h"

// BEE Click Board connections
sbit CS at GPIOD_ODR.B13;// CS pin
sbit RST at GPIOC_ODR.B2;// RST pin
sbit INT at GPIOD_ODR.B10;// INT pin
sbit WAKE_ at GPIOA_ODR.B4;// WAKE pin
// Transmitting data
extern short int DATA_TX[];
// Recieving data
extern short int DATA_RX[];

char txt[4];
short int button1;
short int button2;
short int temp1;
//  2 bits sID  , 1b B1, 1b B2, 4bits for analog by this order in sendByteOne byte
unsigned short sendByteOne = 0;
// 8 bits for analog
unsigned short sendByteTwo = 0;
// Board ID (whole byte)
unsigned short sendByteThree = 0;
// ANALOG
unsigned short adc_h;
unsigned short adc_l;
int adc_result = 0;

void draw_frame() {
        TFT_Init_ILI9341_8bit(320, 240);
        TFT_Fill_Screen(CL_WHITE);
        TFT_Write_Text("BOARD ID :", 140, 40);    // Display string on TFT
        TFT_Write_Text("Button 1 :", 140, 80);
        TFT_Write_Text("Button 2 :", 140, 120);
        TFT_Write_Text("ANALOG 1 :", 140, 160);
        // Display stuff
        TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
        // Fill rect
        TFT_Set_Brush(1, CL_WHITE, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
        // Rect border delete
        TFT_Set_Pen(CL_WHITE, 0);
}

void parse_analog() {
        adc_l = adc_result % 256;
        adc_h = (adc_result - adc_l) / 265;
        sendByteTwo = adc_l;
        sendByteOne |= adc_h;
}

void display_on_screen() {
        ByteToStr(sendByteThree, &txt);  //Board ID
        TFT_Write_Text(txt, 215, 40);

        ByteToStr(button1, &txt);      // Convert byte to string
        TFT_Write_Text(txt, 215, 80);    // Display string on TFT

        ByteToStr(button2, &txt);
        TFT_Write_Text(txt, 215, 120);

        IntToStr(adc_result, &txt);
        TFT_Write_Text(txt, 215, 160);

        delay_ms(1000);

        // Clear screen with white rectangle
        TFT_Rectangle(215, 40, 255, 180);
}

void read_sensors() {
        // Button 1 pressed
        if (Button(&GPIOD_IDR, 0, 1, 1) && button1 == 0) {          // detect logical one on PA0 pin
            button1 = 1;
            sendByteOne |= 0b00100000;
        }
        // Button 1 relesed
        else if (!Button(&GPIOD_IDR, 0, 1, 1) && button1 == 1){
            button1 = 0;
            sendByteOne &= 0b11011111;
        }
        // Button 2 pressed
        if (Button(&GPIOD_IDR, 1, 1, 1) && button2 == 0) {          // detect logical one on PA0 pin
            button2 = 1;
            sendByteOne |= 0b00010000;
        }
        // Button 2 relesed
        else if (!Button(&GPIOD_IDR, 1, 1, 1) && button2 == 1){
            button2 = 0;
            sendByteOne &= 0b11101111;
        }
        // ANALOG
        adc_result = ADC1_Get_Sample(3); // Get ADC value from corresponding channel
        parse_analog();
        // END ANALOG
}

void run_transmitter() {
        read_sensors();
        // PROTOCOL BYTES
        DATA_TX[0] = sendByteOne;
        DATA_TX[1] = sendByteTwo;
        DATA_TX[2] = sendByteThree;

        // SENDING
        write_TX_normal_FIFO();          // Transmiting

        // Display inputs on TFT
        display_on_screen();
}

void listen_for_id() {
        // Check if message is for me 0b01000000
        if (Debounce_INT() == 0 && DATA_RX[0] == 64 && sendByteThree == 0) {
           temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
           read_RX_FIFO();                     // Read receive data
           sendByteThree = DATA_RX[2];
        }
}

void main() {
        Initialize();                      // Initialize MCU and Bee click board
        draw_frame();

        GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
        ADC_Set_Input_Channel(_ADC_CHANNEL_3);                 // Choose ADC channel
        ADC1_Init();                                               // Init
        DATA_RX[2] = 0;
        Delay_ms(100);
        while (1) {
              // Listen for my ID
              listen_for_id();
              // Run Transmitter
              run_transmitter();
              // Pause between sendings
              Delay_ms(100);
        }
}