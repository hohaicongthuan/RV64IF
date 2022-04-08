# These instructions are used to test different instructions in RV64IF

main:
    addi sp, x0, 0

    # BASE INTEGER INSTRUCTIONS
    jal ra, addi_inst
    addi sp, sp, 8
    jal ra, slti_inst
    addi sp, sp, 8
    jal ra, andi_inst
    addi sp, sp, 8
    jal ra, ori_inst
    addi sp, sp, 8
    jal ra, xori_inst
    addi sp, sp, 8
    jal ra, sltiu_inst
    addi sp, sp, 8
    jal ra, slli_inst
    addi sp, sp, 8
    jal ra, srli_inst
    addi sp, sp, 8
    jal ra, srai_inst
    addi sp, sp, 8
    jal ra, lui_inst
    addi sp, sp, 8
    # jal ra, auipc_inst
    # addi sp, sp, 8
    jal ra, add_inst
    addi sp, sp, 8
    jal ra, slt_inst
    addi sp, sp, 8
    jal ra, sltu_inst
    addi sp, sp, 8
    jal ra, and_inst
    addi sp, sp, 8
    jal ra, or_inst
    addi sp, sp, 8
    jal ra, xor_inst
    addi sp, sp, 8
    jal ra, sll_inst
    addi sp, sp, 8
    jal ra, srl_inst
    addi sp, sp, 8
    jal ra, sub_inst
    addi sp, sp, 8
    jal ra, sra_inst
    addi sp, sp, 8

    # FLOATING-POINT INSTRUCTIONS
    jal ra, fadd_s_inst
    addi sp, sp, 8
    jal ra, fsub_s_inst
    addi sp, sp, 8
    jal ra, fmul_s_inst
    addi sp, sp, 8
    jal ra, fdiv_s_inst
    addi sp, sp, 8
    jal ra, fmin_s_inst
    addi sp, sp, 8
    jal ra, fmax_s_inst
    addi sp, sp, 8
    jal ra, fcvt_w_s_inst
    addi sp, sp, 8
    jal ra, fcvt_s_w_inst
    addi sp, sp, 8
    jal ra, fcvt_l_s_inst
    addi sp, sp, 8
    jal ra, fcvt_s_l_inst
    addi sp, sp, 8
    jal ra, fsgnj_s_inst
    addi sp, sp, 8
    jal ra, fsgnjn_s_inst
    addi sp, sp, 8
    jal ra, fsgnjx_s_inst
    addi sp, sp, 8
    jal ra, feq_s_inst
    addi sp, sp, 8
    jal ra, flt_s_inst
    addi sp, sp, 8
    jal ra, fle_s_inst
    addi sp, sp, 8

    # BRANCH INSTRUCTIONS
    jal ra, bne_inst
    addi sp, sp, 8
    jal ra, blt_inst
    addi sp, sp, 8
    jal ra, bge_inst
    addi sp, sp, 8
    jal ra, bltu_inst
    addi sp, sp, 8
    jal ra, bgeu_inst

    j HALT        # Halts the programme

#############################
# ADD IMMEDIATE INSTRUCTION #
#############################    
addi_inst:
    addi t1, x0, 123
    addi t2, x0, 123
    beq t1, t2, addi_inst_true
    j addi_inst_false
addi_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j addi_inst_ret
addi_inst_false:
    sd x0, 0(sp)
addi_inst_ret:
    ret

############################################
# SET (IF) LESS THAN IMMEDIATE INSTRUCTION #
############################################
slti_inst:
    addi t1, x0, 120
    slti t0, t1, 123
    sd t0, 0(sp)
    addi sp, sp, 8
    addi t1, x0, 255
    slti t0, t1, 123
    sd t0, 0(sp)
    ret

#######################################
# (LOGICAL) AND IMMEDIATE INSTRUCTION #
#######################################
andi_inst:
    addi t1, x0, 123
    andi t2, t1, 456        # 123 AND 456 = 72
    addi t3, x0, 72
    beq t2, t3, andi_inst_true
    j andi_inst_false
