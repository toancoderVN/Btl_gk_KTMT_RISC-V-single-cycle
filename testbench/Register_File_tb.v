`timescale 1ns / 1ps

module Register_File_tb;

    // Khai báo tín hiệu
    reg clk, rst, WE3;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;
    wire [31:0] RD1, RD2;

    // Khởi tạo module Register_File
    Register_File uut (
        .clk(clk),
        .rst(rst),
        .WE3(WE3),
        .WD3(WD3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .RD1(RD1),
        .RD2(RD2)
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
        WE3 = 0;
        A1 = 0;
        A2 = 0;
        A3 = 0;
        WD3 = 0;

        // Test case 1: Reset
        #10;
        rst = 0;
        A1 = 5;
        A2 = 6;
        #10;
        $display("Test 1 (Reset): rst = %b, A1 = %d, A2 = %d, RD1 = 0x%h, RD2 = 0x%h (Expected: 0x00000000, 0x00000000)", rst, A1, A2, RD1, RD2);

        // Test case 2: Đọc giá trị khởi tạo (Register[5] và Register[6])
        #10;
        rst = 1;
        A1 = 5;
        A2 = 6;
        #10;
        $display("Test 2 (Read Init): rst = %b, A1 = %d, A2 = %d, RD1 = 0x%h, RD2 = 0x%h (Expected: 0x00000005, 0x00000004)", rst, A1, A2, RD1, RD2);

        // Test case 3: Ghi dữ liệu vào Register[10]
        #10;
        rst = 1;
        WE3 = 1;
        A3 = 10;
        WD3 = 32'hDEADBEEF;
        #10;
        WE3 = 0; // Tắt WE3 sau khi ghi
        $display("Test 3 (Write): rst = %b, WE3 = %b, A3 = %d, WD3 = 0x%h", rst, WE3, A3, WD3);

        // Test case 4: Đọc sau khi ghi (Register[10] và Register[5])
        #10;
        A1 = 10;
        A2 = 5;
        #10;
        $display("Test 4 (Read After Write): rst = %b, A1 = %d, A2 = %d, RD1 = 0x%h, RD2 = 0x%h (Expected: 0xDEADBEEF, 0x00000005)", rst, A1, A2, RD1, RD2);

        // Test case 5: Đọc từ thanh ghi chưa ghi (Register[15])
        #10;
        A1 = 15;
        A2 = 15;
        #10;
        $display("Test 5 (Read Unwritten): rst = %b, A1 = %d, A2 = %d, RD1 = 0x%h, RD2 = 0x%h (Expected: 0x00000000, 0x00000000)", rst, A1, A2, RD1, RD2);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule