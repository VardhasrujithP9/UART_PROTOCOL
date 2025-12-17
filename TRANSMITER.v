module uart_transmitter(

  input clk,
  input rst,
  input wr_en,
  input [7:0] data_in,
  output  reg tx,
  output busy
               );
  
  
  parameter idle=2'b00;
  parameter start=2'b01;
  parameter data =2'b10;
  parameter stop=2'b11;
  
  reg [7:0]data;
  reg [2:0]index;// 2^3 indexs//
  reg [1:0]state=idle_state;
  
  always @(posedge clk)
    beign 
    if(rst==1)
      begin
        tx=1'b1;
      end
  
  always @(posedge clk)
    begin
      case(state)
        ideal_state :begin
                     if(wr_en)
                         begin 
                             state <= start_idel;
                             data <= data_in;
                             index <= 3'h0
                        end
                   
                    else
                       
                             state <= idle_state;
                     
                    end
        
        start_state:begin
                      if(enb)
                         begin 
                              tx <=1'b0;
                              state <= data_state;
                        end
          
                      else
                        
                             state <= start_state;
          
                     end


        data_state:begin
                      if(enb)
                        begin 
                          if(index == 3'h7)
                              state <= stop_state;
                          else 
                              index = index + 3'h1;
                              tx <= data[index];
                        end
                    end
        
        stop_state:begin
                      if(enb)
                        begin 
                               tx <= 1'b1;
                               state <= idle-state;
                        end
          
                    end
        
            default : begin
              tx <= 1'b1;
              state <= idle_state;
            end
          endcase
        end

  
  
  assign busy =  (state!=idle_state);
  