; RUN: llvm-split -preserve-locals -o %t %s
; RUN: llvm-dis -o - %t0 | FileCheck --check-prefix=CHECK0 %s
; RUN: llvm-dis -o - %t1 | FileCheck --check-prefix=CHECK1 %s

; The main and a must not be separated.
; The main and local_func must not be together.
; CHECK0: @a
; CHECK0: define i32 @main
; CHECK0: declare dso_local fastcc void @local_func

; The local_var and local_func must not be separated.
; CHECK1: @local_var
; CHECK1: define internal fastcc void @local_func

@a = internal global i32 0, align 4
@global_storage = common global i32 0, align 4
@local_var = internal global i32 0, align 4

; Function Attrs: nounwind
define i32 @main(i32 %x) {
entry:
  %call = call fastcc i32 @foo(i32 %x, ptr nonnull @a)
  %call1 = call fastcc i32 @baz(i32 %x)
  %add = add nsw i32 %call, %call1
  ret i32 %add
}

; Function Attrs: nounwind
define fastcc i32 @bar(i32 %b) {
entry:
  %call = call fastcc i32 @baz(i32 %b)
  ret i32 %call
}

; Function Attrs: nounwind
define fastcc i32 @baz(i32 %x) {
entry:
  store i32 %x, ptr @global_storage, align 4
  %shl = shl i32 %x, %x
  ret i32 %shl
}

; Function Attrs: noinline nounwind
define fastcc i32 @foo(i32 %a, ptr nocapture %b) {
entry:
  call fastcc void @local_func()
  %call = call fastcc i32 @bar(i32 %a)
  %0 = load i32, ptr @global_storage, align 4
  %call1 = call fastcc i32 @baz(i32 %0)
  %add = add nsw i32 %call, %call1
  store i32 %add, ptr %b, align 4
  %call.i = call fastcc i32 @baz(i32 %add) #2
  %add.i = add nsw i32 %call.i, 2
  %1 = load volatile i32, ptr @local_var, align 4
  %add3 = add nsw i32 %add.i, %1
  ret i32 %add3
}

; Function Attrs: noinline nounwind
define internal fastcc void @local_func() section ".text" {
entry:
  %0 = load i32, ptr @global_storage, align 4
  %call = call fastcc i32 @foo(i32 %0, ptr null)
  store volatile i32 %call, ptr @local_var, align 4
  ret void
}
