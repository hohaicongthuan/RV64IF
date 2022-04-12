module Datapath(in_ctrl_signal, in_inst, in_DM_data, Rst_N, Clk, out_inst_addr, out_addr, out_wr_data, out_flag, out_DM_write_en, out_prediction);
    input   Clk, Rst_N;
    input   [23:0] in_ctrl_signal;
    input   [31:0] in_inst;
    input   [63:0] in_DM_data;

    output  out_DM_write_en, out_prediction;
    output  [63:0] out_inst_addr, out_addr, out_wr_data;
    output  [4:0] out_flag;

    // Data buffers
    parameter   if_id_dat_buff_size = 224;
    parameter   id_ex_dat_buff_size = 325;
    parameter   ex_mem_dat_buff_size = 325;
    parameter   mem_wb_dat_buff_size = 325;

    // Control buffers
    parameter   if_id_ctrl_buff_size = 26;
    parameter   id_ex_ctrl_buff_size = 25;
    parameter   ex_mem_ctrl_buff_size = 8;
    parameter   mem_wb_ctrl_buff_size = 7;

    ////////////////////
    // INTERNAL WIRES //
    ////////////////////
    wire    stall_signal;
    wire    [25:0] if_id_ctrl_buff_in, if_id_ctrl_buff_out;
    wire    [24:0] id_ex_ctrl_buff_in, id_ex_ctrl_buff_out;
    wire    [ 7:0] ex_mem_ctrl_buff_in, ex_mem_ctrl_buff_out;
    wire    [ 6:0] mem_wb_ctrl_buff_in, mem_wb_ctrl_buff_out;

    wire    [31:0] fp_RF_out_A, fp_RF_out_B, fp_wr_dat_wire_1;
    wire    [63:0] int_RF_out_A, int_RF_out_B, FPU_Out, ImmGen_Out, PC_Src, rs2_Src, PC_Src_wire_1, int_RF_write_data, int_wr_dat_wire_1, int_wr_dat_wire_2, int_wr_dat_wire_3, PC_Add_Four, PC_Add_Imm, PC_From_ALU, PC_data, ALU_Out, DM_data_src, fp_RF_write_data;
    wire    [223:0] if_id_dat_buff_in, if_id_dat_buff_out;
    wire    [324:0] id_ex_dat_buff_in, id_ex_dat_buff_out, ex_mem_dat_buff_in, ex_mem_dat_buff_out, mem_wb_dat_buff_in, mem_wb_dat_buff_out;

    assign out_addr     = ex_mem_dat_buff_out[196:133];
    assign rs2_Src      = (if_id_ctrl_buff_out[17]) ? if_id_dat_buff_out[63:0] : int_RF_out_B;
    assign out_wr_data  = ex_mem_dat_buff_out[68:5];
    assign DM_data_src  = (id_ex_ctrl_buff_out[16]) ? {32'd0, id_ex_dat_buff_out[36:5]} : id_ex_dat_buff_out[132:69];

    // PC Source
    assign PC_Add_Four      = out_inst_addr + 64'd4;
    assign PC_Add_Imm       = out_inst_addr + ImmGen_Out;
    assign PC_From_ALU      = ALU_Out;
    
    mux_4_1 #(.DATA_WIDTH(64)) PC_Src_Mux (
        .in_data_0(PC_Add_Four),
        .in_data_1(PC_Add_Imm),
        .in_data_2(PC_From_ALU),
        .in_data_3(64'd0),
        .out_data(PC_Src),
        .in_sel(in_ctrl_signal[12:11])
    );

    // Integer Register File Write Data Source
    mux_8_1 #(.DATA_WIDTH(64)) int_rf_dat_src_mux (
        .in_data_0(mem_wb_dat_buff_out[68:5]),      // DMEM Data
        .in_data_1(mem_wb_dat_buff_out[260:197]),   // PC + 4
        .in_data_2(mem_wb_dat_buff_out[196:133]),   // ALU Out
        .in_data_3(mem_wb_dat_buff_out[132:69]),    // FPU Out
        .in_data_4(mem_wb_dat_buff_out[324:261]),   // PC + Immediate
        .in_data_5(64'd0),
        .in_data_6(64'd0),
        .in_data_7(64'd0),
        .in_sel(mem_wb_ctrl_buff_out[6:4]),
        .out_data(int_RF_write_data)
    );

    // FP Register File Write Data Source
    mux_4_1 #(.DATA_WIDTH(64)) fp_rf_dat_src_mux (
        .in_data_0(mem_wb_dat_buff_out[68:5]),      // DMEM Data
        .in_data_1(mem_wb_dat_buff_out[196:133]),   // ALU Out
        .in_data_2(mem_wb_dat_buff_out[132:69]),    // FPU Out
        .in_data_3(64'd0),
        .out_data(fp_RF_write_data),
        .in_sel(mem_wb_ctrl_buff_out[3:2])
    );

    assign out_DM_write_en = ex_mem_ctrl_buff_out[0];

    //////////////////
    // DATA BUFFERS //
    //////////////////
    // IF - ID Buffer
    REG #(.DATA_WIDTH(if_id_dat_buff_size)) if_id_dat_buff(
        .in_data(if_id_dat_buff_in),
        .out_data(if_id_dat_buff_out),
        .Clk(Clk),
        .Rst_N(Rst_N),
        .En(!stall_signal)
    );
    assign if_id_dat_buff_in = {PC_Add_Imm, PC_Add_Four, in_inst, ImmGen_Out};

    // ID - EX Buffer
    REG #(.DATA_WIDTH(id_ex_dat_buff_size)) id_ex_dat_buff(
        .in_data(id_ex_dat_buff_in),
        .out_data(id_ex_dat_buff_out),
        .Clk(Clk),
        .Rst_N(Rst_N),
        .En(!stall_signal)
    );
    assign id_ex_dat_buff_in = {if_id_dat_buff_out[223:96], int_RF_out_A, rs2_Src, fp_RF_out_A, fp_RF_out_B, if_id_dat_buff_out[75:71]};

    // EX - MEM Data Buffer
    REG #(.DATA_WIDTH(ex_mem_dat_buff_size)) ex_mem_dat_buff(
        .in_data(ex_mem_dat_buff_in),
        .out_data(ex_mem_dat_buff_out),
        .Clk(Clk),
        .Rst_N(Rst_N),
        .En(!stall_signal)
    );
    assign ex_mem_dat_buff_in = {id_ex_dat_buff_out[324:197], ALU_Out, FPU_Out, DM_data_src, id_ex_dat_buff_out[4:0]};

    // MEM - WB Data Buffer
    REG #(.DATA_WIDTH(mem_wb_dat_buff_size)) mem_wb_dat_buff(
        .in_data(mem_wb_dat_buff_in),
        .out_data(mem_wb_dat_buff_out),
        .Clk(Clk),
        .Rst_N(Rst_N),
        .En(!stall_signal)
    );
    assign mem_wb_dat_buff_in = {ex_mem_dat_buff_out[324:69], in_DM_data, ex_mem_dat_buff_out[4:0]};

    /////////////////////
    // CONTROL BUFFERS //
    /////////////////////
    // IF - ID Control Buffer
    REG #(.DATA_WIDTH(if_id_ctrl_buff_size)) if_id_ctrl_buff(
        .in_data(if_id_ctrl_buff_in),
        .out_data(if_id_ctrl_buff_out),
        .Clk(Clk),
        .Rst_N(Rst_N),
        .En(!stall_signal)
    );
    assign if_id_ctrl_buff_in = {in_ctrl_signal[23:16], in_ctrl_signal[10:0], in_inst[21:20], in_inst[30], in_inst[27], in_inst[14:12]};

    // ID - EX Control Buffer
    REG #(.DATA_WIDTH(id_ex_ctrl_buff_size)) id_ex_ctrl_buff(
        .in_data(id_ex_ctrl_buff_in),
        .out_data(id_ex_ctrl_buff_out),
        .Clk(Clk),
        .Rst_N(Rst_N),
        .En(!stall_signal)
    );
    assign id_ex_ctrl_buff_in = {if_id_ctrl_buff_out[25:18], if_id_ctrl_buff_out[16:0]};

    // EX - MEM Control Buffer
    REG #(.DATA_WIDTH(ex_mem_ctrl_buff_size)) ex_mem_ctrl_buff(
        .in_data(ex_mem_ctrl_buff_in),
        .out_data(ex_mem_ctrl_buff_out),
        .Clk(Clk),
        .Rst_N(Rst_N),
        .En(!stall_signal)
    );
    assign ex_mem_ctrl_buff_in = {id_ex_ctrl_buff_out[23:17], id_ex_ctrl_buff_out[7]};

    // MEM - WB Control Buffer
    REG #(.DATA_WIDTH(mem_wb_ctrl_buff_size)) mem_wb_ctrl_buff(
        .in_data(mem_wb_ctrl_buff_in),
        .out_data(mem_wb_ctrl_buff_out),
        .Clk(Clk),
        .Rst_N(Rst_N),
        .En(!stall_signal)
    );
    assign mem_wb_ctrl_buff_in = {ex_mem_ctrl_buff_out[7:1]};

    ///////////////////////
    // PROGRAMME COUNTER //
    ///////////////////////
    REG PC_Reg_Inst0(
        .in_data(PC_Src),
        .out_data(out_inst_addr),
        .Clk(Clk),
        .Rst_N(Rst_N),
        .En(!stall_signal)
    );

    /////////////////////////
    // IMMEDIATE GENERATOR //
    /////////////////////////
    ImmGen ImmGen_Inst0 (
        .in_data(in_inst),
        .in_inst_type(in_ctrl_signal[15:13]),
        .out_data(ImmGen_Out)
    );

    /////////////////////////////
    // ARITHMETIC & LOGIC UNIT //
    /////////////////////////////
    ALU ALU_Inst0(
        .in_rs1(id_ex_dat_buff_out[196:133]),
        .in_rs2(id_ex_dat_buff_out[132:69]),
        .in_ALU_Op(id_ex_ctrl_buff_out[15:12]),
        .in_fmt(id_ex_ctrl_buff_out[6:5]),
        .in_aShift_ctrl(id_ex_ctrl_buff_out[4]),
        .out_data(ALU_Out),
        .out_ALU_flag(out_flag)
    );

    /////////////////////////
    // FLOATING-POINT UNIT //
    /////////////////////////
    FP_Unit FP_Unit_Inst0(
        .in_rs1(id_ex_dat_buff_out[68:37]),
        .in_rs2(id_ex_dat_buff_out[36:5]),
        .out_data(FPU_Out),
        .in_FPU_Op(id_ex_ctrl_buff_out[11:8]),
        .in_fmt(id_ex_ctrl_buff_out[6:5]),
        .in_addsub_ctrl(id_ex_ctrl_buff_out[3]),
        .in_ctrl_minmax_sgnj_cmp(id_ex_ctrl_buff_out[2:0]),
        .in_Clk(Clk),
        .in_Rst_N(Rst_N),
        .in_start(id_ex_ctrl_buff_out[24]),
        .out_stall(stall_signal)
    );

    ///////////////////////////
    // INTEGER REGISTER FILE //
    ///////////////////////////
    RegisterFile RegisterFile_Inst0 (
        .in_data(int_RF_write_data),
        .out_data_A(int_RF_out_A),
        .out_data_B(int_RF_out_B),
        .in_addr_A(if_id_dat_buff_out[83:79]),
        .in_addr_B(if_id_dat_buff_out[88:84]),
        .in_writeAddr(mem_wb_dat_buff_out[4:0]),
        .in_write_En(mem_wb_ctrl_buff_out[1]),
        .in_Clk(Clk),
        .in_Rst_N(Rst_N)
    );

    //////////////////////////////////
    // FLOATING-POINT REGISTER FILE //
    //////////////////////////////////
    FP_RegisterFile FP_RegisterFile_Inst0(
        .in_data(fp_RF_write_data[31:0]),
        .out_data_A(fp_RF_out_A),
        .out_data_B(fp_RF_out_B),
        .in_addr_A(if_id_dat_buff_out[83:79]),
        .in_addr_B(if_id_dat_buff_out[88:84]),
        .in_writeAddr(mem_wb_dat_buff_out[4:0]),
        .in_write_En(mem_wb_ctrl_buff_out[0]),
        .in_Clk(Clk),
        .in_Rst_N(Rst_N)
    );

    ////////////////////////////
    // BRANCH PREDICTION UNIT //
    ////////////////////////////
    BPU BPU_Inst0(
        .in_PC(out_inst_addr[8:0]),
        .in_hit(2'b11),
        .in_Clk(Clk),
        .in_Rst_N(Rst_N),
        .out_prediction(out_prediction)
    );
endmodule