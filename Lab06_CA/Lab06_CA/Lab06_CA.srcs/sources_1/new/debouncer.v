module debouncer #(parameter THRESHOLD = 17'd100_000)(
    input clk, pbin, output reg pbout = 0
);
    // 17-bit counter to track how long the input has been stable
    reg [16:0] count = 0;

    always @(posedge clk) begin
        // If the input matches our current output, reset the timer
        if (pbin == pbout) count <= 0;
        else begin
            // Input changed, start counting to see if it stays stable
            count <= count + 1;
            
            // If the counter hits the threshold, we trust the new value
            if (count == THRESHOLD) pbout <= pbin;
        end
    end
endmodule