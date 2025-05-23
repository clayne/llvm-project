; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -mtriple=riscv32 -mattr=+xandesperf -verify-machineinstrs < %s \
; RUN:   | FileCheck %s

define i32 @sexti1_i32(i32 %a) {
; CHECK-LABEL: sexti1_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nds.bfos a0, a0, 0, 0
; CHECK-NEXT:    ret
  %shl = shl i32 %a, 31
  %shr = ashr exact i32 %shl, 31
  ret i32 %shr
}

define i32 @sexti1_i32_2(i1 %a) {
; CHECK-LABEL: sexti1_i32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    nds.bfos a0, a0, 0, 0
; CHECK-NEXT:    ret
  %1 = sext i1 %a to i32
  ret i32 %1
}

define i32 @sexti8_i32(i32 %a) {
; CHECK-LABEL: sexti8_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nds.bfos a0, a0, 7, 0
; CHECK-NEXT:    ret
  %shl = shl i32 %a, 24
  %shr = ashr exact i32 %shl, 24
  ret i32 %shr
}

define i32 @sexti8_i32_2(i8 %a) {
; CHECK-LABEL: sexti8_i32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    nds.bfos a0, a0, 7, 0
; CHECK-NEXT:    ret
  %1 = sext i8 %a to i32
  ret i32 %1
}

define i32 @sexti16_i32(i32 %a) {
; CHECK-LABEL: sexti16_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nds.bfos a0, a0, 15, 0
; CHECK-NEXT:    ret
  %shl = shl i32 %a, 16
  %shr = ashr exact i32 %shl, 16
  ret i32 %shr
}

define i32 @sexti16_i32_2(i16 %a) {
; CHECK-LABEL: sexti16_i32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    nds.bfos a0, a0, 15, 0
; CHECK-NEXT:    ret
  %1 = sext i16 %a to i32
  ret i32 %1
}

define i64 @sexti1_i64(i64 %a) {
; CHECK-LABEL: sexti1_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    nds.bfos a1, a0, 0, 0
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:    ret
  %shl = shl i64 %a, 63
  %shr = ashr exact i64 %shl, 63
  ret i64 %shr
}

define i64 @sexti1_i64_2(i1 %a) {
; CHECK-LABEL: sexti1_i64_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    nds.bfos a1, a0, 0, 0
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:    ret
  %1 = sext i1 %a to i64
  ret i64 %1
}

define i64 @sexti8_i64(i64 %a) {
; CHECK-LABEL: sexti8_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    nds.bfos a0, a0, 7, 0
; CHECK-NEXT:    srai a1, a0, 31
; CHECK-NEXT:    ret
  %shl = shl i64 %a, 56
  %shr = ashr exact i64 %shl, 56
  ret i64 %shr
}

define i64 @sexti8_i64_2(i8 %a) {
; CHECK-LABEL: sexti8_i64_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    nds.bfos a0, a0, 7, 0
; CHECK-NEXT:    srai a1, a0, 31
; CHECK-NEXT:    ret
  %1 = sext i8 %a to i64
  ret i64 %1
}

define i64 @sexti16_i64(i64 %a) {
; CHECK-LABEL: sexti16_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    nds.bfos a0, a0, 15, 0
; CHECK-NEXT:    srai a1, a0, 31
; CHECK-NEXT:    ret
  %shl = shl i64 %a, 48
  %shr = ashr exact i64 %shl, 48
  ret i64 %shr
}

define i64 @sexti16_i64_2(i16 %a) {
; CHECK-LABEL: sexti16_i64_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    nds.bfos a0, a0, 15, 0
; CHECK-NEXT:    srai a1, a0, 31
; CHECK-NEXT:    ret
  %1 = sext i16 %a to i64
  ret i64 %1
}

define i64 @sexti32_i64(i64 %a) {
; CHECK-LABEL: sexti32_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $x11 killed $x10
; CHECK-NEXT:    srai a1, a0, 31
; CHECK-NEXT:    ret
  %shl = shl i64 %a, 32
  %shr = ashr exact i64 %shl, 32
  ret i64 %shr
}

define i64 @sexti32_i64_2(i32 %a) {
; CHECK-LABEL: sexti32_i64_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srai a1, a0, 31
; CHECK-NEXT:    ret
  %1 = sext i32 %a to i64
  ret i64 %1
}
