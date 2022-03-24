module mux_4_1(in_data_0, in_data_1, in_data_2, in_data_3, out_data, in_sel);
    parameter   DATA_WIDTH = 64;

    input   [DATA_WIDTH - 1:0] in_data_0, in_data_1, in_data_2, in_data_3;
    input   [1:0] in_sel;
    output reg [DATA_WIDTH - 1:0] out_data;

    always @ (*) begin
        case (in_sel)
            2'b00: out_data = in_data_0;
            2'b01: out_data = in_data_1;
            2'b10: out_data = in_data_2;
            2'b11: out_data = in_data_3;
            default: out_data = in_data_0;
        endcase
    end
endmodule