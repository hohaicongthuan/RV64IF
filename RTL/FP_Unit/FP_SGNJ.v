// This module performs sign injection on a given number
// (Normal sign injection, negated sign injection, and XOR-ed sign injection).

module FP_SGNJ(in_numA, in_numB, in_ctrl_jnx, out_data);
    input   [31:0] in_numA, in_numB;
    input   [1:0] in_ctrl_jnx;  // 00 -> normal sign injection
                                // 01 -> negated sign injection
                                // 10 -> XOR-ed sign injection

    output  [31:0] out_data;

    // Internal wires
    wire [31:0] wire_1, wire_2;

    assign out_data = (in_ctrl_jnx == 2'b00) ? ({in_numB[31], in_numA[30:0]}) : wire_1;
    assign wire_1 = (in_ctrl_jnx == 2'b01) ? ({!in_numB[31], in_numA[30:0]}) : wire_2;
    assign wire_2 = (in_ctrl_jnx == 2'b10) ? ({(in_numA[31] ^ in_numB[31]), in_numA[30:0]}) : in_numA;
endmodule