`timescale 1ns / 1ps

module Instruction_Memory_tb;

    // Khai báo tín hiệu
    reg rst;
    reg [31:0] A;
    wire [31:0] RD;

    // Khởi tạo module Instruction_Memory
    Instruction_Memory uut (
        .rst(rst),
        .A(A),
        .RD(RD)
    );

    // Khối kiểm tra
    initial begin
        // Khởi tạo giá trị ban đầu
        rst = 0;
        A = 0;

        // Test case 1: Reset
        #10;
        rst = 0;
        A = 0;
        #10;
        $display("Test 1 (Reset): rst = %b, A = %d, RD = 0x%h (Expected: 0x00000000)", rst, A, RD);

        // Test case 2: Đọc lệnh tại địa chỉ 0 (A = 0)
        #10;
        rst = 1;
        A = 0; // A[31:2] = 0
        #10;
        $display("Test 2 (Read A=0): rst = %b, A = %d, RD = 0x%h (Expected: 0x0062E233)", rst, A, RD);

        // Test case 3: Đọc lệnh tại địa chỉ 4 (A = 4)
        #10;
        rst = 1;
        A = 4; // A[31:2] = 1
        #10;
        $display("Test 3 (Read A=4): rst = %b, A = %d, RD = 0x%h (Expected: 0x00B62423)", rst, A, RD);

        // Test case 4: Đọc từ địa chỉ ngoài phạm vi (A = 8)
        #10;
        rst = 1;
        A = 8; // A[31:2] = 2
        #10;
        $display("Test 4 (Read A=8): rst = %b, A = %d, RD = 0x%h (Expected: 0x00000000)", rst, A, RD);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule