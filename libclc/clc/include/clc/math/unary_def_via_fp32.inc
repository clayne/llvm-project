//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

_CLC_OVERLOAD _CLC_DEF __CLC_GENTYPE FUNCTION(__CLC_GENTYPE x) {
  return __CLC_CONVERT_GENTYPE(FUNCTION(__CLC_CONVERT_FLOATN(x)));
}
