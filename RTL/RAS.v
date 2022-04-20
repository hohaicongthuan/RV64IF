// Return-Address Stack
// Stores return addresses, duh!

module RAS(in_data, out_data, in_Clk, in_Rst_N, in_rd, in_rs1, in_opcode);
    parameter   DATA_WIDTH = 64;

    input   in_Clk, in_Rst_N;
    input   [6:0] in_opcode;
    input   [4:0] in_rd, in_rs1;
    input   [DATA_WIDTH - 1:0] in_data;

    output  [DATA_WIDTH - 1:0] out_data;

    // Internal wires
    wire    push_signal, pop_signal, is_jump_opcode;
    wire    is_rd_ra;   // is destination register a return address register?
    wire    is_rs1_ra;  // is source register 1 a return address register?
    wire    is_rd_eq_rs1;   // is dest. reg equal to source reg 1?

    assign  is_jump_opcode  = (in_opcode == 7'b1101111 | in_opcode == 7'b1100111) ? 1'b1 : 1'b0;
    assign  is_rd_ra        = (in_rd == 5'd1 | in_rd == 5'd5) ? 1'b1 : 1'b0;
    assign  is_rs1_ra       = (in_rs1 == 5'd1 | in_rs1 == 5'd5) ? 1'b1 : 1'b0;
    assign  is_rd_eq_rs1    = (in_rd == in_rs1) ? 1'b1 : 1'b0;

    assign  push_signal = (((is_rd_ra & !is_rs1_ra) | (is_rd_ra & is_rs1_ra & !is_rd_eq_rs1) | (is_rd_ra & is_rs1_ra & is_rd_eq_rs1)) & is_jump_opcode) ? 1'b1 : 1'b0;
    assign  pop_signal  = (((!is_rd_ra & is_rs1_ra) | (is_rd_ra & is_rs1_ra & !is_rd_eq_rs1)) & is_jump_opcode) ? 1'b1 : 1'b0;

    stack stack_Inst0(
        .in_data(in_data),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_push(push_signal),
        .in_pop(pop_signal),
        .out_data(out_data),
        .out_full(),
        .out_empty()
    );

endmodule