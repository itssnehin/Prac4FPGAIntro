`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2020 20:35:30
// Design Name: 
// Module Name: ButtonIncrement_tb
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


module ButtonIncrement_tb();
// inputs
	reg CLK100MHZ;
	//reg CLK1HZ;                                         // equivalent to Clock_1s in Clock.v
    reg ButtonReset;                //ButtonReset;      // Reset button
    reg ButtonMins;                 //ButtonMins;       // button to increment minutes
    reg ButtonHours;                //ButtonHours;      // button to increment hours
    
	// outputs
	//wire [5:0] seconds;
	//wire [5:0] minutes;
	//wire [4:0] hours;
	
	// to be used by buttons that increment minutes and hours
	wire [5:0] secondsTensUnits;
	wire [3:0] minutesUnits;
	wire [3:0] minutesTens;
	wire [3:0] hoursUnits;
	wire [3:0] hoursTens;
	

	// instantiate
	WallClock uut (
		//.Clock_1s(CLK1HZ),
		.CLK100MHZ(CLK100MHZ),
		.BTNC(ButtonReset),
		.BTNR(ButtonMins),
		.BTNL(ButtonHours)
		//.seconds(seconds),
		//.minutes(minutes),
		//.hours(hours)
	);
	
	
	initial begin
	   //CLK1HZ = 0;
	   CLK100MHZ = 0;
	   //ButtonReset = 1'd1;
	   ButtonMins = 1'd1;
	   ButtonHours = 1'd1;
	   
	   #100e6 ButtonMins = 1'd0;   //100ms
	   #20e6 ButtonMins  = 1'd1; 
	   #30e6 ButtonMins  = 1'd0;
	   #50e6 ButtonMins  = 1'd1;
	         ButtonHours = 1'd0;
	   #20e6 ButtonHours  = 1'd1;
	   #30e6 ButtonHours  = 1'd0;
	   #50e6 ButtonHours  = 1'd1;
	   
	   $finish;
	end
	

	always begin
        #10 CLK100MHZ = ~CLK100MHZ;  // toggle clock every 10ns
    end







endmodule
