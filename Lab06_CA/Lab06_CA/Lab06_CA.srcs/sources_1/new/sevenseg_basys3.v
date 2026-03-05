module sevenseg_basys3 (
    input clk,
    input [15:0] value,
    output reg [6:0] seg,
    output reg [3:0] an
);
    // Counter to control the refresh rate of the display
    reg [17:0] refresh;
    always @(posedge clk) refresh <= refresh + 1;

    reg [3:0] digit;
    // Multiplexing logic: use the top bits of the counter to switch digits
    always @(*) begin
        case(refresh[17:16])
            // Activate rightmost digit and calculate 'ones' place
            2'b00: begin digit = value % 10; an = 4'b1110; end
            // Activate second digit and calculate 'tens' place
            2'b01: begin digit = (value / 10) % 10; an = 4'b1101; end
            // Activate third digit and calculate 'hundreds' place
            2'b10: begin digit = (value / 100) % 10; an = 4'b1011; end
            // Activate leftmost digit and calculate 'thousands' place
            2'b11: begin digit = (value / 1000) % 10; an = 4'b0111; end
        endcase
    end

    // Decoder to turn the decimal number into the 7-segment pattern
    always @(*) begin
        case(digit)
            0: seg=7'b1000000; 1: seg=7'b1111001; 2: seg=7'b0100100;
            3: seg=7'b0110000; 4: seg=7'b0011001; 5: seg=7'b0010010;
            6: seg=7'b0000010; 7: seg=7'b1111000; 8: seg=7'b0000000;
            9: seg=7'b0010000; 
            default: seg=7'b1111111; // Turn off segments if unknown
        endcase
    end
endmodule