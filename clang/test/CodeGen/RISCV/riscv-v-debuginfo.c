// RUN: %clang_cc1 -triple riscv64 -target-feature +v \
// RUN:   -dwarf-version=4 -debug-info-kind=limited -emit-llvm -o - %s \
// RUN:   | FileCheck --check-prefix=DEBUGINFO %s
#include <stdint.h>

__rvv_int16m2_t f1(__rvv_int16m2_t arg_0, __rvv_int16m2_t arg_1, int64_t arg_2) {
  __rvv_int16m2_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 2, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_mul, DW_OP_constu, 1, DW_OP_minus))

__rvv_int16mf2_t f2(__rvv_int16mf2_t arg_0, __rvv_int16mf2_t arg_1, int64_t arg_2) {
  __rvv_int16mf2_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 2, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_div, DW_OP_constu, 1, DW_OP_minus))

__rvv_int32mf2_t f3(__rvv_int32mf2_t arg_0, __rvv_int32mf2_t arg_1, int64_t arg_2) {
  __rvv_int32mf2_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 4, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_div, DW_OP_constu, 1, DW_OP_minus))

__rvv_int16m2x2_t f4 (__rvv_int16m2x2_t arg_0, __rvv_int16m2x2_t arg_1, int64_t arg_2){
  __rvv_int16m2x2_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 2, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_mul, DW_OP_constu, 2, DW_OP_mul, DW_OP_constu, 1, DW_OP_minus))

__rvv_int16m2x4_t f5 (__rvv_int16m2x4_t arg_0, __rvv_int16m2x4_t arg_1, int64_t arg_2){
   __rvv_int16m2x4_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 2, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_mul, DW_OP_constu, 4, DW_OP_mul, DW_OP_constu, 1, DW_OP_minus))

__rvv_int32m2x2_t f6(__rvv_int32m2x2_t arg_0, __rvv_int32m2x2_t arg_1, int64_t arg_2) {
  __rvv_int32m2x2_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 4, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_mul, DW_OP_constu, 2, DW_OP_mul, DW_OP_constu, 1, DW_OP_minus))

__rvv_int32m2x4_t f7(__rvv_int32m2x4_t arg_0, __rvv_int32m2x4_t arg_1, int64_t arg_2) {
  __rvv_int32m2x4_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 4, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_mul, DW_OP_constu, 4, DW_OP_mul, DW_OP_constu, 1, DW_OP_minus))

__rvv_int32mf2x2_t f8(__rvv_int32mf2x2_t arg_0, __rvv_int32mf2x2_t arg_1, int64_t arg_2) {
  __rvv_int32mf2x2_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 4, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_div, DW_OP_constu, 2, DW_OP_mul, DW_OP_constu, 1, DW_OP_minus))

__rvv_int32mf2x4_t f9(__rvv_int32mf2x4_t arg_0, __rvv_int32mf2x4_t arg_1, int64_t   arg_2) {
  __rvv_int32mf2x4_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 4, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_div, DW_OP_constu, 4, DW_OP_mul, DW_OP_constu, 1, DW_OP_minus))

__rvv_int32mf2x8_t f10(__rvv_int32mf2x8_t arg_0, __rvv_int32mf2x8_t arg_1, int64_t   arg_2) {
  __rvv_int32mf2x8_t ret;
  return ret;
}

// !DISubrange(lowerBound: 0, upperBound: !DIExpression(DW_OP_bregx, 7202, 0, DW_OP_constu, 4, DW_OP_div,
// DEBUGINFO: DW_OP_constu, 2, DW_OP_div, DW_OP_constu, 8, DW_OP_mul, DW_OP_constu, 1, DW_OP_minus))
