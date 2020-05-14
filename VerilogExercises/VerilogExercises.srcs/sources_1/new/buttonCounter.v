`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2020 17:02:23
// Design Name: 
// Module Name: buttonCounter
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


module buttonCounter(
    input clk, reset, button,
  	output reg [3:0] count
	);
  
  always @ (posedge clk)
    begin
      if (reset == 1'b1) count<=0;	// if reset is high, reset the count
      else if (button == 1'b1) count <= count+1;
    end
endmodule
