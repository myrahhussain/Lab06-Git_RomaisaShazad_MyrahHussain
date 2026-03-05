module fsm_counter (
    input clk, rst, input [15:0] sw_val, output reg [15:0] count_reg
);
    // Simple register logic that triggers on the clock or reset
    always @(posedge clk or posedge rst) begin
        if (rst) 
            count_reg <= 16'b0; // Reset the output register to zero
        else 
            count_reg <= sw_val; // Pass the ALU result through to the next stage
    end
endmodule