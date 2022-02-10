module REG(in_data, out_data, Clk, Rst);
    input   Clk, Rst;
    input   [63:0] in_data;
    
    output reg  [63:0] out_data;

    always @ (posedge Clk or negedge Rst) begin
        if (!Rst) out_data <= 64'd0;
        else out_data <= in_data;
    end
endmodule