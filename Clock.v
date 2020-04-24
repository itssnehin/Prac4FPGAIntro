
module WallClock(Clock_1s, reset, seconds, minutes, hours);
	//inputs - these will depend on your board's constraint files
    input wire Clock_1s;
    input wire reset;
	//outputs - these will depend on your board's constraint files
	output reg [5:0] seconds;
	output reg [5:0] minutes;
	output reg [4:0] hours;

	//Add and debounce the buttons
	//wire MButton;
	//wire HButton;
	
	// Instantiate Debounce modules here
	
	// registers for storing the time
	//reg [5:0] seconds;
	//reg [5:0] minutes;
	//reg [4:0] hours;
	
    
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
			seconds = 0;
			minutes = 0;
			hours = 0;
		end
		
		else if (Clock_1s == 1'b1) begin 
			seconds = seconds + 1; // increment seconds
			if (seconds == 60) begin
				seconds = 0; // new mins
				minutes = minutes + 1;
				
				if (minutes == 60) begin // new hour
					minutes = 0;
					hours = hours + 1;
					
					if (hours == 24) begin // new day
						hours = 0;
					end
				end
			end
		end
	end	
endmodule  
