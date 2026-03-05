module switches(
    input clk, rst, input [31:0] writeData, input writeEnable, output reg [15:0] leds
);
    // Trigger on the clock edge or the reset button
    always @(posedge clk or posedge rst) begin
        if (rst) 
            leds <= 16'b0; // Clear the register to zero
        else if (writeEnable) 
            leds <= writeData[15:0]; // Capture the lower 16 bits of the data
    end
endmodule