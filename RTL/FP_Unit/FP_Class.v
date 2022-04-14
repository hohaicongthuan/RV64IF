// RD BIT | MEANING
//--------|-------------------------------------
//    0   | rs1 is negative infinity
//    1   | rs1 is a negative normal number
//    2   | rs1 is a negative subnormal number
//    3   | rs1 is negative zero
//    4   | rs1 is positive zero
//    5   | rs1 is a positive subnormal number
//    6   | rs1 is a positive normal number
//    7   | rs1 is positive infinity
//    8   | rs1 is a signaling NaN
//    9   | rs1 is a quite NaN

module FP_Class(in_data, out_data);
    parameter DATA_WIDTH = 32;

    input   [DATA_WIDTH - 1:0] in_data;
    output  [DATA_WIDTH - 1:0] out_data;

    assign out_data[31:10] = 22'd0;

    assign out_data[0] = (in_data == 32'hFF800000) ? 1'b1 : 1'b0;
    assign out_data[1] = (in_data[31] & !out_data[0] & (out_data[9:2] == 8'd0)) ? 1'b1 : 1'b0;
    assign out_data[2] = ((in_data[31:23] == 9'b100000000) & (in_data[22:0] != 23'd0)) ? 1'b1 : 1'b0;
    assign out_data[3] = (in_data == 32'h80000000) ? 1'b1 : 1'b0;
    assign out_data[4] = (in_data == 32'h00000000) ? 1'b1 : 1'b0;
    assign out_data[5] = ((in_data[31:23] == 9'd0) & (in_data[22:0] != 23'd0)) ? 1'b1 : 1'b0;
    assign out_data[6] = (!in_data[31] & (out_data[5:0] == 6'd0) & (out_data[9:7] == 3'd0)) ? 1'b1 : 1'b0;
    assign out_data[7] = (in_data == 32'h7F800000) ? 1'b1 : 1'b0;
    assign out_data[8] = ((in_data[30:22] == 9'b111111110) & (in_data[21:0] != 22'd0)) ? 1'b1 : 1'b0;
    assign out_data[9] = (in_data[30:22] == 9'b111111111) ? 1'b1 : 1'b0;
endmodule