andi_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j andi_inst_ret
andi_inst_false:
    sd x0, 0(sp)
andi_inst_ret:
    ret

######################################
# (LOGICAL) OR IMMEDIATE INSTRUCTION #
######################################
ori_inst:
    addi t1, x0, 123
    ori t2, t1, 456        # 123 OR 456 = 507
    addi t3, x0, 507
    beq t2, t3, ori_inst_true
    j ori_inst_false
ori_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j ori_inst_ret
ori_inst_false:
    sd x0, 0(sp)
ori_inst_ret:
    ret

#######################################
# (LOGICAL) XOR IMMEDIATE INSTRUCTION #
#######################################
xori_inst:
    addi t1, x0, 123
    xori t2, t1, 456        # 123 XOR 456 = 435
    addi t3, x0, 435
    beq t2, t3, xori_inst_true
    j xori_inst_false
xori_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j xori_inst_ret
xori_inst_false:
    sd x0, 0(sp)
xori_inst_ret:
    ret

#####################################################
# SET (IF) LESS THAN IMMEDIATE UNSIGNED INSTRUCTION #
#####################################################
sltiu_inst:
    addi t1, x0, 120
    sltiu t0, t1, 123
    sd t0, 0(sp)
    addi sp, sp, 8
    addi t1, x0, 255
    sltiu t0, t1, 123
    sd t0, 0(sp)
    ret

############################################
# SHIFT LEFT LOGICAL IMMEDIATE INSTRUCTION #
############################################
slli_inst:
    addi t1, x0, 1
    slli t2, t1, 3          # 1 << 3 = 8
    addi t3, x0, 8
    beq t2, t3, slli_inst_true
    j slli_inst_false
slli_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j slli_inst_ret
slli_inst_false:
    sd x0, 0(sp)
slli_inst_ret:
    ret

#############################################
# SHIFT RIGHT LOGICAL IMMEDIATE INSTRUCTION #
#############################################
srli_inst:
    addi t1, x0, 16
    srli t2, t1, 3          # 16 >> 3 = 2
    addi t3, x0, 2
    beq t2, t3, srli_inst_true
    j srli_inst_false
srli_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j srli_inst_ret
srli_inst_false:
    sd x0, 0(sp)
srli_inst_ret:
    ret

################################################
# SHIFT RIGHT ARITHMETIC IMMEDIATE INSTRUCTION #
################################################
srai_inst:
    addi t1, x0, -16
    srai t2, t1, 3          # -16 >>> 3 = -2
    addi t3, x0, -2
    beq t2, t3, srai_inst_true
    j srai_inst_false
srai_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j srai_inst_ret
srai_inst_false:
    sd x0, 0(sp)
srai_inst_ret:
    ret

####################################
# LOAD UPPER IMMEDIATE INSTRUCTION #
####################################
lui_inst:
    lui t1, 1               # t1 = 4096
    addi t2, x0, 1
    slli t2, t2, 12         # t2 = 1 << 12 = 4096
    beq t1, t2, lui_inst_true
    j lui_inst_false
lui_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j lui_inst_ret
lui_inst_false:
    sd x0, 0(sp)
lui_inst_ret:
    ret

# auipc_inst:
#     ret

###################
# ADD INSTRUCTION #
###################
add_inst:
    addi t1, x0, 123
    addi t2, x0, 456
    add t3, t1, t2          # 123 + 456 = 579
    addi t4, x0, 579
    beq t3, t4, add_inst_true
    j add_inst_false
add_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j add_inst_ret
add_inst_false:
    sd x0, 0(sp)
add_inst_ret:
    ret

##################################
# SET (IF) LESS THAN INSTRUCTION #
##################################
slt_inst:
    addi t1, x0, 123
    addi t2, x0, 456
    slt t3, t1, t2          # 123 < 456 = 1
    addi t4, x0, 1
    beq t3, t4, slt_inst_true
    j slt_inst_false
