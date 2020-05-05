`timescale 1ns / 1ps        // set timescale and precision
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2020 14:15:40
// Design Name: 
// Module Name: DebounceModule
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


module  DebounceV3(
    // inputs
    input   clk, button_reset, button_in,
    // outputs
    output reg DB_out
    );
    
    parameter N =22 ;                   // parameter that controls debounce time by defining number of bits in counter register 
                                        // parameter can be given a different value when module is called/instantiated
    
    /*  
    Parameter N defines the debounce time/ deadtime.
    The deadtime is related to size of the counter and the clock frequency by
    deadtime = (2^N  +2)/f_clk      approximated to     deadtime = (2^N)/f_clk
    
    where N is the number of bits in the counter register
    
    a 22 bit counter register produces a deadtime of 41,94 ms when f_clk = 100 MHz
    */
    
    
    reg  [N-1 : 0]  delaycount_reg;                     
    reg  [N-1 : 0]  delaycount_next;
     
    reg DFF1, DFF2;                                 
    wire q_add;                                     
    wire q_reset;
 
    always @ ( posedge clk )
    begin
        if(button_reset ==  1'b0)                        // At reset initialize FF's and counter register
            begin
                DFF1 <= 1'b0;
                DFF2 <= 1'b0;
                delaycount_reg <= { N {1'b0} };     // writes 1'b0 N times..... equivalent to delaycount_reg <= 22'b0; for N=22   
            end
        else
            begin
                DFF1 <= button_in;
                DFF2 <= DFF1;
                delaycount_reg <= delaycount_next;  // value of delaycount_reg depends on next logic state, explained later
            end
    end
     
     
    assign q_reset = (DFF1  ^ DFF2);                // XOR the two flip flops on consecutive clock cycles to detect a level change on button_in 
                                      
    assign  q_add = ~(delaycount_reg[N-1]);         // Check if counter register has reached its max value (i.e. debounce time has elapsed) 
                                                    // by checking MSB of delaycount_reg
    /*                                                
    // if q_add == 1 delaycount_reg has NOT reached its max value, therefore continue to increment it
    // if q_add == 0 delaycount_reg has reached its max value, therefore reset it     
    */ 
 
    always @ ( q_reset, q_add, delaycount_reg)
        begin
            case( {q_reset , q_add})
                2'b00 : // Case when no button change and counter reaches max value
                        /* If button_in stays same ( q_reset stays 0), and counter's MSB becomes 1 ( q_add is 0), 
                        // delaycount_next is assigned the value of delaycount_reg;
                        // ( Question to readers - can we assign 0 to delacount_next )
                        */
                        delaycount_next <= delaycount_reg;
                        
                2'b01 : // Case when no button change and counter does NOT reach max value
                        // If button_in stays the same ( q_reset stays 0), and counter's MSB is still not 1 ( q_add is 1), increment delaycount_next
                        delaycount_next <= delaycount_reg + 1;
                        
                default : // Case when button level changes
                        // In this case q_reset = 1 => change in level. Reset the counter 
                        // If button_in changes its value, q_reset becomes 1, and therefore reset the delaycount_next to 0.
                        delaycount_next <= { N {1'b0} };
            endcase    
        end
     
    // Finally, the debounce output DB_out is assigned the value of DFF2 if the MSB of the counter becomes 1.
    // Else, it retains its previous value. 
    always @ ( posedge clk )
        begin
            if(delaycount_reg[N-1] == 1'b1)
                    DB_out <= DFF2;
            else
                    DB_out <= DB_out;
        end
         
endmodule