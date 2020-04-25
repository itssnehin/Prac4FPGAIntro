module tb_WallClock(
    input CLK100MHZ
    // input segment display later and btns
    );
	// inputs
	reg CLK1HZ_reg;
	reg reset;
	// outputs
	wire [5:0] seconds;
	wire [5:0] minutes;
	wire [4:0] hours;
	
	reg [26:0] counter = 0; // counter for clock
	wire CLK1HZ;

	// instantiate
	WallClock uut (
		.Clock_1s(CLK1HZ),
		.reset(reset),
		.seconds(seconds),
		.minutes(minutes),
		.hours(hours)
	);
	
	initial counter = 27'd0;
	//always #50000000 Clock_1s = ~Clock_1s; // toggle clock every 0.5 seconds
	assign CLK1HZ = CLK1HZ_reg;
	
	 
	always @ (posedge CLK100MHZ) begin
	   counter <= counter + 27'd1;
	   
	   if(counter == 27'd500000) begin
	       CLK1HZ_reg <= ~CLK1HZ_reg;
	       counter <=27'd0;
	   end
	end
	
	initial CLK1HZ_reg = 0;
	initial begin
		reset <= 1;
		#100
		reset <= 0;
	end

endmodule