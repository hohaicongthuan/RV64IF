module FP_RegisterFile(data_in, data_outA, data_outB, addr_A, addr_B, writeAddr, write_En, Clk);

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 5;

    input   Clk, write_En;
    input   [ADDR_WIDTH - 1:0] addr_A, addr_B, writeAddr;
    input   [DATA_WIDTH - 1:0] data_in;

    output  [DATA_WIDTH - 1:0] data_outA, data_outB;

    reg [DATA_WIDTH - 1:0] registerFile [31:0];

    always @ (posedge Clk) begin
        registerFile[writeAddr] <= (write_En) ? data_in : registerFile[writeAddr];
    end

    assign data_outA = registerFile[addr_A];
    assign data_outB = registerFile[addr_B];
endmodule