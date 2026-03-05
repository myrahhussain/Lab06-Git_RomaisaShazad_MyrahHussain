module leds(
    input clk,
    input rst,
    input [15:0] writeData,
    input writeEnable,
    output reg [15:0] leds
);
    // Trigger on the clock or when the reset button is pushed
    always @(posedge clk or posedge rst) begin
        if (rst) 
            leds <= 16'b0; // Turn off all LEDs on reset
        else if (writeEnable) 
            leds <= writeData; // Update the LEDs with new data when enabled
    end
endmodule