// ============================================
// 4-bit Ripple Carry Adder
// Author      : Sabbir Ahmed
// File        : RCA_4bit.v
// Description : Adds two 4-bit numbers using
//               four chained Full Adders
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

module RCA_4bit_tb;
    reg  A0, A1, A2, A3;
    reg  B0, B1, B2, B3;
    reg  Cin;
    wire S0, S1, S2, S3, Cout;

    RCA_4bit rca (
        A0, A1, A2, A3,
        B0, B1, B2, B3,
        Cin,
        S0, S1, S2, S3,
        Cout
    );

    initial begin
        $display("=== 4-bit Ripple Carry Adder Test ===");
        $display("A    | B    | Cin | Sum  | Cout");
        $display("-----|------|-----|------|-----");

        // Test 7 + 5 = 12
        // 7 = 0111, 5 = 0101
        A3=0; A2=1; A1=1; A0=1;
        B3=0; B2=1; B1=0; B0=1;
        Cin=0; #10;
        $display("0111 | 0101 |  0  | %b%b%b%b  |  %b   (7+5=%0d)",
        S3,S2,S1,S0,Cout,
        (A3*8+A2*4+A1*2+A0)+(B3*8+B2*4+B1*2+B0));

        // Test 15 + 1 = 16 (overflow)
        // 15 = 1111, 1 = 0001
        A3=1; A2=1; A1=1; A0=1;
        B3=0; B2=0; B1=0; B0=1;
        Cin=0; #10;
        $display("1111 | 0001 |  0  | %b%b%b%b  |  %b   (15+1=16 overflow)",
        S3,S2,S1,S0,Cout);

        // Test 8 + 7 = 15
        // 8 = 1000, 7 = 0111
        A3=1; A2=0; A1=0; A0=0;
        B3=0; B2=1; B1=1; B0=1;
        Cin=0; #10;
        $display("1000 | 0111 |  0  | %b%b%b%b  |  %b   (8+7=15)",
        S3,S2,S1,S0,Cout);

        $display("=====================================");
    end
endmodule