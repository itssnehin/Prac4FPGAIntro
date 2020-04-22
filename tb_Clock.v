module tb_WallClock;
	// inputs
	reg Clock_1s;
	reg reset;
	
	// outputs
	wire [5:0] seconds;
	wire [5:0] minutes;
	wire [4:0] hours;
	
	// instantiate
	WallClock uut (
		.Clock_1s(Clock_1s),
		.reset(reset),
		.seconds(seconds),
		.minutes(minutes),
		.hours(hours)
	);
	
	
	initial Clock_1s = 0;
	always #50000000 Clock_1s = ~Clock_1s; // toggle clock every 0.5 seconds
	
	initial begin
		reset = 1;
		#100
		reset = 0;
	end

end module