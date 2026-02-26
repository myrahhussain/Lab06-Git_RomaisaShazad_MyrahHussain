module ALU (
    input  [31:0] A, B,           // 32-bit inputs
    input  [3:0]  ALUControl,     // Control signal
    output reg [31:0] ALUResult,  // Result of the operation
    output Zero                   // Zero flag for branching
);

    // The Zero flag is high if ALUResult is exactly 0
    assign Zero = (ALUResult == 32'b0);

    always @(*) begin
        case (ALUControl)
            4'b0000: ALUResult = A & B;          // AND
            4'b0001: ALUResult = A | B;          // OR
            4'b0010: ALUResult = A + B;          // ADD
            4'b0110: ALUResult = A - B;          // SUB
            4'b0100: ALUResult = A ^ B;          // XOR
            4'b0101: ALUResult = A << B[4:0];    // SLL (Shift by lower 5 bits of B)
            4'b0111: ALUResult = A >> B[4:0];    // SRL
            default: ALUResult = 32'b0;          // Default case
        endcase
    end
endmodule