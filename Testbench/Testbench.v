`timescale 1ns/1ps

module Testbench();
    parameter DATA_WIDTH    = 64;
    parameter waittime      = 20;
    parameter clocktime     = 10;
    
    integer i;

    wire    DM_wr_en, done_load_inst;
    reg     Clk, Rst_N, in_exe_finished;
    wire    [31:0] Inst;
    wire    [DATA_WIDTH - 1:0] Inst_Addr, Addr, Wr_Data, DM_Data;

    initial begin
        Clk = 1'b0; // Initial value of the clock signal
        forever #clocktime Clk = ~Clk; // Generates clock pulses forever
    end

    initial begin
        in_exe_finished = 1'b0;
        Rst_N = 1'b0;
        #waittime;
        
        while (!done_load_inst) begin
            #waittime;
        end

        Rst_N = 1'b1;
        #waittime;

        i = 0;
        while (i < 1000) begin
            #waittime;
            i = i + 1;
        end

        in_exe_finished = 1'b1;
        #waittime;
        $finish;
    end

    RV64IF_top RV64IF_top_Inst0(
        .in_DM_data(DM_Data),
        .in_inst(Inst),
        .in_Clk(Clk),
        .out_inst_addr(Inst_Addr),
        .out_addr(Addr),
        .out_wr_data(Wr_Data),
        .out_DM_wr_en(DM_wr_en),
        .Rst_N(Rst_N)
    );

    IMem IMem_Inst0(
        .out_inst(Inst),
        .in_inst_addr(Inst_Addr),
        .done_load_inst(done_load_inst)
    );

    DMem DMem_Inst0(
        .in_data(Wr_Data),
        .in_addr(Addr),
        .in_wr_en(DM_wr_en),
        .out_data(DM_Data),
        .in_exe_finished(in_exe_finished)
    );
endmodule