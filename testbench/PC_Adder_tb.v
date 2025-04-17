`timescale 1ns / 1ps

module PC_Adder_tb;

    // Khai báo tín hiệu
    reg [31:0] a, b;
    wire [31:0] c;

    // Khởi tạo module PC_Adder
    PC_Adder uut (
        .a(a),
        .b(b),
        .c(c)
    );

    // Khối kiểm tra
    initial begin
        // Khởi tạo giá trị ban đầu
        a = 0;
        b = 0;

        // Test case 1: Tăng PC thông thường (a = 0, b = 4)
        #10;
        a = 32'd0;
        b = 32'd4;
        #10;
        $display("Test 1 (PC + 4): a = 0x%h, b = 0x%h, c = 0x%h (Expected: 0x00000004)", a, b, c);

        // Test case 2: Tăng PC với giá trị bất kỳ (a = 100, b = 4)
        #10;
        a = 32'd100;
        b = 32'd4;
        #10;
        $display("Test 2 (PC + 4): a = 0x%h, b = 0x%h, c = 0x%h (Expected: 0x00000068)", a, b, c);

        // Test case 3: Kiểm tra tràn số (a = 0xFFFFFFFC, b = 4)
        #10;
        a = 32'hFFFFFFFC;
        b = 32'd4;
        #10;
        $display("Test 3 (Overflow): a = 0x%h, b = 0x%h, c = 0x%h (Expected: 0x00000000)", a, b, c);

        // Test case 4: Cộng với offset âm (a = 100, b = -4)
        #10;
        a = 32'd100;
        b = -32'd4; // -4 trong dạng 32-bit
        #10;
        $display("Test 4 (Negative Offset): a = 0x%h, b = 0x%h, c = 0x%h (Expected: 0x00000060)", a, b, c);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule