module REG(in_data, out_data, Clk, Rst);
    parameter   DATA_WIDTH = 64;
    
    input   Clk, Rst;
    input   [DATA_WIDTH - 1:0] in_data;
    
    output reg  [DATA_WIDTH - 1:0] out_data;

    always @ (posedge Clk or negedge Rst) begin
        if (!Rst) out_data <= 0;
        else out_data <= in_data;
    end
endmodule