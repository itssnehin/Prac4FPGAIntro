`timescale 1ns / 1ps

module tb_WallClock(
    input CLK100MHZ
    // input segment display later and btns
    );
	// inputs
	reg Clock_1s = 0;
	reg reset = 0;
	// outputs
	wire [5:0] seconds = 0;
	wire [5:0] minutes = 0;
	wire [4:0] hours = 0;
	
	reg [26:0] counter = 0; // counter for clock
	// instantiate
	WallClock uut (
		.Clock_1s(Clock_1s),
		.reset(reset),
		.seconds(seconds),
		.minutes(minutes),
		.hours(hours)
	);
	
	
	initial Clock_1s = 0;
	initial counter = 0;
	//always #50000000 Clock_1s = ~Clock_1s; // toggle clock every 0.5 seconds
	
	always @ (posedge CLK100MHZ) begin
	   counter = counter + 1;
	   
	   if(counter == 50000000) begin
	       Clock_1s = ~Clock_1s;
	       counter = 0;
	   end
	end
	
	initial begin
		reset = 1;
		#100
		reset = 0;
	end

endmodule