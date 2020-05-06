`timescale 1ns / 1ps            // set timescale and precision
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2020 17:20:47
// Design Name: 
// Module Name: Clock_tb
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


module tb_WallClock(
    //input CLK100MHZ
    // input segment display later and btns
    );
    
	// inputs
	reg CLK100MHZ;
	reg CLK1HZ;                                         // equivalent to Clock_1s in Clock.v
    reg ButtonReset;                //ButtonReset;      // Reset button
    reg ButtonMins;                 //ButtonMins;       // button to increment minutes
    reg ButtonHours;                //ButtonHours;      // button to increment hours
    
	// outputs
	wire [5:0] seconds;
	wire [5:0] minutes;
	wire [4:0] hours;
	
	// other
	reg [26:0] counter = 0;        // 26 bit counter for clock
	//wire CLK1HZ;

	// instantiate
	WallClock uut (
		.Clock_1s(CLK1HZ),
		.CLK100MHZ(CLK100MHZ),
		.BTNC(ButtonReset),
		.BTNR(ButtonMins),
		.BTNL(ButtonHours),
		.seconds(seconds),
		.minutes(minutes),
		.hours(hours)
	);
	
	initial begin
	   CLK1HZ = 0;
	   CLK100MHZ = 0;
	   counter = 27'd0;
	end
	
	//assign CLK1HZ = CLK1HZ_reg;
	
	initial begin
		ButtonReset <= 1;
		#100
		ButtonReset <= 0;
	end
	
/*
    since the CLK100MHZ clock has a period = 10ns, therefore a posedge occurs every 10ns
	we want a 1Hz clock (period = 1sec),
	but since a cycle consists of 1 rising edge and 1 falling edge, the clock needs to be toggled twice to form 1 cycle
	therefore 50e6 * 20ns = 1sec 
	therefore need 50e6 CLK100MHZ cycles to pass, use a delay that increments once every cycle and counts up to 50e6
*/

	// this creates a slower clock (period = 1sec) 
	always @ (posedge CLK100MHZ) begin
	   counter <= counter + 27'd1;
	   
	   if(counter == 27'd50000000) begin          // count up to 50e6
	       CLK1HZ <= ~CLK1HZ;
	       counter <= 27'd0;
	   end
	end
	
	always begin
        #10 CLK100MHZ = ~CLK100MHZ;  // toggle clock every 10ns
    end

endmodule