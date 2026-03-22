// ============================================
// 8-bit Ripple Carry Adder
// Author      : Sabbir Ahmed
// File        : RCA_8bit.v
// Description : Adds two 8-bit numbers using
//               two chained 4-bit RCAs
// ============================================

module Full_Adder(
    input  A,
    input  B,
    input  Carry_In,
    output Sum,
    output Carry_Out
);
    assign Sum       = A ^ B ^ Carry_In;
    assign Carry_Out = (A & B) | (B & Carry_In) | (A & Carry_In);
endmodule

module RCA_4bit(
    input  A0, A1, A2, A3,
    input  B0, B1, B2, B3,
    input  Cin,
    output S0, S1, S2, S3,
    output Cout
);
    wire C1, C2, C3;

    Full_Adder FA0 (A0, B0, Cin, S0, C1);
    Full_Adder FA1 (A1, B1, C1,  S1, C2);
    Full_Adder FA2 (A2, B2, C2,  S2, C3);
    Full_Adder FA3 (A3, B3, C3,  S3, Cout);
endmodule

module RCA_8bit(
    input  A0, A1, A2, A3, A4, A5, A6, A7,
    input  B0, B1, B2, B3, B4, B5, B6, B7,
    input  Cin,
    output S0, S1, S2, S3, S4, S5, S6, S7,
    output Cout
);
    wire C4;

    RCA_4bit LOW  (A0,A1,A2,A3, B0,B1,B2,B3, Cin, S0,S1,S2,S3, C4);
    RCA_4bit HIGH (A4,A5,A6,A7, B4,B5,B6,B7, C4,  S4,S5,S6,S7, Cout);
endmodule

module RCA_8bit_tb;
    reg  A0,A1,A2,A3,A4,A5,A6,A7;
    reg  B0,B1,B2,B3,B4,B5,B6,B7;
    reg  Cin;
    wire S0,S1,S2,S3,S4,S5,S6,S7,Cout;

    RCA_8bit rca8 (
        A0,A1,A2,A3,A4,A5,A6,A7,
        B0,B1,B2,B3,B4,B5,B6,B7,
        Cin,
        S0,S1,S2,S3,S4,S5,S6,S7,
        Cout
    );

    initial begin
        $display("=== 8-bit Ripple Carry Adder Test ===");
        $display("Test       | Result   | Cout");
        $display("-----------|----------|-----");

        // Test 100 + 55 = 155
        // 100 = 01100100
        // 55  = 00110111
        A7=0;A6=1;A5=1;A4=0;A3=0;A2=1;A1=0;A0=0;
        B7=0;B6=0;B5=1;B4=1;B3=0;B2=1;B1=1;B0=1;
        Cin=0; #10;
        $display("100 + 55   | %b%b%b%b%b%b%b%b |  %b  (=%d)",
        S7,S6,S5,S4,S3,S2,S1,S0,Cout,155);

        // Test 200 + 55 = 255
        // 200 = 11001000
        // 55  = 00110111
        A7=1;A6=1;A5=0;A4=0;A3=1;A2=0;A1=0;A0=0;
        B7=0;B6=0;B5=1;B4=1;B3=0;B2=1;B1=1;B0=1;
        Cin=0; #10;
        $display("200 + 55   | %b%b%b%b%b%b%b%b |  %b  (=%d)",
        S7,S6,S5,S4,S3,S2,S1,S0,Cout,255);

        // Test 255 + 1 = 256 (overflow)
        // 255 = 11111111
        // 1   = 00000001
        A7=1;A6=1;A5=1;A4=1;A3=1;A2=1;A1=1;A0=1;
        B7=0;B6=0;B5=0;B4=0;B3=0;B2=0;B1=0;B0=1;
        Cin=0; #10;
        $display("255 + 1    | %b%b%b%b%b%b%b%b |  %b  (=256 overflow)",
        S7,S6,S5,S4,S3,S2,S1,S0,Cout);

        $display("=====================================");
    end
endmodule