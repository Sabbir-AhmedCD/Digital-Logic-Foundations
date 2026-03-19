// ============================================
// Half Adder Module
// Author  : Sabbir Ahmed
// File    : half_adder.v
// Description: A 1-bit Half Adder using
//              XOR gate for Sum and AND for Carry
// ============================================

module half_adder(
    input  A,
    input  B,
    output Sum,
    output Carry
);

    // Sum = A XOR B
    assign Sum = A ^ B;

    // Carry = A AND B
    assign Carry = A & B;

endmodule