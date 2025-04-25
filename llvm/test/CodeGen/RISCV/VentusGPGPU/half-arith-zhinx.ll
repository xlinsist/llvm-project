; RUN: llc -mtriple=riscv32 -mcpu=ventus-gpgpu -mattr=+zhinx -verify-machineinstrs -O1 < %s \
; RUN:   | FileCheck -check-prefix=VENTUS %s
; RUN: llc -mtriple=riscv32 -mcpu=ventus-gpgpu -mattr=+zhinxmin -verify-machineinstrs -O1 < %s \
; RUN:   | FileCheck -check-prefix=VENTUS %s


define dso_local ventus_kernel void @fadd(half noundef %c, half noundef %d, ptr addrspace(1) nocapture noundef writeonly align 4 %result)  {
; VENTUS-LABEL: fadd:
; VENTUS:       # %bb.0: # %entry
; VENTUS-NEXT:    lh t0, 0(a0)
; VENTUS-NEXT:    addi	 t1, a0, 4
; VENTUS-NEXT:    lh t1, 0(t1)
; VENTUS-NEXT:    lw t2, 8(a0)
; VENTUS-NEXT:    fadd.h t0, t0, t1
; VENTUS-NEXT:    sh t0, 0(t2)
; VENTUS-NEXT:    ret
entry:
  %add1 = fadd half %c, %d
  store half %add1, ptr addrspace(1) %result, align 4
  ret void
}

define dso_local ventus_kernel void @fsub(half noundef %c, half noundef %d, ptr addrspace(1) nocapture noundef writeonly align 4 %result)  {
; VENTUS-LABEL: fsub:
; VENTUS:       # %bb.0: # %entry
; VENTUS-NEXT:    lh t0, 0(a0)
; VENTUS-NEXT:    addi	 t1, a0, 4
; VENTUS-NEXT:    lh t1, 0(t1)
; VENTUS-NEXT:    lw t2, 8(a0)
; VENTUS-NEXT:    fsub.h t0, t0, t1
; VENTUS-NEXT:    sh t0, 0(t2)
; VENTUS-NEXT:    ret
entry:
  %sub = fsub half %c, %d
  store half %sub, ptr addrspace(1) %result, align 4
  ret void
}

define dso_local ventus_kernel void @fmul(half noundef %c, half noundef %d, ptr addrspace(1) nocapture noundef writeonly align 4 %result)  {
; VENTUS-LABEL: fmul:
; VENTUS:       # %bb.0: # %entry
; VENTUS-NEXT:    lh t0, 0(a0)
; VENTUS-NEXT:    addi	 t1, a0, 4
; VENTUS-NEXT:    lh t1, 0(t1)
; VENTUS-NEXT:    lw t2, 8(a0)
; VENTUS-NEXT:    fmul.h t0, t0, t1
; VENTUS-NEXT:    sh t0, 0(t2)
; VENTUS-NEXT:    ret
entry:
  %mul = fmul half %c, %d
  store half %mul, ptr addrspace(1) %result, align 4
  ret void
}

define dso_local ventus_kernel void @fdiv(half noundef %c, half noundef %d, ptr addrspace(1) nocapture noundef writeonly align 4 %result)  {
; VENTUS-LABEL: fdiv:
; VENTUS:       # %bb.0: # %entry
; VENTUS-NEXT:    lh t0, 0(a0)
; VENTUS-NEXT:    addi	 t1, a0, 4
; VENTUS-NEXT:    lh t1, 0(t1)
; VENTUS-NEXT:    lw t2, 8(a0)
; VENTUS-NEXT:    fdiv.h t0, t0, t1
; VENTUS-NEXT:    sh t0, 0(t2)
; VENTUS-NEXT:    ret
entry:
  %div = fdiv half %c, %d
  store half %div, ptr addrspace(1) %result, align 4
  ret void
}

define dso_local ventus_kernel void @fmadd(half noundef %a, half noundef %b, half noundef %c, ptr addrspace(1) nocapture noundef writeonly align 4 %result)  {
; VENTUS-LABEL: fmadd:
; VENTUS:       # %bb.0: # %entry
; VENTUS-NEXT:    lh t0, 0(a0)
; VENTUS-NEXT:    addi	 t1, a0, 8
; VENTUS-NEXT:    lh t1, 0(t1)
; VENTUS-NEXT:    addi	 t2, a0, 4
; VENTUS-NEXT:    lh t2, 0(t2)
; VENTUS-NEXT:    lw s1, 12(a0)
; VENTUS-NEXT:    fmadd.h t0, t0, t2, t1
; VENTUS-NEXT:    sh t0, 0(s1)
; VENTUS-NEXT:    ret
entry:
  %div = call half @llvm.fma.f32(half  %a, half  %b, half  %c)
  store half %div, ptr addrspace(1) %result, align 4
  ret void
}

declare half @llvm.fma.f32(half  %a, half  %b, half  %c)
