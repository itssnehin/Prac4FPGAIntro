`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2020 22:43:09
// Design Name: 
// Module Name: tutorial
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tutorial(
    input	CLK100MHZ,
    input BTNC, //delay button
    output  reg[5:0] LED,
    output reg[3:0] AN,
    output reg[6:0] SEG
    );
    reg [5:0] state = 6'b000000;
    reg [3:0]hours1=4'd0;
    reg [3:0]hours2=4'd0;
    reg [3:0]mins1 = 4'd0;
    reg [3:0]mins2 = 4'd0;
    wire reset;
    wire [3:0] segment;
    wire [7:0] driver;
    
    //Reset delay
    Delay_Reset(CLK100MHZ, BTNC, reset);
    
    //Seven Segment display
    SS_Driver ss(
    CLK100MHZ, reset,
    hours1, hours2, mins1, mins2,
    segment, driver);
    
    reg [24:0] counter;
    integer i;
     always @(posedge (CLK100MHZ)) begin
        for(i=0; i<60; i=i+1)begin
            counter <= counter + 1'b1;
            if(counter >= 30000000)
            begin 
                
                state <= state + 1'b1;
                
                counter <= 0;
            end
        //#1000000000    
        LED[0] <= state[0];
        LED[1] <= state[1];
        LED[2] <= state[2];
        LED[3] <= state[3];
        LED[4] <= state[4];
        LED[5] <= state[5];
        
       
       end
       if(state == 6'b111111)begin 
            if(mins2 == 4'd9)begin
                mins2 <= 4'd0;
                mins1 <= mins1+ 1'd1;
                 
                if(mins1 == 4'd6 && mins2 == 4'd0)begin
                    if(hours2 == 4'd9) begin
                        hours1 <= hours1 + 1'd1;
                        hours2 <= 4'd0;
                    end
                    else begin
                        hours2 <= hours2 + 1'd1;
                        if(hours1==4'd2 && hours2 == 4'd4)begin
                            hours1 <= 4'd0;
                            hours2 <= 4'd0;
                        end
                    end
                 end
                
            end
            else begin
                mins2 <= mins2 + 1'd1;
                
            end
       end
       //SEG[3:0] <= ~segment;
       SEG[0] <=  driver[0];
        SEG[1] <= driver[1];
        SEG[2] <= driver[2];
        SEG[3] <= driver[3];
        SEG[4] <= driver[4];
        SEG[5] <= driver[5];
        SEG[6] <= driver[6];
         
        AN[0] <= segment[0];
        AN[1] <= segment[1];
        AN[2] <= segment[2];
        AN[3] <= segment[3];
    end
    
    
endmodule
