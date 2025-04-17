`timescale 1ns / 1ps

module ALU_tb;

    // Khai báo tín hiệu
    reg [31:0] A, B;
    reg [2:0] ALUControl;
    wire [31:0] Result;
    wire OverFlow, Carry, Zero, Negative;

    // Khởi tạo module ALU
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .OverFlow(OverFlow),
        .Carry(Carry),
        .Zero(Zero),
        .Negative(Negative)
    );

    // Khối kiểm tra
    initial begin
        // Khởi tạo giá trị ban đầu
        A = 0;
        B = 0;
        ALUControl = 0;

        // Test case 1: Phép cộng (A = 5, B = 3)
        #10;
        A = 32'd5;
        B = 32'd3;
        ALUControl = 3'b000;
        #10;
        $display("Test 1 (Add): A = %d, B = %d, Result = %d, Zero = %b, Negative = %b, Carry = %b, OverFlow = %b", A, B, Result, Zero, Negative, Carry, OverFlow);

        // Test case 2: Phép trừ (A = 5, B = 3)
        #10;
        A = 32'd5;
        B = 32'd3;
        ALUControl = 3'b001;
        #10;
        $display("Test 2 (Sub): A = %d, B = %d, Result = %d, Zero = %b, Negative = %b, Carry = %b, OverFlow = %b", A, B, Result, Zero, Negative, Carry, OverFlow);

        // Test case 3: Phép AND (A = 5, B = 3)
        #10;
        A = 32'h00000005;
        B = 32'h00000003;
        ALUControl = 3'b010;
        #10;
        $display("Test 3 (AND): A = 0x%h, B = 0x%h, Result = 0x%h, Zero = %b, Negative = %b", A, B, Result, Zero, Negative);

        // Test case 4: Phép OR (A = 5, B = 3)
        #10;
        A = 32'h00000005;
        B = 32'h00000003;
        ALUControl = 3'b011;
        #10;
        $display("Test 4 (OR): A = 0x%h, B = 0x%h, Result = 0x%h, Zero = %b, Negative = %b", A, B, Result, Zero, Negative);

        // Test case 5: Phép SLT (A = 3, B = 5)
        #10;
        A = 32'd3;
        B = 32'd5;
        ALUControl = 3'b101;
        #10;
        $display("Test 5 (SLT): A = %d, B = %d, Result = %d, Zero = %b, Negative = %b", A, B, Result, Zero, Negative);

        // Test case 6: Kiểm tra Zero (A = 3, B = 3, Sub)
        #10;
        A = 32'd3;
        B = 32'd3;
        ALUControl = 3'b001;
        #10;
        $display("Test 6 (Zero): A = %d, B = %d, Result = %d, Zero = %b, Negative = %b", A, B, Result, Zero, Negative);

        // Test case 7: Kiểm tra Negative (A = 3, B = 5, Sub)
        #10;
        A = 32'd3;
        B = 32'd5;
        ALUControl = 3'b001;
        #10;
        $display("Test 7 (Negative): A = %d, B = %d, Result = 0x%h, Zero = %b, Negative = %b", A, B, Result, Zero, Negative);

        // Test case 8: Kiểm tra OverFlow (A = 0x7FFFFFFF, B = 1, Add)
        #10;
        A = 32'h7FFFFFFF;
        B = 32'd1;
        ALUControl = 3'b000;
        #10;
        $display("Test 8 (OverFlow): A = 0x%h, B = 0x%h, Result = 0x%h, OverFlow = %b", A, B, Result, OverFlow);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule