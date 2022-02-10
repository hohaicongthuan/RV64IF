// Integer adder/subtractor module
module AddSub(in_numA, in_numB, out_Sum, out_Diff);
    parameter DATA_WIDTH = 64;

    input   [DATA_WIDTH - 1:0] in_numA, in_numB;

    output  [DATA_WIDTH - 1:0] out_Sum, out_Diff;

    assign out_Sum = in_numA + in_numB;
    assign out_Diff = in_numA - in_numB;
endmodule