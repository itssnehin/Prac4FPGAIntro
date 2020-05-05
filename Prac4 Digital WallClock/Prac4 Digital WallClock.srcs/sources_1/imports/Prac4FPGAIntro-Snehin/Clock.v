`timescale 1ns / 1ps

module WallClock(CLK100MHZ, BTNC, BTNR, BTNL, seconds, minutes, hours);
	//inputs - these will depend on your board's constraint files
    input CLK100MHZ;                                    // System clock        
    input BTNC;                 //ButtonReset;          // Reset button
    input BTNR;                 //ButtonMins;           // button to increment minutes 
    input BTNL;                 //ButtonHours;          // button to increment hours
    
	//outputs - these will depend on your board's constraint files
	output [5:0] seconds;
	output [5:0] minutes;
	output [4:0] hours;
//-------------------------------------------------------------------------------------------------------------------------
	
	// registers for storing the time
	/*
	reg [5:0] seconds_reg;
	reg [5:0] minutes_reg;
    reg [4:0] hours_reg;
	*/
	//reg [29:0] Count      = 30'b0;
	reg [5:0] seconds      = 6'd0;
	reg [3:0] minutesUnits = 4'd0;
	reg [3:0] minutesTens  = 4'd0;
	reg [3:0] hoursUnits   = 4'd0;
	reg [3:0] hoursTens    = 4'd0;
	
	// define wires to carry the input signals
	wire Clock_Sys;
	wire ButtonReset;
	wire ButtonMins;
	wire ButtonHours;
	
	// define local wires to carry the debounced pushbutton signals
	wire ButtonReset_DB;
	wire ButtonMins_DB;
	wire ButtonHours_DB;
	
	// assign the inputs above to the naming convention used in the constraints file
	assign{CLK100MHZ} = Clock_Sys;
	assign{BTNC} = ButtonReset;
	assign{BTNR} = ButtonMins;
	assign{BTNL} = ButtonHours;
	
	// registers to store buttons previous state
    reg ButtonMins_DB_prev = 1'd1;         // unpressed button is high
    reg ButtonHours_DB_prev = 1'd1;         // unpressed button is high
	
	// instantiate Delay_Reset module using BTNC
	Delay_Reset    Delay_Reset1(
	               .clk(Clock_Sys), 
	               .BTNS(ButtonReset),     // input reset signal (external button - using BTNC)
	               .Reset(ButtonReset_DB)
	               );
	               
	// Instantiate Debounce modules here
	//debounce the buttons
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






 
    
	//Initialize seven segment
	// You will need to change some signals depending on you constraints
	// SS_Driver SS_Driver1(
	// 	<clock_signal>, <reset_signal>,
	//	4'd1, 4'd2, 4'd3, 4'd4, // Use temporary test values before adding hours2, hours1, mins2, mins1
	//	SegmentDrivers, SevenSegment
	//);
	
	//The main logic
	always @ (posedge (Clock_Sys) or posedge (ButtonReset)) begin
		if (ButtonReset == 1'b1) begin // if reset btn pressed
			seconds_reg <= 6'd0;
			minutes_reg <= 6'd0;
			hours_reg <= 5'd0;
		end
		
		else if (Clock_Sys == 1'b1) begin 
			seconds_reg <= seconds + 6'd1; // increment seconds
			if (seconds_reg == 6'd60) begin
				seconds_reg <= 6'd0; // new mins
				minutes_reg <= minutes_reg + 6'd1;
				
				if (minutes == 6'd60) begin // new hour
					minutes_reg <= 6'd0;
					hours_reg <= hours + 5'd1;
					
					if (hours == 5'd24) begin // new day
						hours_reg <= 5'd0;
					end
				end
			end
		end
	end
	
	assign seconds = seconds_reg;
	assign minutes = minutes_reg;
	assign hours = hours_reg;	
endmodule  
