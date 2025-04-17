`timescale 1ns / 1ps

module Mux_tb;

    // Khai báo tín hiệu
    reg [31:0] a, b;
    reg s;
    wire [31:0] c;

    // Khởi tạo module Mux
    Mux uut (
        .a(a),
        .b(b),
        .s(s),
        .c(c)
    );

    // Khối kiểm tra
    initial begin
        // Khởi tạo giá trị ban đầu
        a = 0;
        b = 0;
        s = 0;

        // Test case 1: Chọn a (s = 0)
        #10;
        a = 32'hDEADBEEF;
        b = 32'h12345678;
        s = 0;
        #10;
        $display("Test 1 (Select a): s = %b, a = 0x%h, b = 0x%h, c = 0x%h (Expected: 0xDEADBEEF)", s, a, b, c);

        // Test case 2: Chọn b (s = 1)
        #10;
        s = 1;
        #10;
        $display("Test 2 (Select b): s = %b, a = 0x%h, b = 0x%h, c = 0x%h (Expected: 0x12345678)", s, a, b, c);

        // Test case 3: Thay đổi s (s = 0 -> s = 1)
        #10;
        a = 32'hAAAAAAAA;
        b = 32'hBBBBBBBB;
        s = 0;
        #10;
        $display("Test 3 (Select a): s = %b, a = 0x%h, b = 0x%h, c = 0x%h (Expected: 0xAAAAAAAA)", s, a, b, c);
        #10;
        s = 1;
        #10;
        $display("Test 3 (Select b): s = %b, a = 0x%h, b = 0x%h, c = 0x%h (Expected: 0xBBBBBBBB)", s, a, b, c);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule