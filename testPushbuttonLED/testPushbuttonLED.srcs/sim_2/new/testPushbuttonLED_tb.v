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
module testPushbuttonLED_tb();
// inputs
reg BTNL = 0;       // pushbutton connected to pin P17
reg CLK100MHZ = 0;

// Outputs
wire [1:0] LED = 0;

// Instantiate the debouncing verilog code
testPushbuttonLED DUT (                     // This instance of the module is named DUT meaning Device Under Test
    .BTNL(BTNL),
    .CLK100MHZ(CLK100MHZ),
    .LED(LED)
);

/*
initial begin
    CLK100MHZ = 0;
    forever #1 CLK100MHZ = ~CLK100MHZ;
end
*/

// toggle the clock
always begin
    #10 CLK100MHZ = ~CLK100MHZ;     // #10 means 10ns delay between inverting the clock
end


initial begin
    BTNL = 0;
    #10;                // 10ns delay
    BTNL = 1;
    #20;
    BTNL = 0;
    #10;
    BTNL = 1;
    #30;
    BTNL = 0;
    #10;
    BTNL = 1;
    #40;
    /*
    BTNL = 0;
    #10;
    BTNL = 1;
    #30;
    BTNL = 0;
    #10;
    BTNL = 1;
    #400;
    BTNL = 0;
    #10;
    BTNL = 1;
    #20;
    BTNL = 0;
    #10;
    BTNL = 1;
    #30;
    BTNL = 0;
    #10;
    BTNL = 1;
    #40;
    BTNL = 0;
    */
    //$finish             //This line tells the simulator we are done simulating
end

endmodule
