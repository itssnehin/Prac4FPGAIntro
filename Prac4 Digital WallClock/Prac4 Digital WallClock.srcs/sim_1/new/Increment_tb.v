`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2020 11:33:39
// Design Name: 
// Module Name: Increment_tb
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


module Increment_tb();
    // inputs
	reg CLK100MHZ;
    reg ButtonReset;                //ButtonReset;      // Reset button
    reg ButtonMins;                 //ButtonMins;       // button to increment minutes
    reg ButtonHours;                //ButtonHours;      // button to increment hours
    
	// outputs
	// to be used by buttons that increment minutes and hours
	wire [3:0] minutesUnits;
	wire [3:0] minutesTens;
	wire [3:0] hoursUnits;
	wire [3:0] hoursTens;
	
	// registers to store buttons previous state
    reg ButtonMins_DB_prev;         // unpressed button is high
    reg ButtonHours_DB_prev;         // unpressed button is high

	// instantiate
	Increment uut (
		.CLK100MHZ(CLK100MHZ),
		.BTNC(ButtonReset),
		.BTNR(ButtonMins),
		.BTNL(ButtonHours),
		.minutesUnits(minutesUnits),
		.minutesTens(minutesTens),
		.hoursUnits(hoursUnits),
		.hoursTens(hoursTens)
	   );
	
	
	initial begin
	   CLK100MHZ = 0;
	   ButtonReset = 1'd0;
	   ButtonMins = 1'd1;
	   ButtonHours = 1'd1;
       ButtonMins_DB_prev = 1'd1;         // unpressed button is high
       ButtonHours_DB_prev = 1'd1;         // unpressed button is high
	   
	   //#100e6 ButtonReset = 1'd0;
	   #100e6 ButtonMins = 1'd0;   //100ms
	   #20e6 ButtonMins  = 1'd1; 
	   #30e6 ButtonMins  = 1'd0;
	   #50e6 ButtonMins  = 1'd1;
	         ButtonHours = 1'd0;
	   #20e6 ButtonHours  = 1'd1;
	   #30e6 ButtonHours  = 1'd0;
	   #50e6 ButtonHours  = 1'd1;
	   #50e6;
	   
	   $finish;
	end
	

	always begin
        #10 CLK100MHZ = ~CLK100MHZ;  // toggle clock every 10ns
    end




endmodule
