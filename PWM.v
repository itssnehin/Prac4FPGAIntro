`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:30 05/30/2017 
// Design Name: 
// Module Name:    PWM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PWM(
    input clk,			//input clock
    input [7:0] pwm_in, 
    output reg pwm_out 	//output of PWM	
);
reg [7:0] counter = 0;	
always @(posedge clk) begin
    counter <= counter + 1;
    pwm_out <= (counter < pwm_in);	
end
	
endmodule
