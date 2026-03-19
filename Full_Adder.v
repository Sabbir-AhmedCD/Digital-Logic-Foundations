// ============================================
// Full Adder Module
// Author  : Sabbir Ahmed
// File    : Full_Adder.v
// Description: A 1-bit Full Adder built from
//              two Half Adders and an OR gate
// ============================================

module Full_Adder(
    input  A,
    input  B,
    input  Carry_In,
    output Sum,
    output Carry_Out
);

    // Sum = A XOR B XOR Carry_In
    assign Sum = A ^ B ^ Carry_In;

    // Carry_Out = majority function
    assign Carry_Out = (A & B) | (B & Carry_In) | (A & Carry_In);

endmodule
