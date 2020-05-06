`timescale 1ns / 1ps            // set timescale and precision
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2020 17:20:47
// Design Name: 
// Module Name: Debounce_tb
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



/* Description: WORKING IMPLEMENTATION!!!
1 Problem: Dont think the formula for calculating register size for specific debounce time delay is accurate
for N=9 get debounce delay = 10.34us instead of 5.12us

Full code explanation available at:
http://referencedesigner.com/blog/key-debounce-implementation-in-verilog/2649/

Pushbutton debounce module that makes use of two DFF's (D-type Flip Flops) to store logic levels of button_input during two consecutive clock periods
See bottom of file for code explanation

*/

module Debounce_tb();
    // inputs
    reg CLK100MHZ;
    reg BTNC;
    reg BTNL;
    // outputs
    wire DB_out;
 
    Debounce #(.N(22))                // redefine the parameter N to N=22 to get debounce delay of instead of 41.94ms which the formula says we should get
    DUT (
        .clk(CLK100MHZ), 
        .button_reset(BTNC), 
        .button_in(BTNL),
        .DB_out(DB_out)
        );
 
    
    initial begin
            CLK100MHZ = 1'b0;
            BTNC = 1'b0;
            BTNL = 1'b1;                // button starts off high (unpressed)
            #10e6 BTNC = 1'b1;          // at time 10ms release the reset
            
             
            // We need at least twice the counter value to stabilize value of DB_out
            // before we change the button in
            #90e6 BTNL = 1'b0;     // We pressed the key here.....wait 90ms  
            #20e6 BTNL = 1'b1;       // Key debounce to 1 after 20ms          
            #20e6 BTNL = 1'b0;       // Debounce after 20ms
            #40e6 BTNL = 1'b1;      // Decounce after 20us          
            #60e6 BTNL = 1'b0;
            #50e6 BTNL = 1'b1;
            #50e6 BTNL = 1'b0;     
            #50e6 BTNL = 1'b1;
            #50e6;
            $finish;
    end
    always begin
            #10 CLK100MHZ = ~CLK100MHZ;  // toggle clock every 10ns
    end    
/* 
initial
  begin
  $dumpfile ("debounce.vcd");
  $dumpvars (0,DeBounce_tf);
  end
*/

endmodule