slt_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j slt_inst_ret
slt_inst_false:
    sd x0, 0(sp)
slt_inst_ret:
    ret

###########################################
# SET (IF) LESS THAN UNSIGNED INSTRUCTION #
###########################################
sltu_inst:
    addi t1, x0, 123
    addi t2, x0, 456
    sltu t3, t1, t2          # 123 < 456 = 1
    addi t4, x0, 1
    beq t3, t4, sltu_inst_true
    j sltu_inst_false
sltu_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j sltu_inst_ret
sltu_inst_false:
    sd x0, 0(sp)
sltu_inst_ret:
    ret

#############################
# (LOGICAL) AND INSTRUCTION #
#############################
and_inst:
    addi t1, x0, 123
    addi t2, x0, 678
    and t3, t1, t2          # 123 AND 678 = 34
    addi t4, x0, 34
    beq t3, t4, and_inst_true
    j and_inst_false
and_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j and_inst_ret
and_inst_false:
    sd x0, 0(sp)
and_inst_ret:
    ret

############################
# (LOGICAL) OR INSTRUCTION #
############################
or_inst:
    addi t1, x0, 123
    addi t2, x0, 678
    or t3, t1, t2          # 123 OR 678 = 767
    addi t4, x0, 767
    beq t3, t4, or_inst_true
    j or_inst_false
or_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j or_inst_ret
or_inst_false:
    sd x0, 0(sp)
or_inst_ret:
    ret

#############################
# (LOGICAL) XOR INSTRUCTION #
#############################
xor_inst:
    addi t1, x0, 123
    addi t2, x0, 678
    xor t3, t1, t2          # 123 XOR 678 = 733
    addi t4, x0, 733
    beq t3, t4, xor_inst_true
    j xor_inst_false
xor_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j xor_inst_ret
xor_inst_false:
    sd x0, 0(sp)
xor_inst_ret:
    ret

##################################
# SHIFT LEFT LOGICAL INSTRUCTION #
##################################
sll_inst:
    addi t1, x0, 1
    addi t2, x0, 3
    sll t3, t1, t2          # 1 << 3 = 8
    addi t4, x0, 8
    beq t3, t4, sll_inst_true
    j sll_inst_false
sll_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j sll_inst_ret
sll_inst_false:
    sd x0, 0(sp)
sll_inst_ret:
    ret

###################################
# SHIFT RIGHT LOGICAL INSTRUCTION #
###################################
srl_inst:
    addi t1, x0, 16
    addi t2, x0, 3
    srl t3, t1, t2          # 16 >> 3 = 2
    addi t4, x0, 2
    beq t3, t4, srl_inst_true
    j srl_inst_false
srl_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j srl_inst_ret
srl_inst_false:
    sd x0, 0(sp)
srl_inst_ret:
    ret

########################
# SUBTRACT INSTRUCTION #
########################
sub_inst:
    addi t1, x0, 123
    addi t2, x0, 456
    sub t3, t1, t2          # 123 - 456 = -333
    addi t4, x0, -333
    beq t3, t4, sub_inst_true
    j sub_inst_false
sub_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j sub_inst_ret
sub_inst_false:
    sd x0, 0(sp)
sub_inst_ret:
    ret

######################################
# SHIFT RIGHT ARITHMETIC INSTRUCTION #
######################################
sra_inst:
    addi t1, x0, -16
    addi t2, x0, 3
    sra t3, t1, t2          # -16 >>> 3 = -2
    addi t4, x0, -2
    beq t3, t4, sra_inst_true
    j sra_inst_false
sra_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j sra_inst_ret
sra_inst_false:
    sd x0, 0(sp)
sra_inst_ret:
    ret

# Floating-point instructions

