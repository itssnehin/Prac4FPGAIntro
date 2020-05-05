`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2020 14:15:40
// Design Name: 
// Module Name: DebounceTry2
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

/* Description:
>> CLK100MHZ=0; BTNL=1; o_state=0;  //initial values

>> on the pos edge of clock check if BTNL=0
>> if BTNL=0: then o_state=1
>> else o_state=0

*/


module DebounceV1(
    input CLK100MHZ,
    input BTNL,
    output reg o_state     //the debounced output
    );
    
    
    
    initial begin
        o_state <= 1'b0;
    end
    
    always @ (posedge CLK100MHZ)
    begin
        if(BTNL == 1'b0) begin
            o_state = 1'b1;
        end
        else begin
            o_state = 1'b0;
        end
    end
    
endmodule

