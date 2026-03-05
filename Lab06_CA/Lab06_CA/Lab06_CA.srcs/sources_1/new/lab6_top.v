`timescale 1ns / 1ps

module lab6_top(
    input clk, rst_btn,
    input [15:0] sw_phys,     // physical switches on board
    output [15:0] led_phys,   // physical LEDs
    output [6:0] seg,         // 7-seg segments
    output [3:0] an           // 7-seg anodes
);
    // Hardcoded test values for A and B
    wire [31:0] opA = 32'h10101010;
    wire [31:0] opB = 32'h01010101;
    
    wire rst_db, z_f;
    wire [15:0] sw_sync, disp_v;
    wire [31:0] result_raw;

    // Clean the reset button signal
    debouncer db (.clk(clk), .pbin(rst_btn), .pbout(rst_db));
    
    // Pass physical switches into the system
    switches sw (.clk(clk), .rst(rst_db), .writeData({16'b0, sw_phys}), .writeEnable(1'b1), .leds(sw_sync));
    
    // ALU core: takes OpA and OpB, controlled by bottom 4 switches
    ALU alu_structural (.A(opA), .B(opB), .ALUControl(sw_sync[3:0]), .ALUResult(result_raw), .Zero(z_f));
    
    // Capture lower 16 bits of result for display
    fsm_counter fsm (.clk(clk), .rst(rst_db), .sw_val(result_raw[15:0]), .count_reg(disp_v));
    
    // Handle multiplexing for the 7-segment display
    sevenseg_basys3 ss (.clk(clk), .value(disp_v), .seg(seg), .an(an));

    // Map result to LEDs: LEDs 0-14 show data, LED 15 shows Zero flag
    assign led_phys[14:0] = result_raw[14:0];
    assign led_phys[15]   = z_f;
endmodule