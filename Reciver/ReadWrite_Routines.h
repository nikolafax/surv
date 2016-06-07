short int read_ZIGBEE_long(int address);
void write_ZIGBEE_long(int address, short int data_r);
short int read_ZIGBEE_short(short int address);
void write_ZIGBEE_short(short int address, short int data_r);
void read_RX_FIFO();
void start_transmit();
void write_TX_normal_FIFO();