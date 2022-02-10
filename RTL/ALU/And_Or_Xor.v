// Bitwise logical operations: AND, OR, and XOR module
module And_Or_Xor(in_numA, in_numB, out_And, out_Or, out_Xor);
    parameter DATA_WIDTH = 64;

    input   [DATA_WIDTH - 1:0] in_numA, in_numB;
    output  [DATA_WIDTH - 1:0] out_And, out_Or, out_Xor;

    assign out_And = in_numA & in_numB;
    assign out_Or = in_numA | in_numB;
    assign out_Xor = in_numA ^ in_numB;
endmodule