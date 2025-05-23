; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v,+d -O0 < %s \
; RUN:    | FileCheck --check-prefix=SPILL-O0 %s
; RUN: llc -mtriple=riscv32 -mattr=+v,+d -O2 < %s \
; RUN:    | FileCheck --check-prefix=SPILL-O2 %s
; RUN: llc -mtriple=riscv32 -mattr=+v,+d,+zcmp -O2 < %s \
; RUN:    | FileCheck --check-prefix=SPILL-O2-ZCMP %s
; RUN: llc -mtriple=riscv32 -mattr=+v,+d,+prefer-vsetvli-over-read-vlenb -O0 < %s \
; RUN:    | FileCheck --check-prefix=SPILL-O0-VSETVLI %s
; RUN: llc -mtriple=riscv32 -mattr=+v,+d,+prefer-vsetvli-over-read-vlenb -O2 < %s \
; RUN:    | FileCheck --check-prefix=SPILL-O2-VSETVLI %s
; RUN: llc -mtriple=riscv32 -mattr=+v,+d,+zcmp,+prefer-vsetvli-over-read-vlenb -O2 < %s \
; RUN:    | FileCheck --check-prefix=SPILL-O2-ZCMP-VSETVLI %s

@.str = private unnamed_addr constant [6 x i8] c"hello\00", align 1

