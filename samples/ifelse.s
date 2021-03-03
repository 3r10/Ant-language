; Main
; └──Branch
;    ├c─0==1
;    ├i─┐
;    │  ├──Assignment
;    │  │   ├i─a
;    │  │   └─ 1
;    │  └──Branch
;    │     ├c─1==1
;    │     ├i─┐
;    │     │  └──Assignment
;    │     │     ├i─b
;    │     │     └─ a-2
;    │     e
;    │     └──Assignment
;    │        ├i─c
;    │        └─ -a+b-3
;    e

label start
  set r0 #0
  set r1 #1
  test_eq r2 r0 r1
  goto else0 r2
  set r3 #1
  set r4 r3
  set r5 #1
  set r6 #1
  test_eq r7 r5 r6
  goto else1 r7
  set r8 r4
  set r9 #2
  sub r8 r8 r9
  set r10 r8
  goto end1 #0
label else1
  set r11 r4
  sub r11 #0 r11
  set r12 r10
  add r11 r11 r12
  set r13 #3
  sub r11 r11 r13
  set r14 r11
label end1
  goto end0 #0
label else0
label end0
  stop
