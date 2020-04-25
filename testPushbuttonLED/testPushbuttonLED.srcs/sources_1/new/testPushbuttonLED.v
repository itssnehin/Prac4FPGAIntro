`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2020 13:00:31
// Design Name: 
// Module Name: testPushbuttonLED
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


module testPushbuttonLED(
    input CLK100MHZ, 
    input BTNL,             // pushbutton BTNL->pin P17
    output reg [1:0] LED    // LED[0]->pin H17 and LED[1]->pin K15
);

/*  The five pushbuttons arranged in a plus-sign configuration are "momentary" switches that normally generate a low output when they are at rest, 
    and a high output only when they are pressed. 
    The red pushbutton labeled "CPU RESET," on the other hand, generates a high output when at rest and a low output when pressed
*/

reg previous_state;         
reg [21:0]Count;            //assume count is null on FPGA configuration
    
initial begin
previous_state = 0;         // give the previous_state an initial value of 0 meaning not pressed
Count = 22'd0;              // initialize the Count register to a decimal value of 0 that is 22 bits wide
LED[1] = 0;
LED[0] = 0;
end

/*  The deadtime is related to size of the counter and the clock frequency by
    deadtime = (2^N  +2)/f_clk      approximated to     deadtime = (2^N)/f_clk
    
    where N is the number of bits in the counter register
    
    the 22 bit counter register above produces a deadtime of 41,94 ms when f_clk = 100 MHz
*/

//--------------------------------------------
always @(posedge CLK100MHZ)
begin 
    // implement your logic here
    if(BTNL == previous_state)                    // button has not been pressed
        LED[0] <= previous_state;
    
    else                                            // button has been pressed
        LED[0] <= ~previous_state;                  // change the state of the output
        Count <= 0;                                 // reset count
        Count <= (Count >= 4194303)? 0:Count+1;     // the highest value that can be represented by the 22 bit Count is 4194303 (Highest val = (2^N) -1)
                                                    // functions similar to if else block
    previous_state = ~previous_state;               // update the previous_state variable
end 


endmodule

