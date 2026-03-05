`timescale 1ns / 1ps

module ALU_tb;
    reg [31:0] a, b;
    reg [3:0] ctrl;
    wire [31:0] res;
    wire z; 

    ALU uut (.A(a), .B(b), .ALUControl(ctrl), .ALUResult(res), .Zero(z));

    initial begin
        // Operands: 
        // A = 32'h10101010 (Decimal: 269,484,048)
        // B = 32'h01010101 (Decimal: 16,843,009)
        a = 32'h10101010; 
        b = 32'h01010101; 

        // 1. ADD (0000) 
        // Waveform (Hex): 11111111 | Waveform (Dec): 286,331,153
        // FPGA Display (Lower 16 bits): 4369 (from 16'h1111)
        ctrl = 4'b0000; #10;
        
        // 2. SUB (0001) 
        // Waveform (Hex): 0F0F0F0F | Waveform (Dec): 252,645,135
        // FPGA Display (Lower 16 bits): 3855 (from 16'h0F0F)
        ctrl = 4'b0001; #10;
        
        // 3. AND (0010) 
        // Waveform (Hex): 00000000 | Waveform (Dec): 0 | Zero Flag (z): 1
        // FPGA Display (Lower 16 bits): 0
        ctrl = 4'b0010; #10;
        
        // 4. OR  (0011) 
        // Waveform (Hex): 11111111 | Waveform (Dec): 286,331,153
        // FPGA Display (Lower 16 bits): 4369
        ctrl = 4'b0011; #10;
        
        // 5. XOR (0100) 
        // Waveform (Hex): 11111111 | Waveform (Dec): 286,331,153
        // FPGA Display (Lower 16 bits): 4369
        ctrl = 4'b0100; #10;
        
        // 6. SLL (0101) -> Shift Left by B[4:0] (1 bit)
        // Waveform (Hex): 20202020 | Waveform (Dec): 538,976,288
        // FPGA Display (Lower 16 bits): 8224 (from 16'h2020)
        ctrl = 4'b0101; #10;
        
        // 7. SRL (0110) -> Shift Right by B[4:0] (1 bit)
        // Waveform (Hex): 08080808 | Waveform (Dec): 134,744,072
        // FPGA Display (Lower 16 bits): 2056 (from 16'h0808)
        ctrl = 4'b0110; #10;
        
        // 8. BEQ (0111) -> A == B?
        // Waveform (Hex): 00000000 | Waveform (Dec): 0 | Zero Flag (z): 1
        // FPGA Display (Lower 16 bits): 0
        ctrl = 4'b0111; #10;

        $finish;
    end
endmodule

//module ALU_tb;
//    reg [31:0] a, b;
//    reg [3:0] ctrl;
//    wire [31:0] res;
//    wire z; 

//    ALU uut (.A(a), .B(b), .ALUControl(ctrl), .ALUResult(res), .Zero(z));

//    initial begin
//        a = 32'h10101010; 
//        b = 32'h01010101; 

//        // 1. ADD (0000) -> Should see 4369 (Decimal)
//        ctrl = 4'b0000; #10;
        
//        // 2. SUB (0001) -> Should see 3855 (Decimal)
//        ctrl = 4'b0001; #10;
        
//        // 3. AND (0010) -> Should see 0000
//        ctrl = 4'b0010; #10;
        
//        // 4. OR  (0011) -> Should see 4369
//        ctrl = 4'b0011; #10;
        
//        // 5. XOR (0100) -> Should see 4369
//        ctrl = 4'b0100; #10;
        
//        // 6. SLL (0101) -> Should see 8224
//        ctrl = 4'b0101; #10;
        
//        // 7. SRL (0110) -> Should see 2056
//        ctrl = 4'b0110; #10;
        
//        // 8. BEQ (0111) -> Should see 0000 (Result is 0 because A != B)
//        ctrl = 4'b0111; #10;

//        $finish;
//    end
//endmodule
//`timescale 1ns / 1ps

//module ALU_tb;
//    reg [31:0] a, b;
//    reg [3:0] ctrl;
//    wire [31:0] res;
//    wire z;

//    ALU uut (.A(a), .B(b), .ALUControl(ctrl), .ALUResult(res), .Zero(z));

//    initial begin
//        a = 32'd100; b = 32'd40; ctrl = 4'b0000; #10; // ADD = 140
//        a = 32'd100; b = 32'd40; ctrl = 4'b0001; #10; // SUB = 60
//        a = 32'd20;  b = 32'd20; ctrl = 4'b0111; #10; // BEQ = 1
//        $finish;
//    end
//endmodule
