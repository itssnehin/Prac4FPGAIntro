`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2020 12:44:22
// Design Name: 
// Module Name: Tutorial_tb
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


module Tutorial_tb();

//create a fake clock signal
reg clk = 0;

//toggle the clock
always begin
    #100 clk = ~clk;        // #100 means 100ns delay between inverting the clock signal
end

endmodule
