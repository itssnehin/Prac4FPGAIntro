`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2020 17:03:32
// Design Name: 
// Module Name: buttonCounter_tb
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


module buttonCounter_tb();
//inputs
  reg clk, reset, button;
  //outputs
  wire [3:0] count;
  
  //instantiate DUT (design under test)
  buttonCounter uut(
    .clk(clk),
    .reset(reset),
    .button(button),
    .count(count)
  	);
  
initial begin
  // $dumpfile("dump.vcd" $dumpvars(1););	// for plotting
  
  //display column headings 
  $display("\t\t\t\ttime, \tclk, \treset, \tbutton, \tcount");	// \t means tab
  
  // setup a monitor routine for pins of interest
  $monitor("\t%d, \t%b, \t%b, \t%b, \t%d", $time, clk, reset, button, count);
  
  clk=0; reset=0; button=0;	//initial values
  #5 clk = ~clk;	//toggle clock low to high
  
  reset=1;				//reset counter
  #5 clk = ~clk;		//toggle clock high to low
  reset=0; button=1;	//put reset low and enable counter
  
  repeat(40)
    begin
      #5 clk = ~clk;	//toggle clock every 5 time units
    end
  
end
endmodule