######################
# FP ADD INSTRUCTION #
######################
# 0.01 = 0x3C23D70A
fadd_s_inst:
    li t1, 0x42F6E979               # t1 = 123.456
    fmv.w.x ft1, t1
    li t2, 0x414570A4               # t2 = 12.34
    fmv.w.x ft2, t2
    fadd.s ft3, ft1, ft2            # ft3 = ft1 + ft2 = 123.456 + 12.34 = 135.796
    li t4, 0x4307CBC7               # t4 = 135.796
    fmv.w.x ft4, t4
    fsub.s ft5, ft3, ft4
    li t3, 0x3C23D70A               # t3 = 0.01
    fmv.w.x ft6, t3
    fle.s t0, ft5, ft6
    sd t0, 0(sp)
    ret

###########################
# FP SUBTRACT INSTRUCTION #
###########################
fsub_s_inst:
    li t1, 0x42F6E979               # t1 = 123.456
    fmv.w.x ft1, t1
    li t2, 0x414570A4               # t2 = 12.34
    fmv.w.x ft2, t2
    fsub.s ft3, ft1, ft2            # ft3 = ft1 - ft2 = 123.456 - 12.34 = 111.116
    li t4, 0x42DE3B64               # t4 = 111.116
    fmv.w.x ft4, t4
    fsub.s ft5, ft3, ft4
    li t3, 0x3C23D70A               # t3 = 0.01
    fmv.w.x ft6, t3
    fle.s t0, ft5, ft6
    sd t0, 0(sp)
    ret

#################################
# FP MULTIPLICATION INSTRUCTION #
#################################
fmul_s_inst:
    li t1, 0x42F6E979               # t1 = 123.456
    fmv.w.x ft1, t1
    li t2, 0x414570A4               # t2 = 12.34
    fmv.w.x ft2, t2
    fmul.s ft3, ft1, ft2            # ft3 = ft1 * ft2 = 123.456 * 12.34 = 1523.447
    li t4, 0x44BE6E4E               # t4 = 1523.447
    fmv.w.x ft4, t4
    fsub.s ft5, ft3, ft4
    li t3, 0x3C23D70A               # t3 = 0.01
    fmv.w.x ft6, t3
    fle.s t0, ft5, ft6
    sd t0, 0(sp)
    ret

###########################
# FP DIVISION INSTRUCTION #
###########################
fdiv_s_inst:
    li t1, 0x42F6E979               # t1 = 123.456
    fmv.w.x ft1, t1
    li t2, 0x414570A4               # t2 = 12.34
    fmv.w.x ft2, t2
    fdiv.s ft3, ft1, ft2            # ft3 = ft1 / ft2 = 123.456 / 12.34 = 10.004539
    li t4, 0x41201297               # t4 = 10.004539
    fmv.w.x ft4, t4
    fsub.s ft5, ft3, ft4
    li t3, 0x3C23D70A               # t3 = 0.01
    fmv.w.x ft6, t3
    fle.s t0, ft5, ft6
    sd t0, 0(sp)
    ret

##########################
# FP MINIMUM INSTRUCTION #
##########################
fmin_s_inst:
    li t1, 0x42F6E979               # t1 = 123.456
    fmv.w.x ft1, t1
    li t2, 0x414570A4               # t2 = 12.34
    fmv.w.x ft2, t2
    fmin.s ft3, ft1, ft2            # ft3 = min(ft1, ft2) = 12.34
    li t4, 0x414570A4               # t4 = 12.34
    fmv.w.x ft4, t4
    feq.s t0, ft3, ft4
    sd t0, 0(sp)
    ret

##########################
# FP MAXIMUM INSTRUCTION #
##########################
fmax_s_inst:
    li t1, 0x42F6E979               # t1 = 123.456
    fmv.w.x ft1, t1
    li t2, 0x414570A4               # t2 = 12.34
    fmv.w.x ft2, t2
    fmax.s ft3, ft1, ft2            # ft3 = max(ft1, ft2) = 123.456
    li t4, 0x42F6E979               # t4 = 123.456
    fmv.w.x ft4, t4
    feq.s t0, ft3, ft4
    sd t0, 0(sp)
    ret

