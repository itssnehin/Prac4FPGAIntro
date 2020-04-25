`timescale 1ns / 1ps

module WallClock(Clock_1s, reset, seconds, minutes, hours);
	//inputs - these will depend on your board's constraint files
    input Clock_1s;
    input reset;
	//outputs - these will depend on your board's constraint files
	output [5:0] seconds;
	output [5:0] minutes;
	output [4:0] hours;

	//Add and debounce the buttons
	//wire MButton;
	//wire HButton;
	
	// Instantiate Debounce modules here
	
	// registers for storing the time
	reg [5:0] seconds_reg;
	reg [5:0] minutes_reg;
    reg [4:0] hours_reg;
	
    
	//Initialize seven segment
	// You will need to change some signals depending on you constraints
	// SS_Driver SS_Driver1(
	// 	<clock_signal>, <reset_signal>,
	//	4'd1, 4'd2, 4'd3, 4'd4, // Use temporary test values before adding hours2, hours1, mins2, mins1
	//	SegmentDrivers, SevenSegment
	//);
	
	//The main logic
	always @ (posedge (Clock_1s) or posedge (reset)) begin
		if (reset == 1'b1) begin // if reset btn pressed
			seconds_reg <= 6'd0;
			minutes_reg <= 6'd0;
			hours_reg <= 5'd0;
		end
		
		else if (Clock_1s == 1'b1) begin 
			seconds_reg <= seconds + 6'd1; // increment seconds
			if (seconds_reg == 6'd60) begin
				seconds_reg <= 6'd0; // new mins
				minutes_reg <= minutes_reg + 6'd1;
				
				if (minutes == 6'd60) begin // new hour
					minutes_reg <= 6'd0;
					hours_reg <= hours + 5'd1;
					
					if (hours == 5'd24) begin // new day
						hours_reg <= 5'd0;
					end
				end
			end
		end
	end
	
	assign seconds = seconds_reg;
	assign minutes = minutes_reg;
	assign hours = hours_reg;	
endmodule  
