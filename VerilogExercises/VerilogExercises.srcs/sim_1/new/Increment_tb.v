`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2020 18:57:08
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
  //inputs
  reg clk, buttonReset, buttonMins;
  //outputs
  wire [3:0] minutes;
  
  //instantiate DUT (design under test)
  Increment uut(
    .CLK100MHZ(clk),
    .BTNC(buttonReset),
    .BTNR(buttonMins),
    .minutes(minutes)
  	);
  
initial begin
  // $dumpfile("dump.vcd" $dumpvars(1););	// for plotting
  
  //display column headings 
  $display("\t\t\t\ttime, \tclk, \treset, \tbutton, \tcount");	// \t means tab
  
  // setup a monitor routine for pins of interest
  $monitor("\t%d, \t%b, \t%b, \t%b, \t%d", $time, clk, buttonReset, buttonMins, minutes);
  
  clk=0; buttonReset=0; buttonMins=0;	//initial values
  #5 clk = ~clk;	//toggle clock low to high
  
  buttonReset=1;				//reset counter
  #5 clk = ~clk;		//toggle clock high to low
  buttonReset=0; buttonMins=1;	//put reset low and enable counter
  
  repeat(40)
    begin
      #5 clk = ~clk;	//toggle clock every 5 time units
    end
  
end
endmodule
