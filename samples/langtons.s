; Main
; ├──Assignment
; │   ├i─right
; │   └─ -1
; ├──Assignment
; │   ├i─left
; │   └─ 1
; └──For
;    ├i─step
;    ├r─1:1:30000
;    ├──Call
;    │   ├i─pick
;    │   └─ color
;    ├──Branch
;    │   ├c─color==0
;    │   ├i─┐
;    │   │  ├──Call
;    │   │  │   ├i─turn
;    │   │  │   └─ right
;    │   │  └──Call
;    │   │     ├i─paint
;    │   │     └─ 1
;    │   e
;    │   ├──Call
;    │   │   ├i─turn
;    │   │   └─ left
;    │   └──Call
;    │      ├i─paint
;    │      └─ 0
;    └──Call
;       ├i─move
;       └─ 1

label start
  set r0 #1
  sub r0 #0 r0
  set r1 r0
  set r2 #1
  set r3 r2
  set r5 #1
  set r6 #1
  set r7 #30000
  set r4 r5
label cond0
  test_le r8 r4 r7
  goto end0 r8
  call pick r9
  set r10 r9
  set r11 #0
  test_eq r12 r10 r11
  goto else1 r12
  call turn r1
  call paint #1
  goto end1 #0
label else1
  call turn r3
  call paint #0
label end1
  call move #1
  add r4 r4 r6
  goto cond0 #0
label end0
  stop
