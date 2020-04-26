`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2020 15:51:27
// Design Name: 
// Module Name: betterDebounce
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

/*
Our debounce module takes a raw button input and produces a synchronised, bounce-free, output by:
1) Synchronising the button press to the clock to combat metastability
2) Waiting for a consistent signal before reporting a button state change: this negates bounce
*/

module betterDebounce(
    input CLK100MHZ,
    input BTNL,             // pushbutton BTNL->pin P17
    output reg o_state,     //the debounced output
    output o_ondn,
    output o_onup
    );

    // sync with clock and combat metastability
    reg sync_0, sync_1;
    always @(posedge CLK100MHZ) sync_0 <= BTNL;
    always @(posedge CLK100MHZ) sync_1 <= sync_0;

/*  The deadtime is related to size of the counter and the clock frequency by
    deadtime = (2^N  +2)/f_clk      approximated to     deadtime = (2^N)/f_clk
    
    where N is the number of bits in the counter register
    
    the 22 bit counter register above produces a deadtime of 41,94 ms when f_clk = 100 MHz
*/

    // 41.94 ms counter at 100 MHz
    reg [21:0] counter;
    wire idle = (o_state == sync_1);
    wire max = &counter;

    always @(posedge CLK100MHZ)
    begin
        if (idle)               // button not pressed, therefore reset counter
            counter <= 0;
        else                    // button pressed
        begin
            counter <= counter + 1;
            if (max)                    // when counter overflows (after 41,94ms)
                o_state <= ~o_state;    // toggle the state of the output 
        end
    end

    assign o_ondn = ~idle & max & ~o_state;
    assign o_onup = ~idle & max & o_state;
    
endmodule


/*
Our module checks the button has been continuously pressed or released for 41.94 ms (10 ns x 2^22) before changing the output state. 
The o_ondn and o_onup outputs are similar to the JavaScript keyboard events (onkeydown and onkeyup). 
They're true for one clock tick when the button is pushed down and released respectively. 
*/