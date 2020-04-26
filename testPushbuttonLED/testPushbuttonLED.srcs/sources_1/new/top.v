`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2020 16:21:14
// Design Name: 
// Module Name: top
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


module top(
    input CLK100MHZ,
    input BTNL,
    output reg [1:0] LED
    );
    
    wire btnl_state,    btnl_dn,    btnl_up;
    betterDebounce dbnc_btnl (
    .CLK100MHZ(CLK100MHZ),
    .BTNL(BTNL),
    .o_state(btnl_state),
    .o_ondn(btnl_dn),
    .o_onup(btnl_up)
    );
    
    always @ (posedge CLK100MHZ)
    begin
        if (btnl_dn)            // if BTNL is pressed, turn on LED0
        begin
            LED[0] <= 1'b1;
        end
        else
            LED[0] <= 1'b0;
    end
    
endmodule
