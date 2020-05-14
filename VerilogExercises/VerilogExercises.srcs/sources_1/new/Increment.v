`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2020 18:56:15
// Design Name: 
// Module Name: Increment
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


module Increment(
    input CLK100MHZ, BTNC, BTNR,
  	output reg [3:0] minutes
	);
  
  
  always @ (posedge CLK100MHZ)
    begin
      if (BTNC == 1'b1) minutes <=0;	// if reset is high, reset the count
      else if (BTNR == 1'b1) minutes <= minutes+1;
    end
endmodule
