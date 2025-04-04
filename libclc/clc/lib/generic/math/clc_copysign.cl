//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <clc/clcmacro.h>
#include <clc/internal/clc.h>

_CLC_DEFINE_BINARY_BUILTIN_NO_SCALARIZE(float, __clc_copysign,
                                        __builtin_elementwise_copysign, float,
                                        float)

#ifdef cl_khr_fp64

#pragma OPENCL EXTENSION cl_khr_fp64 : enable

_CLC_DEFINE_BINARY_BUILTIN_NO_SCALARIZE(double, __clc_copysign,
                                        __builtin_elementwise_copysign, double,
                                        double)

#endif

#ifdef cl_khr_fp16

#pragma OPENCL EXTENSION cl_khr_fp16 : enable

_CLC_DEFINE_BINARY_BUILTIN_NO_SCALARIZE(half, __clc_copysign,
                                        __builtin_elementwise_copysign, half,
                                        half)

#endif

