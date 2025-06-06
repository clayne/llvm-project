; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1030 < %s | FileCheck %s

; In this test, V_CNDMASK_B32_e64 gets converted to V_CNDMASK_B32_e32,
; but the expected conversion to SDWA does not occur.  This led to a
; compilation error, because the use of $vcc in the resulting
; instruction must be fixed to $vcc_lo for wave32 which only happened
; after the full conversion to SDWA.

define void @quux(i32 %arg, i1 %arg1, i1 %arg2) {
; CHECK-LABEL: quux:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    v_and_b32_e32 v1, 1, v1
; CHECK-NEXT:    v_cmp_ne_u32_e32 vcc_lo, 1, v1
; CHECK-NEXT:    v_mov_b32_e32 v1, 0
; CHECK-NEXT:    s_and_saveexec_b32 s4, vcc_lo
; CHECK-NEXT:    s_cbranch_execz .LBB0_2
; CHECK-NEXT:  ; %bb.1: ; %bb3
; CHECK-NEXT:    v_and_b32_e32 v1, 0x3ff, v31
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    v_cmp_eq_u32_e32 vcc_lo, 0, v0
; CHECK-NEXT:    v_mul_u32_u24_e32 v1, 5, v1
; CHECK-NEXT:    global_load_ushort v1, v[1:2], off offset:3
; CHECK-NEXT:    v_mov_b32_e32 v2, 0xffff
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    v_and_b32_sdwa v0, v2, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
; CHECK-NEXT:    v_mov_b32_e32 v1, 24
; CHECK-NEXT:    v_mov_b32_e32 v2, 0xff
; CHECK-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc_lo
; CHECK-NEXT:    v_lshrrev_b32_sdwa v1, v1, v0 dst_sel:BYTE_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; CHECK-NEXT:    v_and_b32_sdwa v0, v0, v2 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; CHECK-NEXT:    v_or_b32_sdwa v1, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; CHECK-NEXT:  .LBB0_2: ; %bb9
; CHECK-NEXT:    s_or_b32 exec_lo, exec_lo, s4
; CHECK-NEXT:    v_mov_b32_e32 v2, 0
; CHECK-NEXT:    v_mov_b32_e32 v3, 0
; CHECK-NEXT:    global_store_byte v[2:3], v1, off
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  br i1 %arg1, label %bb9, label %bb3

bb3:                                              ; preds = %bb
  %call = tail call i32 @llvm.amdgcn.workitem.id.x()
  %mul = mul i32 %call, 5
  %zext = zext i32 %mul to i64
  %getelementptr = getelementptr i8, ptr addrspace(1) null, i64 %zext
  %getelementptr4 = getelementptr i8, ptr addrspace(1) %getelementptr, i64 4
  %load = load i8, ptr addrspace(1) %getelementptr4, align 1
  %getelementptr5 = getelementptr i8, ptr addrspace(1) %getelementptr, i64 3
  %load6 = load i8, ptr addrspace(1) %getelementptr5, align 1
  %insertelement = insertelement <5 x i8> poison, i8 %load, i64 4
  %select = select i1 %arg2, <5 x i8> %insertelement, <5 x i8> <i8 poison, i8 poison, i8 poison, i8 poison, i8 0>
  %insertelement7 = insertelement <5 x i8> %select, i8 %load6, i64 0
  %icmp = icmp ult i32 0, %arg
  %select8 = select i1 %icmp, <5 x i8> zeroinitializer, <5 x i8> %insertelement7
  %shufflevector = shufflevector <5 x i8> zeroinitializer, <5 x i8> %select8, <5 x i32> <i32 0, i32 1, i32 7, i32 8, i32 9>
  br label %bb9

bb9:                                              ; preds = %bb3, %bb
  %phi = phi <5 x i8> [ %shufflevector, %bb3 ], [ zeroinitializer, %bb ]
  %extractelement = extractelement <5 x i8> %phi, i64 0
  store i8 %extractelement, ptr addrspace(1) null, align 1
  ret void
}
