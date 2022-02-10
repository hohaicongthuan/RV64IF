// Immediate Generator
module ImmGen(in_data, in_inst_type, out_data);
    input   [31:0] in_data;
    input   [2:0] in_inst_type;

    output  [63:0] out_data;

    wire [63:0] I_Imm, S_Imm, B_Imm, U_Imm, J_Imm, wire_1, wire_2, wire_3, wire_4;

    assign I_Imm = {{53{in_data[31]}}, in_data[30:20]};
    assign S_Imm = {{53{in_data[31]}}, in_data[30:25], in_data[11:7]};
    assign B_Imm = {{52{in_data[31]}}, in_data[7], in_data[30:25], in_data[11:8], 1'b0};
    assign U_Imm = {{32{in_data[31]}}, in_data[31:12], 12'd0};
    assign J_Imm = {{44{in_data[31]}}, in_data[19:12], in_data[20], in_data[30:21], 1'b0};

    assign out_data = (in_inst_type == 3'b000) ? I_Imm : wire_1;
    assign wire_1   = (in_inst_type == 3'b001) ? U_Imm : wire_2;
    assign wire_2   = (in_inst_type == 3'b011) ? J_Imm : wire_3;
    assign wire_3   = (in_inst_type == 3'b100) ? B_Imm : wire_4;
    assign wire_4   = (in_inst_type == 3'b101) ? S_Imm : 64'd0;
endmodule