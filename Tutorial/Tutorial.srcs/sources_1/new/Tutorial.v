`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2020 15:36:33
// Design Name: 
// Module Name: Tutorial
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


module Tutorial(
    input	CLK100MHZ,
    input[1:0] sw,
    output reg [1:0] LED
    );
    
    
    always @(posedge CLK100MHZ) begin
        LED[0] <= sw[0];
        LED[1] <= !sw[1];
    end

endmodule
