// Shift (Left) Register

module shift_reg(in_shift_in, in_Clk, in_Rst_N, in_En, out_data);
    parameter DATA_WIDTH = 24;

    input   in_shift_in, in_Clk, in_Rst_N, in_En;
    output reg [DATA_WIDTH - 1:0] out_data;

    always @ (posedge in_Clk or negedge in_Rst_N) begin
        if (!in_Rst_N) begin
            out_data <= 0;
        end else if (in_En) begin
            out_data <= out_data << 1;
            out_data[0] <= in_shift_in;
        end else begin
            out_data <= out_data;
        end
    end
endmodule