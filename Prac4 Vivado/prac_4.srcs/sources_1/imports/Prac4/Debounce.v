module Debounce(
    input clk, 
    input button,
    output reg DB_out 
);

reg previous_state = 1;     // give the previous_state an initial value of 1 meaning not pressed
reg [21:0]Count;            //assume count is null on FPGA configuration

/*  The deadtime is related to size of the counter and the clock frequency by
    deadtime = (2^N  +2)/f_clk      approximated to     deadtime = (2^N)/f_clk
    
    where N is the number of bits in the counter register
    
    the 22 bit counter register above produces a deadtime of 41,94 ms when f_clk = 100 MHz
*/

//--------------------------------------------
always @(posedge clk)
begin 
    // implement your logic here
    
    if(button == previous_state) // button has not been pressed
        DB_out = button;
    
    else                        // button has been pressed
        DB_out = ~button;       // change the state of the output
        Count <= 0;             // reset count
        Count <= (Count >= 4194303)? 0:Count+1;     // the highest value that can be represented by the 22 bit Count is 4194303 (Highest val = (2^N) -1)
                                                    // functions similar to if else block
    previous_state = button;    // update the previous_state variable
end 


endmodule

