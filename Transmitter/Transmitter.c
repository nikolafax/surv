#include "resources.h"
#include "registers.h"
#include "ReadWrite_Routines.h"
#include "Reset_Routines.h"
#include "Misc_Routines.h"
#include "Init_Routines.h"

// BEE Click Board connections
sbit CS at GPIOD_ODR.B13;                // CS pin
sbit RST at GPIOC_ODR.B2;                // RST pin
sbit INT at GPIOD_ODR.B10;               // INT pin
sbit WAKE_ at GPIOA_ODR.B4;              // WAKE pin
// Transmitting data
extern short int DATA_TX[];
// Recieving data
extern short int DATA_RX[];

char txt[4];
short int state1;
short int state2;
short int state3;
short int temp1;
// sID  , B1, B2, 4bits for analog
unsigned short sendByteOne = 0;
// 8 bits for analog
unsigned short sendByteTwo = 0;
// Board ID (whole byte)
unsigned short sendByteThree = 0;
// ANALOG
unsigned short adc_h;
unsigned short adc_l;
int adc_result = 0;
int adc_result_screen = 0;

void draw_frame(){
  TFT_Init_ILI9341_8bit (320,240);
  TFT_Fill_Screen(CL_WHITE);
  TFT_Write_Text("BOARD ID :", 140, 40);    // Display string on TFT
  TFT_Write_Text("Button 1 :", 140, 80);
  TFT_Write_Text("Button 2 :", 140, 120);
  TFT_Write_Text("ANALOG 1 :", 140, 160);

  DATA_RX[2] = 0;
}

void parse_analog()
{
  adc_l = adc_result % 256;
  adc_h = (adc_result - adc_l) / 265;
  sendByteTwo = adc_l;
  sendByteOne |= adc_h;

}

void display_on_screen(){
    // Display stuff
    TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);

    ByteToStr(sendByteThree,&txt);
    TFT_Write_Text(txt, 215, 40);
    
    ByteToStr(state1,&txt);      // Convert byte to string
    TFT_Write_Text(txt, 215, 80);    // Display string on TFT

    ByteToStr(state2,&txt);
    TFT_Write_Text(txt, 215, 120);

    IntToStr(adc_result_screen,&txt);
    TFT_Write_Text(txt, 215, 160);
    
    delay_ms(1000);
    
    // Clear screen
    TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
    
    ByteToStr(sendByteThree,&txt);
    TFT_Write_Text(txt, 215, 40);
    
    ByteToStr(state1,&txt);
    TFT_Write_Text(txt, 215, 80);

    ByteToStr(state2,&txt);
    TFT_Write_Text(txt, 215, 120);
    
    ByteToStr(adc_result_screen,&txt);
    TFT_Write_Text(adc_result_screen, 215, 160);
}

void read_sensors(){
    if (Button(&GPIOD_IDR, 0, 1, 1)){                      // detect logical one on PA0 pin
             if (state1 == 0){
                state1 = 1;
                sendByteOne ^= 0b00100000;
             }
             else{
                state1 = 0;
                sendByteOne ^= 0b00100000;
                }
          }
    if (Button(&GPIOD_IDR, 1, 1, 1)){                      // detect logical one on PA0 pin
             if (state2 == 0){
                state2 = 1;
                sendByteOne ^= 0b00010000;
             }
             else{
                state2 = 0;
                sendByteOne ^= 0b00010000;
                }
          }
    // ANALOG
    adc_result = ADC1_Get_Sample(3);                          // Get ADC value from corresponding channel
    parse_analog();
    Delay_ms(20);
    // END ANALOG
}

void listen_for_id(){
    // ID is not,jet, set
    if (sendByteThree == 0 && Debounce_INT() == 0){
       temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
       read_RX_FIFO();                     // Read receive data
       // Check if message is for me
       if(DATA_RX[0] == 127){
         sendByteThree = DATA_RX[2];
       }
    }
}

void run_transmitter() {
  read_sensors();

  // PROTOCOL BYTES
  DATA_TX[0] = sendByteOne;
  DATA_TX[1] = sendByteTwo;
  DATA_TX[2] = sendByteThree;
  // Calc for analog to display
  adc_result_screen = ((DATA_TX[0] & 0b00001111) * 256) + DATA_TX[1];
  
  // SENDING
  write_TX_normal_FIFO();          // Transmiting

  // Display inputs on TFT
  display_on_screen();
}

void main() {
  Initialize();                      // Initialize MCU and Bee click board
  draw_frame();

  GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_0);
  ADC_Set_Input_Channel(_ADC_CHANNEL_3);                     // Choose ADC channel
  ADC1_Init();                                               // Init
  Delay_ms(100);
  while(1) {
    // Listen for my ID
    listen_for_id();
    
    // Transmit board inputs
    run_transmitter();
  }
}