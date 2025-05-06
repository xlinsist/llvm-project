; RUN: llc -mtriple=riscv32 -mcpu=ventus-gpgpu -mattr=+zhinxmin -verify-machineinstrs -O1 < %s \
; RUN:   | FileCheck -check-prefix=VENTUS-ZHINXMIN %s
; RUN: llc -mtriple=riscv32 -mcpu=ventus-gpgpu -mattr=+zhinx -verify-machineinstrs -O1 < %s \
; RUN:   | FileCheck -check-prefix=VENTUS-ZHINX %s

;-----------------------------------------------------------------------------
; fadd: 半精度浮点加法
;-----------------------------------------------------------------------------
define dso_local ventus_kernel void @fadd(half noundef %c, half noundef %d, ptr addrspace(1) nocapture noundef writeonly align 4 %result) {
; VENTUS-ZHINXMIN-LABEL: fadd:
; VENTUS-ZHINXMIN:       # %bb.0: # %entry
; VENTUS-ZHINXMIN-NEXT:    addi    t0, a0, 4
; VENTUS-ZHINXMIN-NEXT:    lh      t1, 0(a0)
; VENTUS-ZHINXMIN-NEXT:    lh      t0, 0(t0)
; VENTUS-ZHINXMIN-NEXT:    lw      t2, 8(a0)
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h    t1, t1
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h    t0, t0
; VENTUS-ZHINXMIN-NEXT:    fadd.s      t0, t1, t0
; VENTUS-ZHINXMIN-NEXT:    fcvt.h.s    t0, t0
; VENTUS-ZHINXMIN-NEXT:    sh      t0, 0(t2)
; VENTUS-ZHINXMIN-NEXT:    ret

; VENTUS-ZHINX-LABEL: fadd:
; VENTUS-ZHINX:       # %bb.0: # %entry
; VENTUS-ZHINX-NEXT:    lh      t0, 0(a0)
; VENTUS-ZHINX-NEXT:    addi    t1, a0, 4
; VENTUS-ZHINX-NEXT:    lh      t1, 0(t1)
; VENTUS-ZHINX-NEXT:    lw      t2, 8(a0)
; VENTUS-ZHINX-NEXT:    fadd.h  t0, t0, t1
; VENTUS-ZHINX-NEXT:    sh      t0, 0(t2)
; VENTUS-ZHINX-NEXT:    ret

entry:
  %add1 = fadd half %c, %d
  store half %add1, ptr addrspace(1) %result, align 4
  ret void
}

;-----------------------------------------------------------------------------
; fsub: 半精度浮点减法
;-----------------------------------------------------------------------------
define dso_local ventus_kernel void @fsub(half noundef %c, half noundef %d, ptr addrspace(1) nocapture noundef writeonly align 4 %result) {
; VENTUS-ZHINXMIN-LABEL: fsub:
; VENTUS-ZHINXMIN:       # %bb.0: # %entry
; VENTUS-ZHINXMIN-NEXT:    addi    t0, a0, 4
; VENTUS-ZHINXMIN-NEXT:    lh      t1, 0(a0)
; VENTUS-ZHINXMIN-NEXT:    lh      t0, 0(t0)
; VENTUS-ZHINXMIN-NEXT:    lw      t2, 8(a0)
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h    t1, t1
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h    t0, t0
; VENTUS-ZHINXMIN-NEXT:    fsub.s      t0, t1, t0
; VENTUS-ZHINXMIN-NEXT:    fcvt.h.s    t0, t0
; VENTUS-ZHINXMIN-NEXT:    sh      t0, 0(t2)
; VENTUS-ZHINXMIN-NEXT:    ret

; VENTUS-ZHINX-LABEL: fsub:
; VENTUS-ZHINX:       # %bb.0: # %entry
; VENTUS-ZHINX-NEXT:    lh      t0, 0(a0)
; VENTUS-ZHINX-NEXT:    addi    t1, a0, 4
; VENTUS-ZHINX-NEXT:    lh      t1, 0(t1)
; VENTUS-ZHINX-NEXT:    lw      t2, 8(a0)
; VENTUS-ZHINX-NEXT:    fsub.h  t0, t0, t1
; VENTUS-ZHINX-NEXT:    sh      t0, 0(t2)
; VENTUS-ZHINX-NEXT:    ret
entry:
  %sub = fsub half %c, %d
  store half %sub, ptr addrspace(1) %result, align 4
  ret void
}

;-----------------------------------------------------------------------------
; fmul: 半精度浮点乘法
;-----------------------------------------------------------------------------
define dso_local ventus_kernel void @fmul(half noundef %c, half noundef %d, ptr addrspace(1) nocapture noundef writeonly align 4 %result) {
; VENTUS-ZHINXMIN-LABEL: fmul:
; VENTUS-ZHINXMIN:       # %bb.0: # %entry
; VENTUS-ZHINXMIN-NEXT:    addi    t0, a0, 4
; VENTUS-ZHINXMIN-NEXT:    lh      t1, 0(a0)
; VENTUS-ZHINXMIN-NEXT:    lh      t0, 0(t1)
; VENTUS-ZHINXMIN-NEXT:    lw      t2, 8(a0)
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h    t1, t1
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h    t0, t0
; VENTUS-ZHINXMIN-NEXT:    fmul.s      t0, t1, t0
; VENTUS-ZHINXMIN-NEXT:    fcvt.h.s    t0, t0
; VENTUS-ZHINXMIN-NEXT:    sh      t0, 0(t2)
; VENTUS-ZHINXMIN-NEXT:    ret

; VENTUS-ZHINX-LABEL: fmul:
; VENTUS-ZHINX:       # %bb.0: # %entry
; VENTUS-ZHINX-NEXT:    lh      t0, 0(a0)
; VENTUS-ZHINX-NEXT:    addi    t1, a0, 4
; VENTUS-ZHINX-NEXT:    lh      t1, 0(t1)
; VENTUS-ZHINX-NEXT:    lw      t2, 8(a0)
; VENTUS-ZHINX-NEXT:    fmul.h  t0, t0, t1
; VENTUS-ZHINX-NEXT:    sh      t0, 0(t2)
; VENTUS-ZHINX-NEXT:    ret
entry:
  %mul = fmul half %c, %d
  store half %mul, ptr addrspace(1) %result, align 4
  ret void
}

