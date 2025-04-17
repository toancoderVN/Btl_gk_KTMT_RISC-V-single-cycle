`timescale 1ns / 1ps

module PC_tb;

    // Khai báo tín hiệu
    reg clk, rst;
    reg [31:0] PC_Next;
    wire [31:0] PC;

    // Khởi tạo module PC_Module
    PC_Module uut (
        .clk(clk),
        .rst(rst),
        .PC_Next(PC_Next),
        .PC(PC)
    );

    // Sinh xung clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Chu kỳ clock = 10ns
    end

    // Khối kiểm tra
    initial begin
        // Khởi tạo giá trị ban đầu
        rst = 0;
        PC_Next = 0;

        // Test case 1: Reset
        #10;
        rst = 0;
        PC_Next = 32'hDEADBEEF;
        #10;
        $display("Test 1 (Reset): rst = %b, PC_Next = 0x%h, PC = 0x%h (Expected: 0x00000000)", rst, PC_Next, PC);

        // Test case 2: Cập nhật PC lần 1 (PC_Next = 4)
        #10;
        rst = 1;
        PC_Next = 32'd4;
        #10; // Chờ cạnh lên của clk
        $display("Test 2 (Update PC 1): rst = %b, PC_Next = 0x%h, PC = 0x%h (Expected: 0x00000004)", rst, PC_Next, PC);

        // Test case 3: Cập nhật PC lần 2 (PC_Next = 8)
        #10;
        PC_Next = 32'd8;
        #10; // Chờ cạnh lên của clk
        $display("Test 3 (Update PC 2): rst = %b, PC_Next = 0x%h, PC = 0x%h (Expected: 0x00000008)", rst, PC_Next, PC);

        // Test case 4: Reset giữa chừng
        #10;
        rst = 0;
        PC_Next = 32'd12;
        #10; // Chờ cạnh lên của clk
        $display("Test 4 (Reset Mid): rst = %b, PC_Next = 0x%h, PC = 0x%h (Expected: 0x00000000)", rst, PC_Next, PC);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule