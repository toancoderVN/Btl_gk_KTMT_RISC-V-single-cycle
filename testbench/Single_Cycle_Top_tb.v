`timescale 1ns / 1ps

module Single_Cycle_Top_tb;

    // Khai báo tín hiệu
    reg clk, rst;

    // Khởi tạo module Single_Cycle_Top
    Single_Cycle_Top uut (
        .clk(clk),
        .rst(rst)
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

        // Test case 1: Reset
        #10;
        rst = 0;
        #10;
        $display("Test 1 (Reset): rst = %b, PC = 0x%h (Expected: 0x00000000)", rst, uut.PC_Top);

        // Test case 2: Thực thi lệnh LOAD (lw x7, 20(x6))
        #10;
        rst = 1;
        #20; // Chờ 2 chu kỳ clock để lệnh thực thi
        $display("Test 2 (LOAD): PC = 0x%h, Instr = 0x%h, Reg[7] = 0x%h (Expected: 0x00000020)", 
                 uut.PC_Top, uut.RD_Instr, uut.Register_File.Register[7]);

        // Test case 3: Thực thi lệnh R-type (add x5, x6, x5)
        #10;
        #20; // Chờ 2 chu kỳ clock
        $display("Test 3 (R-type Add): PC = 0x%h, Instr = 0x%h, Reg[5] = 0x%h (Expected: 0x00000009)", 
                 uut.PC_Top, uut.RD_Instr, uut.Register_File.Register[5]);

        // Test case 4: Thực thi lệnh STORE (sw x5, 8(x6))
        #10;
        #20; // Chờ 2 chu kỳ clock
        $display("Test 4 (STORE): PC = 0x%h, Instr = 0x%h, Mem[12] = 0x%h (Expected: 0x00000009)", 
                 uut.PC_Top, uut.RD_Instr, uut.Data_Memory.mem[12]);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule