// Testbench for FP_Sqrt.v module

`timescale 1ns/1ps

module Testbench();
    parameter waittime      = 20;
    parameter clocktime     = 10;
    
    integer i;

    reg     in_Clk, in_Rst_N, in_start;
    reg     [31:0] in_data;
    wire    out_stall;
    wire    [31:0] out_data;

    initial begin
        in_Clk = 1'b0; // Initial value of the clock signal
        forever #clocktime in_Clk = ~in_Clk; // Generates clock pulses forever
    end

    initial begin
        in_Rst_N = 1'b0;
        in_start = 1'b0;
        in_data = 32'h40800000; // number 4 in 32-bit floating-point format
        #waittime;
        in_Rst_N = 1'b1;
        in_start = 1'b1;

        for (i = 0; i < 3000; i = i + 1) begin
            #waittime;
        end

        $finish;

        // Expected result is Sqrt(4) = 2 (= 0x40000000 = 0b01000000000000000000000000000000)
    end

    FP_Sqrt FP_Sqrt_Inst0(
        .in_data(in_data),
        .in_Clk(in_Clk),
        .in_Rst_N(in_Rst_N),
        .in_start(in_start),
        .out_data(out_data),
        .out_stall(out_stall)
    );
endmodule