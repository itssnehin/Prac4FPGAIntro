`timescale 1ns / 1ps

module WallClock(Clock_1s, CLK100MHZ, BTNC, BTNR, BTNL, seconds, minutes, hours, secondsTensUnits, minutesUnits, minutesTens, hoursUnits, hoursTens);
	//inputs - these will depend on your board's constraint files
	input Clock_1s;                                     // Slowed down clock (period = 1sec)
    input CLK100MHZ;                                    // System clock (period = 10ns)      
    input BTNC;                 //ButtonReset;          // Reset button
    input BTNR;                 //ButtonMins;           // button to increment minutes 
    input BTNL;                 //ButtonHours;          // button to increment hours
    
	//outputs - these will depend on your board's constraint files
	output [5:0] seconds;
	output [5:0] minutes;
	output [4:0] hours;
	
	output [5:0] secondsTensUnits;
	output [3:0] minutesUnits;
	output [3:0] minutesTens;
	output [3:0] hoursUnits;
	output [3:0] hoursTens;
//-------------------------------------------------------------------------------------------------------------------------
	
	// registers for storing the time
	// to be used by main logic
	reg [5:0] seconds_reg      = 6'd0;
	reg [5:0] minutes_reg      = 6'd0;
    reg [4:0] hours_reg        = 5'd0;
    
	// to be used by buttons that increment minutes and hours
	reg [5:0] secondsTensUnits = 6'd0;
	reg [3:0] minutesUnits     = 4'd0;
	reg [3:0] minutesTens      = 4'd0;
	reg [3:0] hoursUnits       = 4'd0;
	reg [3:0] hoursTens        = 4'd0;
	
	// define local wires to carry the input signals
	wire Clock_Sys;
	wire ButtonReset;
	wire ButtonMins;
	wire ButtonHours;
	
	// define local wires to carry the debounced pushbutton signals
	wire ButtonReset_DB;
	wire ButtonMins_DB;
	wire ButtonHours_DB;
	
	// assign the inputs above to local wires (using the naming convention used in the constraints file)
	assign{CLK100MHZ}  = Clock_Sys;
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
	               .Clk(Clock_Sys), 
	               .BTNS(ButtonReset),     // input reset signal (external button - using BTNC = ButtonReset)
	               .Reset(ButtonReset_DB)
	               );
	               
	// Instantiate Debounce modules here (debounce the buttons)
	Debounce       Debounce_Mins(
	               .clk(Clock_Sys),
	               .button_reset(ButtonReset),
	               .button_in(ButtonMins),
	               .DB_out(ButtonMins_DB)
	               );
	               
	Debounce       Debounce_Hours(
	               .clk(Clock_Sys),
	               .button_reset(ButtonReset),
	               .button_in(ButtonHours),
	               .DB_out(ButtonHours_DB)
	               );
	 
//------------------------------------------------------------------------------------------------------------------	
// Logic for task 3 - button that increments minutes

always @ (posedge Clock_Sys)
begin
    // when button is pressed (i.e. button signal goes through a FALLING edge)
    if((ButtonMins_DB_prev == 1'd1) && (ButtonMins_DB == 1'd0)) begin
        
        // Wrap around: if time reaches 59 minutes, reset minutesTens and minutesUnits to 0
        if(minutesTens == 4'd5 && minutesUnits == 4'd9) begin
            minutesTens <= 4'd0;
            minutesUnits <= 4'd0;
        end
        
        // if time reaches 9 minutes, increment minutesTens then reset minutesUnits to 0
        if(minutesUnits == 4'd9) begin
            minutesTens <= minutesTens + 1'd1;
        end
        
        // else just increment minutesUnits each time button is pressed 
        else 
            minutesUnits <= minutesUnits + 1'd1;
        
        ButtonMins_DB_prev = ~ButtonMins_DB_prev;       // update the buttons state
    end
    
    // when button is released (i.e. button signal goes through a RISING edge)
    else begin
        ButtonMins_DB_prev = ~ButtonMins_DB_prev;       // update the buttons state
    end

end

//------------------------------------------------------------------------------------------------------------------	
// Logic for task 4 - button that increments hours

always @ (posedge Clock_Sys)
begin
    // when button is pressed (i.e. button signal goes through a FALLING edge)
    if((ButtonHours_DB_prev == 1'd1) && (ButtonHours_DB == 1'd0)) begin
        
        // Wrap around: if time reaches 23 hours, reset hoursTens and hoursUnits to 0
        if(hoursTens == 4'd2 && hoursUnits == 4'd3) begin
            hoursTens <= 4'd0;
            hoursUnits <= 4'd0;
        end
        
        // if time reaches 9 hours, increment hoursTens then reset hoursUnits to 0
        if(hoursUnits == 4'd9) begin
            hoursTens <= hoursTens + 1'd1;
        end
        
        // else just increment hoursUnits each time button is pressed 
        else 
            hoursUnits <= hoursUnits + 1'd1;
        
        ButtonHours_DB_prev = ~ButtonHours_DB_prev;       // update the buttons state
    end
    
    // when button is released (i.e. button signal goes through a RISING edge)
    else begin
        ButtonHours_DB_prev = ~ButtonHours_DB_prev;       // update the buttons state
    end

end

//------------------------------------------------------------------------------------------------------------------	

// Task 1 - Digital clock    
	
	//The main logic
	always @ (posedge (Clock_1s) or posedge (ButtonReset)) begin
		if (ButtonReset == 1'b1) begin                    // if reset btn pressed, reset time registers to 0
			seconds_reg <= 6'd0;
			minutes_reg <= 6'd0;
			hours_reg <= 5'd0;
		end
		
		else if (Clock_1s == 1'b1) begin                // on clock RISING edge
			seconds_reg <= seconds + 6'd1;               // increment seconds
			if (seconds_reg == 6'd60) begin              // if seconds overflows (new minute)
				seconds_reg <= 6'd0;                     // reset seconds
				minutes_reg <= minutes_reg + 6'd1;       // increment minutes
				
				if (minutes_reg == 6'd60) begin          // if minutes overflows (new hour)
					minutes_reg <= 6'd0;                 // reset minutes
					hours_reg <= hours + 5'd1;           // increment hours
					
					if (hours_reg == 5'd24) begin        // if hours overflows (new day)
						hours_reg <= 5'd0;               // reset hours
					end
				end
			end
		end
	end
	
	// assign time register values to outputs
	assign seconds = seconds_reg;
	assign minutes = minutes_reg;
	assign hours   = hours_reg;	
endmodule  
