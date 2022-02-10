module Datapath(in_ctrl_signal, in_inst, in_DM_data, Rst_N, Clk, out_inst_addr, out_addr, out_wr_data, out_flag);
    input   Clk, Rst_N;
    input   [21:0] in_ctrl_signal;
    input   [31:0] in_inst;
    input   [63:0] in_DM_data;

    output  [63:0] out_inst_addr, out_addr, out_wr_data;
    output  [4:0] out_flag;

    // Control signals
    // parameter PAM_int_RF_wr_dat_src = in_ctrl_signal[22:20];    // Integer register file write data source
    // parameter PAM_fp_RF_wr_dat_src = in_ctrl_signal[19:18];     // FP register file write data source
    // parameter PAM_int_RF_we = in_ctrl_signal[17];               // Integer register file write enable
    // parameter PAM_fp_RF_we = in_ctrl_signal[16];                // FP register file write enable
    // parameter PAM_inst_type = in_ctrl_signal[15:13];            // Instruction type
    // parameter PAM_PC_src = in_ctrl_signal[12:11];               // PC source
    // parameter PAM_rs2_src = in_ctrl_signal[10];                 // rs2 source
    // parameter PAM_wr_dat_src = in_ctrl_signal[9];               // Write data source
    // parameter PAM_ALU_Op = in_ctrl_signal[8:5];                 // ALU operation code
    // parameter PAM_FPU_Op = in_ctrl_signal[4:1];                 // FPU operation code

    // Internal wires
    wire    [31:0] fp_RF_out_A, fp_RF_out_B, fp_RF_write_data, fp_wr_dat_wire_1;
    wire    [63:0] int_RF_out_A, int_RF_out_B, FPU_Out, ImmGen_Out, PC_Src, rs2_Src, PC_Src_wire_1, int_RF_write_data, int_wr_dat_wire_1, int_wr_dat_wire_2, int_wr_dat_wire_3, PC_Add_Four, PC_Add_Imm, PC_From_ALU, PC_data;

    assign rs2_Src = (in_ctrl_signal[9]) ? ImmGen_Out : int_RF_out_B;
    assign out_wr_data = (in_ctrl_signal[8]) ? {32'd0, fp_RF_out_B} : int_RF_out_B;

    // PC Source
    assign PC_Add_Four = out_inst_addr + 64'd4;
    assign PC_Add_Imm = out_inst_addr + ImmGen_Out;
    assign PC_From_ALU = out_addr;
    assign PC_Src = (!in_ctrl_signal[11] & !in_ctrl_signal[10]) ? PC_Add_Four : PC_Src_wire_1;
    assign PC_Src_wire_1 = (!in_ctrl_signal[11] & in_ctrl_signal[10]) ? PC_Add_Imm : PC_From_ALU;

    // Integer Register File Write Data Source
    assign int_RF_write_data = (!in_ctrl_signal[21] & !in_ctrl_signal[20] & !in_ctrl_signal[19]) ? in_DM_data : int_wr_dat_wire_1;
    assign int_wr_dat_wire_1 = (!in_ctrl_signal[21] & !in_ctrl_signal[20] & in_ctrl_signal[19]) ? PC_Add_Four : int_wr_dat_wire_2;
    assign int_wr_dat_wire_2 = (!in_ctrl_signal[21] & in_ctrl_signal[20] & !in_ctrl_signal[19]) ? out_addr : int_wr_dat_wire_3;
    assign int_wr_dat_wire_3 = (!in_ctrl_signal[21] & in_ctrl_signal[20] & in_ctrl_signal[19]) ? FPU_Out : PC_Add_Imm;

    // FP Register File Write Data Source
    assign fp_RF_write_data = (!in_ctrl_signal[18] & !in_ctrl_signal[17]) ? in_DM_data[31:0] : fp_wr_dat_wire_1;
    assign fp_wr_dat_wire_1 = (!in_ctrl_signal[18] & in_ctrl_signal[17]) ? out_addr[31:0] : FPU_Out[31:0];

    REG PC_Reg_Inst0(
        .in_data(PC_Src),
        .out_data(out_inst_addr),
        .Clk(Clk),
        .Rst(Rst_N)
    );
    ImmGen ImmGen_Inst0 (
        .in_data(in_inst),
        .in_inst_type(in_ctrl_signal[14:12]),
        .out_data(ImmGen_Out)
    );
    ALU ALU_Inst0(
        .in_rs1(int_RF_out_A),
        .in_rs2(rs2_Src),
        .in_ALU_Op(in_ctrl_signal[7:4]),
        .in_fmt(in_inst[21:20]),
        .in_aShift_ctrl(in_inst[30]),
        .out_data(out_addr),
        .out_ALU_flag(out_flag)
    );
    FP_Unit FP_Unit_Inst0(
        .in_rs1(fp_RF_out_A),
        .in_rs2(fp_RF_out_B),
        .out_data(FPU_Out),
        .in_FPU_Op(in_ctrl_signal[3:0]),
        .in_fmt(in_inst[21:20]),
        .in_addsub_ctrl(in_inst[27]),
        .in_ctrl_minmax_sgnj_cmp(in_inst[14:12])
    );
    RegisterFile RegisterFile_Inst0 (
        .data_in(int_RF_write_data),
        .data_outA(int_RF_out_A),
        .data_outB(int_RF_out_B),
        .addr_A(in_inst[19:15]),
        .addr_B(in_inst[24:20]),
        .writeAddr(in_inst[11:7]),
        .write_En(in_ctrl_signal[16]),
        .Clk(Clk)
    );
    FP_RegisterFile FP_RegisterFile_Inst0(
        .data_in(fp_RF_write_data),
        .data_outA(fp_RF_out_A),
        .data_outB(fp_RF_out_B),
        .addr_A(in_inst[19:15]),
        .addr_B(in_inst[24:20]),
        .writeAddr(in_inst[11:7]),
        .write_En(in_ctrl_signal[15]),
        .Clk(Clk)
    );
endmodule