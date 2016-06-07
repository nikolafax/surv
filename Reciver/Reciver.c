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
short int button1 = 0;
short int button2 = 0;
short int temp1;
//  2 bits sID  , 1b B1, 1b B2, 4bits for analog by this order in recivedByteOne byte
unsigned short recivedByteOne = 0;
// 8 bits for analog
unsigned short recivedByteTwo = 0;
// Board ID (whole byte)
unsigned short deviceIdByte = 0;
// ANALOG
unsigned short adc_h;
unsigned short adc_l;
int adc_result = 0;
int life_notifyer_counter = 0;

void brodcast_id_request();

void draw_frame() {
        TFT_Init_ILI9341_8bit(320, 240);
        TFT_Fill_Screen(CL_WHITE);
        TFT_Write_Text(">>> RECEIVER <<<", 80, 40);
        TFT_Write_Text("BOARD ID :", 140, 80);
        TFT_Write_Text("Button 1 :", 140, 120);
        TFT_Write_Text("Button 2 :", 140, 160);
        TFT_Write_Text("ANALOG 1 :", 140, 200);
        
        // Display characters color
        TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
        // Fill rect with white color
        TFT_Set_Brush(1, CL_WHITE, 0, LEFT_TO_RIGHT, CL_AQUA, CL_AQUA);
        // Rect border delete
        TFT_Set_Pen(CL_WHITE, 0);
}

void display_on_screen() {
        // Display stuff
        TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);

        ByteToStr(deviceIdByte, &txt);
        TFT_Write_Text(txt, 215, 80);

        ByteToStr(button1, &txt);      // Convert byte to string
        TFT_Write_Text(txt, 215, 120);    // Display string on TFT

        ByteToStr(button2, &txt);
        TFT_Write_Text(txt, 215, 160);

        IntToStr(adc_result, &txt);
        TFT_Write_Text(txt, 215, 200);
        
        delay_ms(1000);

        // Clear screen with white rectangle
        TFT_Rectangle(215, 80, 255, 220);
}

void parse_adc_values() {
        adc_h = DATA_RX[0] & 0b00001111;
        adc_l = DATA_RX[1];
        adc_result = adc_h * 256;
        adc_result = adc_result + adc_l;
}

void listen_messages() {
    temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
    read_RX_FIFO();
    // Check if message is for my type(reciever)
    if (Debounce_INT() == 0 && (DATA_RX[0] & 0b11000000) == 128) {
       // Message is just for me, yeah!!!
       if (DATA_RX[2] == deviceIdByte) {

          // Button 1 pressed (On some board)
          if ((DATA_RX[0] & 0x20) == 32){
             button1 = 1;
          }
          // Button 1 relesed (On some board)
          else if ((DATA_RX[0] & 0x20) == 0){
             button1 = 0;
          }
          // Button 2 pressed (On some board)
          if ((DATA_RX[0] & 0x19) == 16){
             button2 = 1;
          }
          // Button 2 relesed (On some board)
          else if ((DATA_RX[0] & 0x20) == 0){
             button2 = 0;
          }
          // Parse analog bits
          parse_adc_values();
       }
    }
    // Display everything on screen
    display_on_screen();
}

void brodcast_id_request() {
        // PROTOCOL BYTES
        DATA_TX[0] = 0xC0;
        DATA_TX[1] = 0;
        DATA_TX[2] = deviceIdByte;

        // SENDING
        write_TX_normal_FIFO();          // Transmiting
}

void listen_for_id() {
        brodcast_id_request();
        temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
        read_RX_FIFO();                     // Read receive data
        // ID is not,jet, set
        if (Debounce_INT() == 0) {
                // Check if message is for me
                if (DATA_RX[0] == 112) {
                   deviceIdByte = DATA_RX[2];
                   display_on_screen();
                }
        }
}

void main() {
        Initialize();                      // Initialize MCU and Bee click board
        draw_frame();
        deviceIdByte = 0;
        GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
        Delay_ms(100);

        while (1) {
              if (deviceIdByte == 0){
                 // Listen for my ID
                 listen_for_id();
                 Delay_ms(50);
              }
              // Listen messages
              listen_messages();
              life_notifyer_counter++;
              if (life_notifyer_counter > 2){
                 life_notifyer_counter = 0;
                 brodcast_id_request();
              }
        }
}