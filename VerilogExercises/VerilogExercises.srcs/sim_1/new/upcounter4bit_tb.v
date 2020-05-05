`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2020 15:20:05
// Design Name: 
// Module Name: upcounter4bit_tb
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

// testbench for 4-bit up counter

module counter_tb();
  //inputs
  reg clk, reset, enable;
  //outputs
  wire [3:0] count;
  
  //instantiate DUT (design under test)
  counter mycounter(
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .count(count)
  	);
  
initial begin
  // $dumpfile("dump.vcd" $dumpvars(1););	// for plotting
  
  //display column headings 
  $display("\t\t\ttime, \tclk, \treset, \tenable, \tcount");	// \t means tab
  
  // setup a monitor routine for pins of interest
  $monitor("\t%d, \t%b, \t%b, \t%b, \t%d", $time, clk, reset, enable, count);
  
  clk=0; reset=0; enable=0;	//initial values
  #5 clk = ~clk;	//toggle clock low to high
  
  reset=1;				//reset counter
  #5 clk = ~clk;		//toggle clock high to low
  reset=0; enable=1;	//put reset low and enable counter
  
  repeat(40)
    begin
      #5 clk = ~clk;	//toggle clock every 5 time units
    end
  
end
endmodule
