`timescale 1ns / 1ps  // Defines time unit and precision

module ALU_tb();
    // 1. Declare local signals to connect to the ALU
    reg  [31:0] A, B;           // 'reg' because we will drive these in an initial block
    reg  [3:0]  ALUControl;     
    wire [31:0] ALUResult;      // 'wire' because the ALU module drives this
    wire        Zero;

    // 2. Instantiate the Unit Under Test (UUT)
    // This "plugs" your ALU.v into the testbench
    ALU uut (
        .A(A), 
        .B(B), 
        .ALUControl(ALUControl), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

    // 3. Stimulus Generation
    initial begin
        // Display a header in the simulation console
        $display("Time\t A\t B\t Ctrl\t Result\t Zero");
        $monitor("%0t\t %h\t %h\t %b\t %h\t %b", $time, A, B, ALUControl, ALUResult, Zero);

        // --- Test Case 1: ADD ---
        A = 32'h0000000A; B = 32'h00000005; ALUControl = 4'b0010; 
        #10; // Wait 10ns

        // --- Test Case 2: SUB ---
        A = 32'h00000014; B = 32'h00000004; ALUControl = 4'b0110; 
        #10;

        // --- Test Case 3: SUB (Zero Flag Check) ---
        A = 32'h000000FF; B = 32'h000000FF; ALUControl = 4'b0110; 
        #10;

        // --- Test Case 4: SLL (Shift Left 2 bits) ---
        // 0x1 becomes 0x4 (0001 -> 0100)
        A = 32'h00000001; B = 32'h00000002; ALUControl = 4'b0101; 
        #10;

        // --- Test Case 5: AND ---
        A = 32'hFFFF0000; B = 32'h0000FFFF; ALUControl = 4'b0000; 
        #10;

        $finish; // End the simulation
    end
endmodule