`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2020 15:18:42
// Design Name: 
// Module Name: upcounter4bit
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

// 4-bit up counter

module counter(
	input wire clk, reset, enable,
  	output reg [3:0] count
	);
  
  always @ (posedge clk)
    begin
      if (reset == 1'b1) count<=0;	// if reset is high, reset the count
      else if (enable == 1'b1) count <= count+1;
    end
endmodule
