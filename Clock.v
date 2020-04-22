`timescale 1ns / 1ps



module WallClock(
	//inputs - these will depend on your board's constraint files
    input CLK100MHZ;
	input reset;
	//outputs - these will depend on your board's constraint files
	output [5:0] seconds;
	output [5:0] minutes;
	output [4:0] hours;
	
);

	//Add the reset
	wire reset;

	//Add and debounce the buttons
	wire MButton;
	wire HButton;
	
	// Instantiate Debounce modules here
	
	// registers for storing the time
    reg [3:0]hours1=4'd0;
	reg [3:0]hours2=4'd0;
	reg [3:0]mins1=4'd0;
	reg [3:0]mins1=4'd0;
    
	//Initialize seven segment
	// You will need to change some signals depending on you constraints
	SS_Driver SS_Driver1(
		<clock_signal>, <reset_signal>,
		4'd1, 4'd2, 4'd3, 4'd4, // Use temporary test values before adding hours2, hours1, mins2, mins1
		SegmentDrivers, SevenSegment
	);
	
	//The main logic
	reg [25:0] counter = 0;
	always @(posedge CLK100MHZ) begin
		// implement your logic here
		// define 1hz clock
		counter <= counter + 1;
		Clockl_1s = 0;
		if (counter = 49999999) begin // wait till half clock cycle
			Clockl_1s =~ Clockl_1s; // every 0.5 seconds, toggle the clock
			counter <= 0;
	end
	
	always @(posedge CLK100MHZ or posedge(reset)) begin
		if (reset = 1'b1) begin // check for reset button pressed
			// reset the time
			seconds <= 0;
			minutes <= 0;
			hours <= 0;
		end
		
		else if (Clock_1s == 1'b1) begin // at the begining of each clock cycle
			
			seconds = seconds + 1; //increment seconds
			
			if (seconds == 60) begin // increment minutes
				seconds <= 0;
				minutes <= minutes + 1;
				
				if (minutes == 60) begin // increment hours
					
					minutes <= 0;
					hours <= hours + 1;
					
					if (hours == 24) begin // reset hours if max
						hours <= 0;
					end
				end
			end
		end		
	end
	
endmodule  
