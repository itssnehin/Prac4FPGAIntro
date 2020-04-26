`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2020 16:34:35
// Design Name: 
// Module Name: top_tb
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


module top_tb();
// inputs
reg BTNL;
reg CLK100MHZ;

// Outputs
wire [1:0] LED;

// instantiate module top.v
top DUT(
.CLK100MHZ(CLK100MHZ),
.BTNL(BTNL),
.LED(LED)
);

// toggle the clock
always begin
    #10 CLK100MHZ = ~CLK100MHZ;     // #10 means 10ns delay between inverting the clock
end


initial begin
    BTNL = 1'b0;
    #10;                // 10ns delay
    BTNL = 1'b1;
    #20;
    BTNL = 1'b0;
    #10;
    BTNL = 1'b1;
    #30;
    BTNL = 1'b0;
    #10;
    BTNL = 1'b1;
    #40;
    BTNL = 1'b0;
    #10;
end
endmodule
