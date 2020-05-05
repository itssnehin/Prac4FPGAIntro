`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2020 14:16:14
// Design Name: 
// Module Name: DebounceTry2_tb
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


module DebounceV1_tb();
reg CLK100MHZ, BTNL;
wire o_state;

DebounceV1 DUT (
    .CLK100MHZ(CLK100MHZ),
    .BTNL(BTNL),
    .o_state(o_state)
    );

initial begin
    CLK100MHZ = 1'b0;
    BTNL = 1'b1;
    
    #5 BTNL = 1'b0;
    #20 BTNL = 1'b1;
    #15 BTNL = 1'b0;
    #15 BTNL = 1'b1;
    #10 BTNL = 1'b0;
    #20 BTNL = 1'b1;
    $finish;
end

always begin
    #20 CLK100MHZ = ~CLK100MHZ;
end

endmodule