###############################################
# FP TO 32-BIT INTEGER CONVERSION INSTRUCTION #
###############################################
fcvt_w_s_inst:
    li t1, 0x41291614               # t1 = 10.56789
    fmv.w.x ft1, t1
    fcvt.w.s t3, ft1
    li t2, 10                       # t2 = 10
    beq t2, t3, fcvt_w_s_inst_true
    j fcvt_w_s_inst_false
fcvt_w_s_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j fcvt_w_s_inst_ret
fcvt_w_s_inst_false:
    sd x0, 0(sp)
fcvt_w_s_inst_ret:
    ret

###############################################
# 32-BIT INTEGER TO FP CONVERSION INSTRUCTION #
###############################################
fcvt_s_w_inst:
    li t1, 123
    fcvt.s.w ft1, t1
    fmv.x.w t2, ft1
    li t3, 0x42F60000               # t3 = 123.0
    beq t2, t3, fcvt_s_w_inst_true
    j fcvt_s_w_inst_false
fcvt_s_w_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j fcvt_s_w_inst_ret
fcvt_s_w_inst_false:
    sd x0, 0(sp)
fcvt_s_w_inst_ret:
    ret

###############################################
# FP TO 64-BIT INTEGER CONVERSION INSTRUCTION #
###############################################
fcvt_l_s_inst:
    li t1, 0x41291614               # t1 = 10.56789
    fmv.w.x ft1, t1
    fcvt.l.s t3, ft1
    li t2, 10                       # t2 = 10
    beq t2, t3, fcvt_l_s_inst_true
    j fcvt_l_s_inst_false
fcvt_l_s_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j fcvt_l_s_inst_ret
fcvt_l_s_inst_false:
    sd x0, 0(sp)
fcvt_l_s_inst_ret:
    ret

###############################################
# 64-BIT INTEGER TO FP CONVERSION INSTRUCTION #
###############################################
fcvt_s_l_inst:
    li t1, 123
    fcvt.s.l ft1, t1
    fmv.x.w t2, ft1
    li t3, 0x42F60000               # t3 = 123.0
    beq t2, t3, fcvt_s_l_inst_true
    j fcvt_s_l_inst_false
fcvt_s_l_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j fcvt_s_l_inst_ret
fcvt_s_l_inst_false:
    sd x0, 0(sp)
fcvt_s_l_inst_ret:
    ret

#################################
# FP SIGN INJECTION INSTRUCTION #
#################################
fsgnj_s_inst:
    li t1, 0x4212B3CB               # t1 = 36.67558
    fmv.w.x ft1, t1
    li t2, 0xC2F6B180               # t2 = -123.34668
    fmv.w.x ft2, t2
    li t3, 0xC212B3CB               # t3 = -36.67558
    fmv.w.x ft3, t3
    fsgnj.s ft4, ft1, ft2           # ft4 = -36.67558
    feq.s t0, ft3, ft4
    sd t0, 0(sp)
    ret

#########################################
# FP SIGN INJECTION NEGATED INSTRUCTION #
#########################################
fsgnjn_s_inst:
    li t1, 0x4212B3CB               # t1 = 36.67558
    fmv.w.x ft1, t1
    li t2, 0xC2F6B180               # t2 = -123.34668
    fmv.w.x ft2, t2
    li t3, 0x4212B3CB               # t3 = 36.67558
    fmv.w.x ft3, t3
    fsgnjn.s ft4, ft1, ft2           # ft4 = 36.67558
    feq.s t0, ft3, ft4
    sd t0, 0(sp)
    ret

########################################
# FP SIGN INJECTION XOR-ED INSTRUCTION #
########################################
fsgnjx_s_inst:
    li t1, 0x4212B3CB               # t1 = 36.67558
    fmv.w.x ft1, t1
    li t2, 0xC2F6B180               # t2 = -123.34668
    fmv.w.x ft2, t2
    li t3, 0xC212B3CB               # t3 = -36.67558
    fmv.w.x ft3, t3
    fsgnjx.s ft4, ft1, ft2           # ft4 = -36.67558
    feq.s t0, ft3, ft4
    sd t0, 0(sp)
    ret

