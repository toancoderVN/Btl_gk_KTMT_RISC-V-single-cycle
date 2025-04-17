`timescale 1ns / 1ps

module Data_Memory_tb;

    // Khai báo tín hiệu
    reg clk, rst, WE;
    reg [31:0] A, WD;
    wire [31:0] RD;

    // Khởi tạo module Data_Memory
    Data_Memory uut (
        .clk(clk),
        .rst(rst),
        .WE(WE),
        .WD(WD),
        .A(A),
        .RD(RD)
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
        WE = 0;
        A = 0;
        WD = 0;

        // Test case 1: Reset
        #10;
        rst = 0;
        A = 28;
        #10;
        $display("Test 1 (Reset): rst = %b, A = %d, RD = 0x%h (Expected: 0x00000000)", rst, A, RD);

        // Test case 2: Đọc dữ liệu khởi tạo (mem[28])
        #10;
        rst = 1;
        A = 28;
        #10;
        $display("Test 2 (Read Init): rst = %b, A = %d, RD = 0x%h (Expected: 0x00000020)", rst, A, RD);

        // Test case 3: Ghi dữ liệu vào mem[0]
        #10;
        rst = 1;
        WE = 1;
        A = 0;
        WD = 32'hDEADBEEF;
        #10;
        WE = 0; // Tắt WE sau khi ghi
        $display("Test 3 (Write): rst = %b, WE = %b, A = %d, WD = 0x%h", rst, WE, A, WD);

        // Test case 4: Đọc dữ liệu vừa ghi (mem[0])
        #10;
        A = 0;
        #10;
        $display("Test 4 (Read After Write): rst = %b, A = %d, RD = 0x%h (Expected: 0xDEADBEEF)", rst, A, RD);

        // Test case 5: Đọc từ địa chỉ chưa ghi (mem[100])
        #10;
        A = 100;
        #10;
        $display("Test 5 (Read Unwritten): rst = %b, A = %d, RD = 0x%h (Expected: 0x00000000)", rst, A, RD);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule