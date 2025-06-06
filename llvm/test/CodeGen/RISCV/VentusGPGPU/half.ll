; RUN: llc -mtriple=riscv32 -mcpu=ventus-gpgpu -mattr=+zvfhmin %s -o - \
; RUN:   | FileCheck -check-prefix=VENTUS %s

@vec = global <8 x half> zeroinitializer, align 2

; Test vector load of <8 x half>
define <8 x half> @test_vle(<8 x half>* %src) {
entry:
  ; VENTUS: vle16.v v0, 0(v0)
  %v = load <8 x half>, <8 x half>* %src, align 2
  ret <8 x half> %v
}

; Test vector store of <8 x half>
define void @test_vse(<8 x half>* %dst, <8 x half> %v) {
entry:
  ; VENTUS: vse16.v v1, 0(v0)
  store <8 x half> %v, <8 x half>* %dst, align 2
  ret void
}

; Test vector fpextend: <8 x half> -> <8 x float>
define <8 x float> @test_fpext(<8 x half> %a) {
entry:
  ; VENTUS: vfwcvt.f.f.v v0, v0
  %r = fpext <8 x half> %a to <8 x float>
  ret <8 x float> %r
}

; Test vector fpround: <8 x float> -> <8 x half>
define <8 x half> @test_fpround(<8 x float> %a) {
entry:
  ; VENTUS: vfncvt.f.f.w v0, v0
  %r = fptrunc <8 x float> %a to <8 x half>
  ret <8 x half> %r
}

; Test vector add: <8 x half>
define <8 x half> @test_add(<8 x half> %a, <8 x half> %b) {
entry:
  ; VENTUS: vfadd.vv v0, v0, v1
  %r = fadd <8 x half> %a, %b
  ret <8 x half> %r
}
