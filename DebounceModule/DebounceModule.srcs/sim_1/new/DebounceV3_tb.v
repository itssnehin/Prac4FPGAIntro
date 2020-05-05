`timescale 1ns / 1ps            // set timescale and precision
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2020 15:21:22
// Design Name: 
// Module Name: DebounceV3_tb
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

module DebounceV3_tb();
    reg CLK100MHZ;
    reg BTNC;
    reg BTNL;
    wire DB_out;
 
    DebounceV3 #(.N(9))                // redefine the parameter N to N=9 to get debounce delay of 10.34us instead of 5.12us which the formula says we should get
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
            #10e3 BTNC = 1'b1;          // at time 10us release the reset
            
             
            // We need at least twice the counter value to stabilize value of DB_out
            // before we change the button in
            #50e3 BTNL = 1'b0;     // We pressed the key here.....wait 50us  
            #10e3 BTNL = 1'b1;       // Key debounce to 1 after 5us            
            #10e3 BTNL = 1'b0;       // Debounce after 10us
            #20e3 BTNL = 1'b1;      // Decounce after 20us          
            #30e3 BTNL = 1'b0;
            #40e3 BTNL = 1'b1;
            #50e3 BTNL = 1'b0;     
            #50e3 BTNL = 1'b1;
            #50e3;
            $finish;
    end
    always begin
            #20 CLK100MHZ = ~CLK100MHZ;  // toggle clock every 20ns
    end    
/* 
initial
  begin
  $dumpfile ("debounce.vcd");
  $dumpvars (0,DeBounce_tf);
  end
*/

endmodule
