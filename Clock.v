`timescale 1ns / 1ps



module Clock(
	//inputs - these will depend on your board's constraint files
    input CLK100MHZ, 
     input BTNR,
     input BTNL,
     input BTNC,
	//outputs - these will depend on your board's constraint files
	   output [3:0] AN,
	   output [6:0] SEG,
	   output reg[5:0]LED
);

	//Add the reset
    wire reset;

	//Add and debounce the buttons
	wire MButton;
	wire HButton;
	
	// Instantiate Debounce modules here
	
	// registers for storing the time
	reg[29:0]count = 30'b0;
    reg [5:0] secs = 6'b0;
    reg [3:0]hours1=4'd0;
	reg [3:0]hours2=4'd0;
	reg [3:0]mins1=4'd0;
	reg [3:0]mins2=4'd0;
	wire [3:0] segment;
    wire [7:0] driver;
    
    parameter speed = 100000000;
    
    //Delay
    Delay_Reset dr1(CLK100MHZ,BTNR,reset);  
    Debounce dMins(CLK100MHZ,BTNL, MButton);
    Debounce dHours(CLK100MHZ, BTNC, HButton);  
	//Initialize seven segment
	// You will need to change some signals depending on you constraints
	SS_Driver SS_Driver1(
		CLK100MHZ, reset,
		hours2, hours1, mins2, mins1, // Use temporary test values before adding hours2, hours1, mins2, mins1
		AN, SEG
	);
	
	//minutes button
	
	
	//The main logic
	always @(posedge CLK100MHZ) begin
		count <= count + 1'b1;
		if(count == speed)begin
		  count <= 0;
		  secs <= secs + 1'b1;
		end
		
		//increase mins
		if(secs == 6'b111111) begin
		  mins1 <= mins1 +1'b1;
		  secs <= 0;
		  
		  if(mins1 == 4'd9)begin 
		      mins2 <= mins2 + 1'b1;
		      mins1 <= 0;
		      
		      if(mins2 == 4'd5)begin 
		          hours1 <= hours1 + 1'b1;
		          mins2 <=0;
		          
		          if(hours1 == 4'd9)begin
		              hours2 <= hours2 +1'b1;
		              hours1<=0;
		          end
		          if(hours2 == 4'd2 && hours1 == 4'd3) begin 
		              hours2<=0;
		              hours1<=0;
		          end
		      end
		  end
		  
		end
		
		if(MButton)begin
	         mins1 <= mins1 +1'b1;
	         secs <= 0;
	         if(mins1 == 4'd9)begin 
		      mins2 <= mins2 + 1'b1;
		      mins1 <= 0;
		      
		        if(mins2 == 4'd5)begin 
		              hours1 <= hours1 + 1'b1;
		              mins2 <=0;
		        end
		    end
	   end
	   
	   //hours pressed
	   if(HButton) begin
	    hours1 <= hours1 + 1'd1;
	    secs <= 0;
	    if(hours1 == 4'd9)begin
		              hours2 <= hours2 +1'b1;
		              hours1<=0;
		 end
		 if(hours2 == 4'd2 && hours1 == 4'd3) begin 
		              hours2<=0;
		              hours1<=0;
		  end 
	   end
	   
	   //reset pressed
	   if(reset)begin
	       secs <= 0;
	       hours1 <= 0;
	       hours2 <= 0;
	       mins1 <= 0;
	       mins2 <= 0;
	   end
		LED[0] <= secs[0];
        LED[1] <= secs[1];
        LED[2] <= secs[2];
        LED[3] <= secs[3];
        LED[4] <= secs[4];
        LED[5] <= secs[5];
       
	end
endmodule  
