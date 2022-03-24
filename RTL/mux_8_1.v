module mux_8_1(
    in_data_0,
    in_data_1,
    in_data_2,
    in_data_3,
    in_data_4,
    in_data_5,
    in_data_6,
    in_data_7,
    in_sel,
    out_data
);
    parameter   DATA_WIDTH = 64;

    input   [DATA_WIDTH - 1:0] in_data_0, in_data_1, in_data_2, in_data_3, in_data_4, in_data_5, in_data_6, in_data_7;
    input   [2:0] in_sel;
    output reg [DATA_WIDTH - 1:0] out_data;

    always @ (*) begin
        case (in_sel)
            3'b000: out_data = in_data_0;
            3'b001: out_data = in_data_1;
            3'b010: out_data = in_data_2;
            3'b011: out_data = in_data_3;
            3'b100: out_data = in_data_4;
            3'b101: out_data = in_data_5;
            3'b110: out_data = in_data_6;
            3'b111: out_data = in_data_7;
            default: out_data = in_data_0;
        endcase
    end
endmodule