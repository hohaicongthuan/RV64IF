main:
    li t1, 0x42F6E979               # t1 = 123.456
    li t2, 0x414570A4               # t2 = 12.34
    li t3, 0x3C23D70A               # t3 = 0.01
    li t4, 0x41201297               # t4 = 10.004539
    nop
    nop
    nop
    nop
    nop
    fmv.w.x ft1, t1    
    fmv.w.x ft2, t2
    fmv.w.x ft4, t4
    fmv.w.x ft6, t3
    nop
    nop
    nop
    nop
    nop
    fdiv.s ft3, ft1, ft2            # ft3 = ft1 / ft2 = 123.456 / 12.34 = 10.004539
    nop
    nop
    nop
    nop
    nop
    fsub.s ft5, ft3, ft4
    nop
    nop
    nop
    nop
    nop
    fle.s t0, ft5, ft6
    nop
    nop
    nop
    nop
    nop
    sd t0, 0(sp)