###################################
# FP EQUAL COMPARISON INSTRUCTION #
###################################
feq_s_inst:
    li t1, 0x414570A4               # t1 = 12.34
    fmv.w.x ft1, t1
    li t2, 0x42F6E979               # t2 = 123.456
    fmv.w.x ft2, t2
    feq.s t0, ft1, ft2
    beq t0, x0, feq_s_inst_true
    j feq_s_inst_false
feq_s_inst_true:
    addi t0, x0, 1
    sd t0, 0(sp)
    j feq_s_inst_ret
feq_s_inst_false:
    sd x0, 0(sp)
feq_s_inst_ret:
    ret

#######################################
# FP LESS THAN COMPARISON INSTRUCTION #
#######################################
flt_s_inst:
    li t1, 0x414570A4               # t1 = 12.34
    fmv.w.x ft1, t1
    li t2, 0x42F6E979               # t2 = 123.456
    fmv.w.x ft2, t2
    flt.s t0, ft1, ft2
    sd t0, 0(sp)
    ret

################################################
# FP LESS THAN OR EQUAL COMPARISON INSTRUCTION #
################################################
fle_s_inst:
    li t1, 0x414570A4               # t1 = 12.34
    fmv.w.x ft1, t1
    li t2, 0x42F6E979               # t2 = 123.456
    fmv.w.x ft2, t2
    fle.s t0, ft1, ft2
    sd t0, 0(sp)
    ret

################################################################
# MOVE NUMBER FROM INTEGER REGISTER TO FP REGISTER INSTRUCTION #
################################################################
# fmv_x_w:
#     ret

################################################################
# MOVE NUMBER FROM FP REGISTER TO INTEGER REGISTER INSTRUCTION #
################################################################
# fmv_w_x:
#     ret

#####################################
# BRANCH (IF) NOT EQUAL INSTRUCTION #
#####################################
bne_inst:
    li t1, 1
    li t2, 2
    bne t1, t2, bne_inst_true
    j bne_inst_false
bne_inst_true:
    li t0, 1
    sd t0, 0(sp)
    j bne_inst_ret
bne_inst_false:
    sd x0, 0(sp)
bne_inst_ret:
    ret

#####################################
# BRANCH (IF) LESS THAN INSTRUCTION #
#####################################
blt_inst:
    li t1, 1
    li t2, 2
    blt t1, t2, blt_inst_true
    j blt_inst_false
blt_inst_true:
    li t0, 1
    sd t0, 0(sp)
    j blt_inst_ret
blt_inst_false:
    sd x0, 0(sp)
blt_inst_ret:
    ret

############################################
# BRANCH (IF) GREATER OR EQUAL INSTRUCTION #
############################################
bge_inst:
    li t1, 2
    li t2, 1
    bge t1, t2, bge_inst_true
    j bge_inst_false
bge_inst_true:
    li t0, 1
    sd t0, 0(sp)
    j bge_inst_ret
bge_inst_false:
    sd x0, 0(sp)
bge_inst_ret:
    ret

##############################################
# BRANCH (IF) LESS THAN UNSIGNED INSTRUCTION #
##############################################
bltu_inst:
    li t1, 1
    li t2, -2
    bltu t1, t2, bltu_inst_true
    j bltu_inst_false
bltu_inst_true:
    li t0, 1
    sd t0, 0(sp)
    j bltu_inst_ret
bltu_inst_false:
    sd x0, 0(sp)
bltu_inst_ret:
    ret

#####################################################
# BRANCH (IF) GREATER OR EQUAL UNSIGNED INSTRUCTION #
#####################################################
bgeu_inst:
    li t1, -2
    li t2, 1
    bgeu t1, t2, bgeu_inst_true
    j bgeu_inst_false
bgeu_inst_true:
    li t0, 1
    sd t0, 0(sp)
    j bgeu_inst_ret
bgeu_inst_false:
    sd x0, 0(sp)
bgeu_inst_ret:
    ret

HALT:
