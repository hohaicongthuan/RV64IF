module REG(in_data, out_data, Clk, Rst_N, En);
    parameter   DATA_WIDTH = 64;
    
    input   Clk, Rst_N, En;
    input   [DATA_WIDTH - 1:0] in_data;
    
    output reg  [DATA_WIDTH - 1:0] out_data;

    always @ (posedge Clk or negedge Rst_N) begin
        if (!Rst_N) out_data <= 0;
        else if (En )out_data <= in_data;
        else out_data <= out_data;
    end
endmodule