;-----------------------------------------------------------------------------
; fdiv: 半精度浮点除法
;-----------------------------------------------------------------------------
define dso_local ventus_kernel void @fdiv(half noundef %c, half noundef %d, ptr addrspace(1) nocapture noundef writeonly align 4 %result) {
; VENTUS-ZHINXMIN-LABEL: fdiv:
; VENTUS-ZHINXMIN:       # %bb.0: # %entry
; VENTUS-ZHINXMIN-NEXT:    addi    t0, a0, 4
; VENTUS-ZHINXMIN-NEXT:    lh      t1, 0(a0)
; VENTUS-ZHINXMIN-NEXT:    lh      t0, 0(t0)
; VENTUS-ZHINXMIN-NEXT:    lw      t2, 8(a0)
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h    t1, t1
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h    t0, t0
; VENTUS-ZHINXMIN-NEXT:    fdiv.s      t0, t0, ft1
; VENTUS-ZHINXMIN-NEXT:    fcvt.h.s    t0, t0
; VENTUS-ZHINXMIN-NEXT:    sh      t0, 0(t2)
; VENTUS-ZHINXMIN-NEXT:    ret

; VENTUS-ZHINX-LABEL: fdiv:
; VENTUS-ZHINX:       # %bb.0: # %entry
; VENTUS-ZHINX-NEXT:    lh      t0, 0(a0)
; VENTUS-ZHINX-NEXT:    addi    t1, a0, 4
; VENTUS-ZHINX-NEXT:    lh      t1, 0(t1)
; VENTUS-ZHINX-NEXT:    lw      t2, 8(a0)
; VENTUS-ZHINX-NEXT:    fdiv.h  t0, t0, t1
; VENTUS-ZHINX-NEXT:    sh      t0, 0(t2)
; VENTUS-ZHINX-NEXT:    ret
entry:
  %div = fdiv half %c, %d
  store half %div, ptr addrspace(1) %result, align 4
  ret void
}

;-----------------------------------------------------------------------------
; fmadd: 半精度浮点乘加
;-----------------------------------------------------------------------------
define dso_local ventus_kernel void @fmadd(half noundef %a, half noundef %b, half noundef %c, ptr addrspace(1) nocapture noundef writeonly align 4 %result) {
; VENTUS-ZHINXMIN-LABEL: fmadd:
; VENTUS-ZHINXMIN:       # %bb.0: # %entry
; VENTUS-ZHINXMIN-NEXT:    addi	 t0, a0, 4
; VENTUS-ZHINXMIN-NEXT:    addi	 t1, a0, 8
; VENTUS-ZHINXMIN-NEXT:    lh t2, 0(a0)
; VENTUS-ZHINXMIN-NEXT:    lh t1, 0(t1)
; VENTUS-ZHINXMIN-NEXT:    lh t0, 0(t0)
; VENTUS-ZHINXMIN-NEXT:    lw s1, 12(a0)
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h	t2, t2
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h	t1, t1
; VENTUS-ZHINXMIN-NEXT:    fcvt.s.h	t0, t0
; VENTUS-ZHINXMIN-NEXT:    fmadd.s	t0, t2, t0, t1
; VENTUS-ZHINXMIN-NEXT:    fcvt.h.s	t0, t0
; VENTUS-ZHINXMIN-NEXT:    sh t0, 0(s1)
; VENTUS-ZHINXMIN-NEXT:    ret

; VENTUS-ZHINX-LABEL: fmadd:
; VENTUS-ZHINX:       # %bb.0: # %entry
; VENTUS-ZHINX-NEXT:    lh t0, 0(a0)
; VENTUS-ZHINX-NEXT:    addi	 t1, a0, 8
; VENTUS-ZHINX-NEXT:    lh t1, 0(t1)
; VENTUS-ZHINX-NEXT:    addi	 t2, a0, 4
; VENTUS-ZHINX-NEXT:    lh t2, 0(t2)
; VENTUS-ZHINX-NEXT:    lw s1, 12(a0)
; VENTUS-ZHINX-NEXT:    fmadd.h t0, t0, t2, t1
; VENTUS-ZHINX-NEXT:    sh t0, 0(s1)
; VENTUS-ZHINX-NEXT:    ret
entry:
  %div = call half @llvm.fma.f32(half %a, half %b, half %c)
  store half %div, ptr addrspace(1) %result, align 4
  ret void
}

declare half @llvm.fma.f32(half %a, half %b, half %c)