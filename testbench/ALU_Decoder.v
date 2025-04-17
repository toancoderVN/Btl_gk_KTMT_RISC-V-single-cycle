`timescale 1ns / 1ps

module ALU_Decoder_tb;

    // Khai báo tín hiệu
    reg [1:0] ALUOp;
    reg [2:0] funct3;
    reg [6:0] funct7, op;
    wire [2:0] ALUControl;

    // Khởi tạo module ALU_Decoder
    ALU_Decoder uut (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(op),
        .ALUControl(ALUControl)
    );

    // Khối kiểm tra
    initial begin
        // Khởi tạo giá trị ban đầu
        ALUOp = 0;
        funct3 = 0;
        funct7 = 0;
        op = 0;

        // Test case 1: ALUOp = 2'b00
        #10;
        ALUOp = 2'b00;
        #10;
        $display("Test 1: ALUOp = %b, ALUControl = %b (Expected: 000)", ALUOp, ALUControl);

        // Test case 2: ALUOp = 2'b01
        #10;
        ALUOp = 2'b01;
        #10;
        $display("Test 2: ALUOp = %b, ALUControl = %b (Expected: 001)", ALUOp, ALUControl);

        // Test case 3: ALUOp = 2'b10, funct3 = 3'b000, {op[5], funct7[5]} = 2'b11
        #10;
        ALUOp = 2'b10;
        funct3 = 3'b000;
        op = 7'b0110011; // op[5] = 1
        funct7 = 7'b0100000; // funct7[5] = 1
        #10;
        $display("Test 3: ALUOp = %b, funct3 = %b, op[5] = %b, funct7[5] = %b, ALUControl = %b (Expected: 001)", ALUOp, funct3, op[5], funct7[5], ALUControl);

        // Test case 4: ALUOp = 2'b10, funct3 = 3'b000, {op[5], funct7[5]} = 2'b00
        #10;
        ALUOp = 2'b10;
        funct3 = 3'b000;
        op = 7'b0010011; // op[5] = 0
        funct7 = 7'b0000000; // funct7[5] = 0
        #10;
        $display("Test 4: ALUOp = %b, funct3 = %b, op[5] = %b, funct7[5] = %b, ALUControl = %b (Expected: 000)", ALUOp, funct3, op[5], funct7[5], ALUControl);

        // Test case 5: ALUOp = 2'b10, funct3 = 3'b010
        #10;
        ALUOp = 2'b10;
        funct3 = 3'b010;
        #10;
        $display("Test 5: ALUOp = %b, funct3 = %b, ALUControl = %b (Expected: 101)", ALUOp, funct3, ALUControl);

        // Test case 6: ALUOp = 2'b10, funct3 = 3'b110
        #10;
        ALUOp = 2'b10;
        funct3 = 3'b110;
        #10;
        $display("Test 6: ALUOp = %b, funct3 = %b, ALUControl = %b (Expected: 011)", ALUOp, funct3, ALUControl);

        // Test case 7: ALUOp = 2'b10, funct3 = 3'b111
        #10;
        ALUOp = 2'b10;
        funct3 = 3'b111;
        #10;
        $display("Test 7: ALUOp = %b, funct3 = %b, ALUControl = %b (Expected: 010)", ALUOp, funct3, ALUControl);

        // Test case 8: ALUOp = 2'b10, funct3 = 3'b100 (không xác định)
        #10;
        ALUOp = 2'b10;
        funct3 = 3'b100;
        #10;
        $display("Test 8: ALUOp = %b, funct3 = %b, ALUControl = %b (Expected: 000)", ALUOp, funct3, ALUControl);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule