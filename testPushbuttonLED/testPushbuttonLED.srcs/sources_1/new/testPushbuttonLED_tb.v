`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2020 15:22:47
// Design Name: 
// Module Name: testPushbuttonLED_tb
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

// Testbench verilog code for debouncing a pushbutton to toggle an LED
module testPushbuttonLED_tb;
// inputs
reg button;
reg clk;

// Outputs
wire DB_out;

// Instantiate the debouncing verilog code
testPushbuttonLED uut (
    .button(button),
    .clk(clk),
    .DB_out(DB_out)
);

initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial begin
    button = 0;
    #10;
    button = 1;
    #20;
    button = 0;
    #10;
    button = 1;
    #30;
    button = 0;
    #10;
    button = 1;
    #40;
    button = 0;
    #10;
    button = 1;
    #30;
    button = 0;
    #10;
    button = 1;
    #400;
    button = 0;
    #10;
    button = 1;
    #20;
    button = 0;
    #10;
    button = 1;
    #30;
    button = 0;
    #10;
    button = 1;
    #40;
    button = 0;
    
end

endmodule
