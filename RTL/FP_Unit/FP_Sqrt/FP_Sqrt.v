module FP_Sqrt(in_data, in_Clk, in_Rst_N, in_start, out_data, out_stall);
    parameter   DATA_WIDTH = 32;

    input   in_Clk, in_Rst_N, in_start;
    input   [DATA_WIDTH - 1:0] in_data;
    output  out_stall;
    output  [DATA_WIDTH - 1:0] out_data;
endmodule