// Pattern History Table

module pht(in_addr, in_data, in_Clk, in_Rst_N, out_prediction);
    integer i;
    
    parameter   ADDR_WIDTH = 9;
    parameter   ENTRY_NUM = 512;    // 2^9 = 512 entries

    input   in_data, in_Clk, in_Rst_N;
    input   [ADDR_WIDTH - 1:0] in_addr;
    output  out_prediction;

    reg     [1:0] counter [ENTRY_NUM - 1:0];

    always @ (posedge in_Clk or negedge in_Rst_N) begin
        if (!in_Rst_N) begin
            for (i = 0; i < ENTRY_NUM; i = i + 1) begin
                counter[i] <= 0;
            end
        end else begin
            case (counter[in_addr])
                2'b00: counter[in_addr] <= (in_data) ? counter[in_addr] + 1 : counter[in_addr];
                2'b01: counter[in_addr] <= (in_data) ? counter[in_addr] + 1 : counter[in_addr - 1];
                2'b10: counter[in_addr] <= (in_data) ? counter[in_addr] + 1 : counter[in_addr - 1];
                2'b11: counter[in_addr] <= (in_data) ? counter[in_addr]     : counter[in_addr - 1];
            endcase
        end
    end

    assign out_prediction = (counter[in_addr] >= 2'b10) ? 1'b1 : 1'b0;
endmodule