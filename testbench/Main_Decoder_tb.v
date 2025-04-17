`timescale 1ns / 1ps

module Main_Decoder_tb;

    // Khai báo tín hiệu
    reg [6:0] Op;
    wire RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
    wire [1:0] ImmSrc, ALUOp;

    // Khởi tạo module Main_Decoder
    Main_Decoder uut (
        .Op(Op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    // Khối kiểm tra
    initial begin
        // Khởi tạo giá trị ban đầu
        Op = 0;

        // Test case 1: LOAD (lw)
        #10;
        Op = 7'b0000011;
        #10;
        $display("Test 1 (LOAD): Op = %b, RegWrite = %b, ImmSrc = %b, ALUSrc = %b, MemWrite = %b, ResultSrc = %b, Branch = %b, ALUOp = %b", 
                 Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Test case 2: STORE (sw)
        #10;
        Op = 7'b0100011;
        #10;
        $display("Test 2 (STORE): Op = %b, RegWrite = %b, ImmSrc = %b, ALUSrc = %b, MemWrite = %b, ResultSrc = %b, Branch = %b, ALUOp = %b", 
                 Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Test case 3: R-type (add)
        #10;
        Op = 7'b0110011;
        #10;
        $display("Test 3 (R-type): Op = %b, RegWrite = %b, ImmSrc = %b, ALUSrc = %b, MemWrite = %b, ResultSrc = %b, Branch = %b, ALUOp = %b", 
                 Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Test case 4: BRANCH (beq)
        #10;
        Op = 7'b1100011;
        #10;
        $display("Test 4 (BRANCH): Op = %b, RegWrite = %b, ImmSrc = %b, ALUSrc = %b, MemWrite = %b, ResultSrc = %b, Branch = %b, ALUOp = %b", 
                 Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Test case 5: Opcode không xác định
        #10;
        Op = 7'b1111111;
        #10;
        $display("Test 5 (Undefined): Op = %b, RegWrite = %b, ImmSrc = %b, ALUSrc = %b, MemWrite = %b, ResultSrc = %b, Branch = %b, ALUOp = %b", 
                 Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule