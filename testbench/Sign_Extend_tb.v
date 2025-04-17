`timescale 1ns / 1ps

module Sign_Extend_tb;

    // Khai báo tín hiệu
    reg [31:0] In;
    reg ImmSrc;
    wire [31:0] Imm_Ext;

    // Khởi tạo module Sign_Extend
    Sign_Extend uut (
        .In(In),
        .ImmSrc(ImmSrc),
        .Imm_Ext(Imm_Ext)
    );

    // Khối kiểm tra
    initial begin
        // Khởi tạo giá trị ban đầu
        In = 0;
        ImmSrc = 0;

        // Test case 1: I-type, immediate dương
        #10;
        ImmSrc = 0;
        In = 32'h00000FFF; // 12 bit thấp nhất là 0xFFF, bit dấu = 0
        #10;
        $display("Test 1 (I-type Positive): ImmSrc = %b, In = 0x%h, Imm_Ext = 0x%h (Expected: 0x00000FFF)", ImmSrc, In, Imm_Ext);

        // Test case 2: I-type, immediate âm
        #10;
        ImmSrc = 0;
        In = 32'hFFFFF800; // 12 bit thấp nhất là 0x800, bit dấu = 1
        #10;
        $display("Test 2 (I-type Negative): ImmSrc = %b, In = 0x%h, Imm_Ext = 0x%h (Expected: 0xFFFFF800)", ImmSrc, In, Imm_Ext);

        // Test case 3: S-type, immediate dương
        #10;
        ImmSrc = 1;
        In = 32'h0000007F; // In[31:25] = 7'b0000000, In[11:7] = 5'b11111, bit dấu = 0
        #10;
        $display("Test 3 (S-type Positive): ImmSrc = %b, In = 0x%h, Imm_Ext = 0x%h (Expected: 0x0000007F)", ImmSrc, In, Imm_Ext);

        // Test case 4: S-type, immediate âm
        #10;
        ImmSrc = 1;
        In = 32'hFE000F80; // In[31:25] = 7'b1111110, In[11:7] = 5'b00000, bit dấu = 1
        #10;
        $display("Test 4 (S-type Negative): ImmSrc = %b, In = 0x%h, Imm_Ext = 0x%h (Expected: 0xFFFFFF80)", ImmSrc, In, Imm_Ext);

        // Kết thúc mô phỏng
        #10;
        $finish;
    end

endmodule