define <vscale x 1 x double> @foo(<vscale x 1 x double> %a, <vscale x 1 x double> %b, <vscale x 1 x double> %c, i32 %gvl)
; SPILL-O0-LABEL: foo:
; SPILL-O0:       # %bb.0:
; SPILL-O0-NEXT:    addi sp, sp, -32
; SPILL-O0-NEXT:    .cfi_def_cfa_offset 32
; SPILL-O0-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; SPILL-O0-NEXT:    .cfi_offset ra, -4
; SPILL-O0-NEXT:    csrr a1, vlenb
; SPILL-O0-NEXT:    slli a1, a1, 1
; SPILL-O0-NEXT:    sub sp, sp, a1
; SPILL-O0-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
; SPILL-O0-NEXT:    sw a0, 8(sp) # 4-byte Folded Spill
; SPILL-O0-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; SPILL-O0-NEXT:    vmv1r.v v10, v9
; SPILL-O0-NEXT:    vmv1r.v v9, v8
; SPILL-O0-NEXT:    csrr a1, vlenb
; SPILL-O0-NEXT:    add a1, sp, a1
; SPILL-O0-NEXT:    addi a1, a1, 16
; SPILL-O0-NEXT:    vs1r.v v9, (a1) # vscale x 8-byte Folded Spill
; SPILL-O0-NEXT:    # implicit-def: $v8
; SPILL-O0-NEXT:    vsetvli zero, a0, e64, m1, tu, ma
; SPILL-O0-NEXT:    vfadd.vv v8, v9, v10
; SPILL-O0-NEXT:    addi a0, sp, 16
; SPILL-O0-NEXT:    vs1r.v v8, (a0) # vscale x 8-byte Folded Spill
; SPILL-O0-NEXT:    lui a0, %hi(.L.str)
; SPILL-O0-NEXT:    addi a0, a0, %lo(.L.str)
; SPILL-O0-NEXT:    call puts
; SPILL-O0-NEXT:    addi a1, sp, 16
; SPILL-O0-NEXT:    vl1r.v v10, (a1) # vscale x 8-byte Folded Reload
; SPILL-O0-NEXT:    csrr a1, vlenb
; SPILL-O0-NEXT:    add a1, sp, a1
; SPILL-O0-NEXT:    addi a1, a1, 16
; SPILL-O0-NEXT:    vl1r.v v9, (a1) # vscale x 8-byte Folded Reload
; SPILL-O0-NEXT:    # kill: def $x11 killed $x10
; SPILL-O0-NEXT:    lw a0, 8(sp) # 4-byte Folded Reload
; SPILL-O0-NEXT:    # implicit-def: $v8
; SPILL-O0-NEXT:    vsetvli zero, a0, e64, m1, tu, ma
; SPILL-O0-NEXT:    vfadd.vv v8, v9, v10
; SPILL-O0-NEXT:    csrr a0, vlenb
; SPILL-O0-NEXT:    slli a0, a0, 1
; SPILL-O0-NEXT:    add sp, sp, a0
; SPILL-O0-NEXT:    .cfi_def_cfa sp, 32
; SPILL-O0-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; SPILL-O0-NEXT:    .cfi_restore ra
; SPILL-O0-NEXT:    addi sp, sp, 32
; SPILL-O0-NEXT:    .cfi_def_cfa_offset 0
; SPILL-O0-NEXT:    ret
;
; SPILL-O2-LABEL: foo:
; SPILL-O2:       # %bb.0:
; SPILL-O2-NEXT:    addi sp, sp, -32
; SPILL-O2-NEXT:    .cfi_def_cfa_offset 32
; SPILL-O2-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; SPILL-O2-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; SPILL-O2-NEXT:    .cfi_offset ra, -4
; SPILL-O2-NEXT:    .cfi_offset s0, -8
; SPILL-O2-NEXT:    csrr a1, vlenb
; SPILL-O2-NEXT:    slli a1, a1, 1
; SPILL-O2-NEXT:    sub sp, sp, a1
; SPILL-O2-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
; SPILL-O2-NEXT:    mv s0, a0
; SPILL-O2-NEXT:    addi a1, sp, 16
; SPILL-O2-NEXT:    vs1r.v v8, (a1) # vscale x 8-byte Folded Spill
; SPILL-O2-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; SPILL-O2-NEXT:    vfadd.vv v9, v8, v9
; SPILL-O2-NEXT:    csrr a0, vlenb
; SPILL-O2-NEXT:    add a0, sp, a0
; SPILL-O2-NEXT:    addi a0, a0, 16
; SPILL-O2-NEXT:    vs1r.v v9, (a0) # vscale x 8-byte Folded Spill
; SPILL-O2-NEXT:    lui a0, %hi(.L.str)
; SPILL-O2-NEXT:    addi a0, a0, %lo(.L.str)
; SPILL-O2-NEXT:    call puts
; SPILL-O2-NEXT:    csrr a0, vlenb
; SPILL-O2-NEXT:    add a0, sp, a0
; SPILL-O2-NEXT:    addi a0, a0, 16
; SPILL-O2-NEXT:    vl1r.v v8, (a0) # vscale x 8-byte Folded Reload
; SPILL-O2-NEXT:    addi a0, sp, 16
; SPILL-O2-NEXT:    vl1r.v v9, (a0) # vscale x 8-byte Folded Reload
; SPILL-O2-NEXT:    vsetvli zero, s0, e64, m1, ta, ma
; SPILL-O2-NEXT:    vfadd.vv v8, v9, v8
; SPILL-O2-NEXT:    csrr a0, vlenb
; SPILL-O2-NEXT:    slli a0, a0, 1
; SPILL-O2-NEXT:    add sp, sp, a0
; SPILL-O2-NEXT:    .cfi_def_cfa sp, 32
; SPILL-O2-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; SPILL-O2-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; SPILL-O2-NEXT:    .cfi_restore ra
; SPILL-O2-NEXT:    .cfi_restore s0
; SPILL-O2-NEXT:    addi sp, sp, 32
; SPILL-O2-NEXT:    .cfi_def_cfa_offset 0
; SPILL-O2-NEXT:    ret
;
; SPILL-O2-ZCMP-LABEL: foo:
; SPILL-O2-ZCMP:       # %bb.0:
; SPILL-O2-ZCMP-NEXT:    cm.push {ra, s0}, -32
; SPILL-O2-ZCMP-NEXT:    .cfi_def_cfa_offset 32
; SPILL-O2-ZCMP-NEXT:    .cfi_offset ra, -8
; SPILL-O2-ZCMP-NEXT:    .cfi_offset s0, -4
; SPILL-O2-ZCMP-NEXT:    csrr a1, vlenb
; SPILL-O2-ZCMP-NEXT:    slli a1, a1, 1
; SPILL-O2-ZCMP-NEXT:    sub sp, sp, a1
; SPILL-O2-ZCMP-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
; SPILL-O2-ZCMP-NEXT:    mv s0, a0
; SPILL-O2-ZCMP-NEXT:    addi a1, sp, 16
; SPILL-O2-ZCMP-NEXT:    vs1r.v v8, (a1) # vscale x 8-byte Folded Spill
; SPILL-O2-ZCMP-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; SPILL-O2-ZCMP-NEXT:    vfadd.vv v9, v8, v9
; SPILL-O2-ZCMP-NEXT:    csrr a0, vlenb
; SPILL-O2-ZCMP-NEXT:    add a0, a0, sp
; SPILL-O2-ZCMP-NEXT:    addi a0, a0, 16
; SPILL-O2-ZCMP-NEXT:    vs1r.v v9, (a0) # vscale x 8-byte Folded Spill
; SPILL-O2-ZCMP-NEXT:    lui a0, %hi(.L.str)
; SPILL-O2-ZCMP-NEXT:    addi a0, a0, %lo(.L.str)
; SPILL-O2-ZCMP-NEXT:    call puts
; SPILL-O2-ZCMP-NEXT:    csrr a0, vlenb
; SPILL-O2-ZCMP-NEXT:    add a0, a0, sp
; SPILL-O2-ZCMP-NEXT:    addi a0, a0, 16
; SPILL-O2-ZCMP-NEXT:    vl1r.v v8, (a0) # vscale x 8-byte Folded Reload
; SPILL-O2-ZCMP-NEXT:    addi a0, sp, 16
; SPILL-O2-ZCMP-NEXT:    vl1r.v v9, (a0) # vscale x 8-byte Folded Reload
; SPILL-O2-ZCMP-NEXT:    vsetvli zero, s0, e64, m1, ta, ma
; SPILL-O2-ZCMP-NEXT:    vfadd.vv v8, v9, v8
; SPILL-O2-ZCMP-NEXT:    csrr a0, vlenb
; SPILL-O2-ZCMP-NEXT:    slli a0, a0, 1
; SPILL-O2-ZCMP-NEXT:    add sp, sp, a0
; SPILL-O2-ZCMP-NEXT:    .cfi_def_cfa sp, 32
; SPILL-O2-ZCMP-NEXT:    cm.popret {ra, s0}, 32
;
; SPILL-O0-VSETVLI-LABEL: foo:
; SPILL-O0-VSETVLI:       # %bb.0:
; SPILL-O0-VSETVLI-NEXT:    addi sp, sp, -32
; SPILL-O0-VSETVLI-NEXT:    .cfi_def_cfa_offset 32
; SPILL-O0-VSETVLI-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; SPILL-O0-VSETVLI-NEXT:    .cfi_offset ra, -4
; SPILL-O0-VSETVLI-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; SPILL-O0-VSETVLI-NEXT:    sub sp, sp, a1
; SPILL-O0-VSETVLI-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
; SPILL-O0-VSETVLI-NEXT:    sw a0, 8(sp) # 4-byte Folded Spill
; SPILL-O0-VSETVLI-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; SPILL-O0-VSETVLI-NEXT:    vmv1r.v v10, v9
; SPILL-O0-VSETVLI-NEXT:    vmv1r.v v9, v8
; SPILL-O0-VSETVLI-NEXT:    csrr a1, vlenb
; SPILL-O0-VSETVLI-NEXT:    add a1, sp, a1
; SPILL-O0-VSETVLI-NEXT:    addi a1, a1, 16
; SPILL-O0-VSETVLI-NEXT:    vs1r.v v9, (a1) # vscale x 8-byte Folded Spill
; SPILL-O0-VSETVLI-NEXT:    # implicit-def: $v8
; SPILL-O0-VSETVLI-NEXT:    vsetvli zero, a0, e64, m1, tu, ma
; SPILL-O0-VSETVLI-NEXT:    vfadd.vv v8, v9, v10
; SPILL-O0-VSETVLI-NEXT:    addi a0, sp, 16
; SPILL-O0-VSETVLI-NEXT:    vs1r.v v8, (a0) # vscale x 8-byte Folded Spill
; SPILL-O0-VSETVLI-NEXT:    lui a0, %hi(.L.str)
; SPILL-O0-VSETVLI-NEXT:    addi a0, a0, %lo(.L.str)
; SPILL-O0-VSETVLI-NEXT:    call puts
; SPILL-O0-VSETVLI-NEXT:    addi a1, sp, 16
; SPILL-O0-VSETVLI-NEXT:    vl1r.v v10, (a1) # vscale x 8-byte Folded Reload
; SPILL-O0-VSETVLI-NEXT:    csrr a1, vlenb
; SPILL-O0-VSETVLI-NEXT:    add a1, sp, a1
; SPILL-O0-VSETVLI-NEXT:    addi a1, a1, 16
; SPILL-O0-VSETVLI-NEXT:    vl1r.v v9, (a1) # vscale x 8-byte Folded Reload
; SPILL-O0-VSETVLI-NEXT:    # kill: def $x11 killed $x10
; SPILL-O0-VSETVLI-NEXT:    lw a0, 8(sp) # 4-byte Folded Reload
; SPILL-O0-VSETVLI-NEXT:    # implicit-def: $v8
; SPILL-O0-VSETVLI-NEXT:    vsetvli zero, a0, e64, m1, tu, ma
; SPILL-O0-VSETVLI-NEXT:    vfadd.vv v8, v9, v10
; SPILL-O0-VSETVLI-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; SPILL-O0-VSETVLI-NEXT:    add sp, sp, a0
; SPILL-O0-VSETVLI-NEXT:    .cfi_def_cfa sp, 32
; SPILL-O0-VSETVLI-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; SPILL-O0-VSETVLI-NEXT:    .cfi_restore ra
; SPILL-O0-VSETVLI-NEXT:    addi sp, sp, 32
; SPILL-O0-VSETVLI-NEXT:    .cfi_def_cfa_offset 0
; SPILL-O0-VSETVLI-NEXT:    ret
;
; SPILL-O2-VSETVLI-LABEL: foo:
; SPILL-O2-VSETVLI:       # %bb.0:
; SPILL-O2-VSETVLI-NEXT:    addi sp, sp, -32
; SPILL-O2-VSETVLI-NEXT:    .cfi_def_cfa_offset 32
; SPILL-O2-VSETVLI-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; SPILL-O2-VSETVLI-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; SPILL-O2-VSETVLI-NEXT:    .cfi_offset ra, -4
; SPILL-O2-VSETVLI-NEXT:    .cfi_offset s0, -8
; SPILL-O2-VSETVLI-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; SPILL-O2-VSETVLI-NEXT:    sub sp, sp, a1
; SPILL-O2-VSETVLI-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
; SPILL-O2-VSETVLI-NEXT:    mv s0, a0
; SPILL-O2-VSETVLI-NEXT:    addi a1, sp, 16
; SPILL-O2-VSETVLI-NEXT:    vs1r.v v8, (a1) # vscale x 8-byte Folded Spill
; SPILL-O2-VSETVLI-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; SPILL-O2-VSETVLI-NEXT:    vfadd.vv v9, v8, v9
; SPILL-O2-VSETVLI-NEXT:    csrr a0, vlenb
; SPILL-O2-VSETVLI-NEXT:    add a0, sp, a0
; SPILL-O2-VSETVLI-NEXT:    addi a0, a0, 16
; SPILL-O2-VSETVLI-NEXT:    vs1r.v v9, (a0) # vscale x 8-byte Folded Spill
; SPILL-O2-VSETVLI-NEXT:    lui a0, %hi(.L.str)
; SPILL-O2-VSETVLI-NEXT:    addi a0, a0, %lo(.L.str)
; SPILL-O2-VSETVLI-NEXT:    call puts
; SPILL-O2-VSETVLI-NEXT:    csrr a0, vlenb
; SPILL-O2-VSETVLI-NEXT:    add a0, sp, a0
; SPILL-O2-VSETVLI-NEXT:    addi a0, a0, 16
; SPILL-O2-VSETVLI-NEXT:    vl1r.v v8, (a0) # vscale x 8-byte Folded Reload
; SPILL-O2-VSETVLI-NEXT:    addi a0, sp, 16
; SPILL-O2-VSETVLI-NEXT:    vl1r.v v9, (a0) # vscale x 8-byte Folded Reload
; SPILL-O2-VSETVLI-NEXT:    vsetvli zero, s0, e64, m1, ta, ma
; SPILL-O2-VSETVLI-NEXT:    vfadd.vv v8, v9, v8
; SPILL-O2-VSETVLI-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; SPILL-O2-VSETVLI-NEXT:    add sp, sp, a0
; SPILL-O2-VSETVLI-NEXT:    .cfi_def_cfa sp, 32
; SPILL-O2-VSETVLI-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; SPILL-O2-VSETVLI-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; SPILL-O2-VSETVLI-NEXT:    .cfi_restore ra
; SPILL-O2-VSETVLI-NEXT:    .cfi_restore s0
; SPILL-O2-VSETVLI-NEXT:    addi sp, sp, 32
; SPILL-O2-VSETVLI-NEXT:    .cfi_def_cfa_offset 0
; SPILL-O2-VSETVLI-NEXT:    ret
;
; SPILL-O2-ZCMP-VSETVLI-LABEL: foo:
; SPILL-O2-ZCMP-VSETVLI:       # %bb.0:
; SPILL-O2-ZCMP-VSETVLI-NEXT:    cm.push {ra, s0}, -32
; SPILL-O2-ZCMP-VSETVLI-NEXT:    .cfi_def_cfa_offset 32
; SPILL-O2-ZCMP-VSETVLI-NEXT:    .cfi_offset ra, -8
; SPILL-O2-ZCMP-VSETVLI-NEXT:    .cfi_offset s0, -4
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; SPILL-O2-ZCMP-VSETVLI-NEXT:    sub sp, sp, a1
; SPILL-O2-ZCMP-VSETVLI-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x20, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 32 + 2 * vlenb
; SPILL-O2-ZCMP-VSETVLI-NEXT:    mv s0, a0
; SPILL-O2-ZCMP-VSETVLI-NEXT:    addi a1, sp, 16
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vs1r.v v8, (a1) # vscale x 8-byte Folded Spill
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vfadd.vv v9, v8, v9
; SPILL-O2-ZCMP-VSETVLI-NEXT:    csrr a0, vlenb
; SPILL-O2-ZCMP-VSETVLI-NEXT:    add a0, a0, sp
; SPILL-O2-ZCMP-VSETVLI-NEXT:    addi a0, a0, 16
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vs1r.v v9, (a0) # vscale x 8-byte Folded Spill
; SPILL-O2-ZCMP-VSETVLI-NEXT:    lui a0, %hi(.L.str)
; SPILL-O2-ZCMP-VSETVLI-NEXT:    addi a0, a0, %lo(.L.str)
; SPILL-O2-ZCMP-VSETVLI-NEXT:    call puts
; SPILL-O2-ZCMP-VSETVLI-NEXT:    csrr a0, vlenb
; SPILL-O2-ZCMP-VSETVLI-NEXT:    add a0, a0, sp
; SPILL-O2-ZCMP-VSETVLI-NEXT:    addi a0, a0, 16
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vl1r.v v8, (a0) # vscale x 8-byte Folded Reload
; SPILL-O2-ZCMP-VSETVLI-NEXT:    addi a0, sp, 16
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vl1r.v v9, (a0) # vscale x 8-byte Folded Reload
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vsetvli zero, s0, e64, m1, ta, ma
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vfadd.vv v8, v9, v8
; SPILL-O2-ZCMP-VSETVLI-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; SPILL-O2-ZCMP-VSETVLI-NEXT:    add sp, sp, a0
; SPILL-O2-ZCMP-VSETVLI-NEXT:    .cfi_def_cfa sp, 32
; SPILL-O2-ZCMP-VSETVLI-NEXT:    cm.popret {ra, s0}, 32
{
   %x = call <vscale x 1 x double> @llvm.riscv.vfadd.nxv1f64.nxv1f64(<vscale x 1 x double> undef, <vscale x 1 x double> %a, <vscale x 1 x double> %b, i32 7, i32 %gvl)
   %call = call signext i32 @puts(ptr @.str)
   %z = call <vscale x 1 x double> @llvm.riscv.vfadd.nxv1f64.nxv1f64(<vscale x 1 x double> undef, <vscale x 1 x double> %a, <vscale x 1 x double> %x, i32 7, i32 %gvl)
   ret <vscale x 1 x double> %z
}

declare <vscale x 1 x double> @llvm.riscv.vfadd.nxv1f64.nxv1f64(<vscale x 1 x double> %passthru, <vscale x 1 x double> %a, <vscale x 1 x double> %b, i32, i32 %gvl)
declare i32 @puts(ptr);
