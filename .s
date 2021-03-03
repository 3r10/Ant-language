; Main
; ├──Assignment
; │   ├i─a
; │   └─ 0
; ├──Assignment
; │   ├i─b
; │   └─ 1
; ├──Assignment
; │   ├i─i
; │   └─ 0
; └──While
;    ├c─i<100
;    └──Branch
;       ├c─a+b==2
;       ├i─┐
;       │  └──Assignment
;       │     ├i─b
;       │     └─ b+1
;       e
;       ├──Assignment
;       │   ├i─c
;       │   └─ a+b
;       ├──Assignment
;       │   ├i─a
;       │   └─ b
;       ├──Assignment
;       │   ├i─b
;       │   └─ c
;       └──Assignment
;          ├i─i
;          └─ i+1

label start
  set r0 #0
  set r1 r0
  set r2 #1
  set r3 r2
  set r4 #0
  set r5 r4
label cond0
  set r6 r5
  set r7 #100
  test_lt r8 r6 r7
  goto end0 r8
  set r9 r1
  set r10 r3
  add r9 r9 r10
  set r11 #2
  test_eq r12 r9 r11
  goto else1 r12
  set r13 r3
  set r14 #1
  add r13 r13 r14
  set r3 r13
  goto end1 #0
label else1
  set r15 r1
  set r16 r3
  add r15 r15 r16
  set r17 r15
  set r18 r3
  set r1 r18
  set r19 r17
  set r3 r19
  set r20 r5
  set r21 #1
  add r20 r20 r21
  set r5 r20
label end1
  goto cond0 #0
label end0
  stop
