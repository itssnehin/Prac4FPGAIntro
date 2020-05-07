`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2020 11:16:56
// Design Name: 
// Module Name: Increment
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


module Increment(CLK100MHZ, BTNC, BTNR, BTNL, minutesUnits, minutesTens, hoursUnits, hoursTens);
    //inputs - these will depend on your board's constraint files
    input CLK100MHZ;                                    // System clock (period = 10ns)      
    input BTNC;                 //ButtonReset;          // Reset button
    input BTNR;                 //ButtonMins;           // button to increment minutes 
    input BTNL;                 //ButtonHours;          // button to increment hours
    
	//outputs - these will depend on your board's constraint files
	output [3:0] minutesUnits;
	output [3:0] minutesTens;
	output [3:0] hoursUnits;
	output [3:0] hoursTens;
//-------------------------------------------------------------------------------------------------------------------------

    // registers to be used by buttons that increment minutes and hours
	reg [3:0] minutesUnits_reg     = 4'd0;
	reg [3:0] minutesTens_reg      = 4'd0;
	reg [3:0] hoursUnits_reg       = 4'd0;
	reg [3:0] hoursTens_reg        = 4'd0;
    
    
    // define local wires to carry the input signals
	wire CLK100MHZ;
	wire ButtonReset;
	wire ButtonMins;
	wire ButtonHours;
	
	// define local wires to carry the debounced pushbutton signals
	wire ButtonReset_DB;
	wire ButtonMins_DB;
	wire ButtonHours_DB;
    
    // assign the inputs above to local wires (using the naming convention used in the constraints file)
	assign{CLK100MHZ}  = CLK100MHZ;
	assign{BTNC}       = ButtonReset;
    assign{BTNR}       = ButtonMins;
	assign{BTNL}       = ButtonHours;
	
	// registers to store buttons previous state
    reg ButtonMins_DB_prev = 1'd1;         // unpressed button is high
    reg ButtonHours_DB_prev = 1'd1;         // unpressed button is high

    //Initialize seven segment
	// You will need to change some signals depending on you constraints
	// SS_Driver SS_Driver1(
	// 	<clock_signal>, <reset_signal>,
	//	4'd1, 4'd2, 4'd3, 4'd4, // Use temporary test values before adding hours2, hours1, mins2, mins1
	//	SegmentDrivers, SevenSegment
	//);

//------------------------------------------------------------------------------------------------------------------
    
    // instantiate Delay_Reset module using BTNC
	Delay_Reset    Delay_Reset1(
	               .Clk(CLK100MHZ), 
	               .BTNS(ButtonReset),     // input reset signal (external button - using BTNC = ButtonReset)
	               .Reset(ButtonReset_DB)
	               );
	               
	// Instantiate Debounce modules here (debounce the buttons)
	Debounce       Debounce_Mins(
	               .clk(CLK100MHZ),
	               .button_reset(ButtonReset),
	               .button_in(ButtonMins),
	               .DB_out(ButtonMins_DB)
	               );
	               
	Debounce       Debounce_Hours(
	               .clk(CLK100MHZ),
	               .button_reset(ButtonReset),
	               .button_in(ButtonHours),
	               .DB_out(ButtonHours_DB)
	               );
	 
//------------------------------------------------------------------------------------------------------------------	
// Logic for task 3 - button that increments minutes

    always @ (posedge CLK100MHZ)
    begin
        // when button is pressed (i.e. button signal goes through a FALLING edge)
        if((ButtonMins_DB_prev == 1'd1) && (ButtonMins_DB == 1'd0))
        begin
            // Wrap around: if time reaches 59 minutes, reset minutesTens and minutesUnits to 0
            if(minutesTens_reg == 4'd5 && minutesUnits_reg == 4'd9) begin
                minutesTens_reg <= 4'd0;
                minutesUnits_reg <= 4'd0;
            end
            
            // if time reaches 9 minutes, increment minutesTens then reset minutesUnits to 0
            if(minutesUnits_reg == 4'd9) begin
                minutesTens_reg <= minutesTens_reg + 1'd1;
            end
            
            // else just increment minutesUnits each time button is pressed 
            else begin
                minutesUnits_reg <= minutesUnits_reg + 1'd1;
            end
            
            ButtonMins_DB_prev = ~ButtonMins_DB_prev;       // update the buttons state
        end
        
        // when button is released (i.e. button signal goes through a RISING edge)
        else begin
            ButtonMins_DB_prev = ~ButtonMins_DB_prev;       // update the buttons state
        end
    
    end
    
    //------------------------------------------------------------------------------------------------------------------	
    // Logic for task 4 - button that increments hours
    
    always @ (posedge CLK100MHZ)
    begin
        // when button is pressed (i.e. button signal goes through a FALLING edge)
        if((ButtonHours_DB_prev == 1'd1) && (ButtonHours_DB == 1'd0)) begin
            
            // Wrap around: if time reaches 23 hours, reset hoursTens and hoursUnits to 0
            if(hoursTens_reg == 4'd2 && hoursUnits_reg == 4'd3) begin
                hoursTens_reg <= 4'd0;
                hoursUnits_reg <= 4'd0;
            end
            
            // if time reaches 9 hours, increment hoursTens then reset hoursUnits to 0
            if(hoursUnits_reg == 4'd9) begin
                hoursTens_reg <= hoursTens_reg + 1'd1;
            end
            
            // else just increment hoursUnits each time button is pressed 
            else begin
                hoursUnits_reg <= hoursUnits_reg + 1'd1;
            end
            
            ButtonHours_DB_prev = ~ButtonHours_DB_prev;       // update the buttons state
        end
        
        // when button is released (i.e. button signal goes through a RISING edge)
        else begin
            ButtonHours_DB_prev = ~ButtonHours_DB_prev;       // update the buttons state
        end
    
    end
    
//---------------------------------------------------------------------------------------------------------------------------------------------    
    // assign time register values to outputs
    assign minutesUnits = minutesUnits_reg;
    assign minutesTens = minutesTens_reg;
    assign hoursUnits = hoursUnits_reg;
    assign hoursUnits = hoursUnits_reg;
    
endmodule
