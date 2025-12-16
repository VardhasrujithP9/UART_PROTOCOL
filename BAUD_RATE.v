// Baud rate in UART (Universal Asynchronous Receiver Transmitter) means
// 👉 number of bits transmitted per second (bps).
// Baud Rate = Speed of communication
// 9600 baud → 9600 bits are transmitted per second

// Why Baud Rate is Important...........?

// UART is asynchronous (no common clock)
// Both transmitter and receiver must use the SAME baud rate
// If baud rates mismatch → data corruption


module baud_rate(
  input clk,
  output reg tx_en,rx_en);
  
  reg[12:0]tx_counter; //5208 binary 0001 0100 0101 1000 remove first 3 zeros
  reg[9:0]rx_counter;  // 325 binary 0001 0100 0101  remove firsr 3 zeros
  
  always @(posedge clk)
     begin
       if(tx_counter==5208)
            tx_counter=0;
       else 
           tx_counter=tx_counter+1'b1; //tx counter increment
     end
  always @(posedge clk)
     begin
       if(rx_counter==5208)
            rx_counter=0;
       else 
           rx_counter=rx_counter+1'b1; //rx increment
     end
  assign tx_en=(tx_counter==0)?1'b1:1'b0; //counter reches to 5208 cycle the Tx_counter ==0 and  tx_en==1; will be asssigned
  
  assign rx_en=(rx_counter==0)?1'b1:1'b0; //counter reches to 5208 cycle the Tx_counter ==0 and  tx_en==1; will be asssigned
endmodule

  
       