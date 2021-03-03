; Main
; ├──Assignment
; │   ├i─i
; │   └─ 0
; └──While
;    ├c─1==1
;    ├──For
;    │   ├i─j
;    │   ├r─1:1:i
;    │   ├──Call
;    │   │   ├i─pick
;    │   │   └─ color
;    │   ├──Assignment
;    │   │   ├i─color
;    │   │   └─ 1-color
;    │   ├──Call
;    │   │   ├i─paint
;    │   │   └─ color
;    │   └──Call
;    │      ├i─move
;    │      └─ 1
;    ├──Call
;    │   ├i─turn
;    │   └─ 1
;    └──Assignment
;       ├i─i
;       └─ i+1

label start
  set r0 #0
  set r1 r0
label cond0
  set r2 #1
  set r3 #1
  test_eq r4 r2 r3
  goto end0 r4
  set r6 #1
  set r7 #1
  set r8 r1
  set r5 r6
label cond1
  test_le r9 r5 r8
  goto end1 r9
  call pick r10
  set r11 #1
  set r12 r10
  sub r11 r11 r12
  set r10 r11
  call paint r10
  call move #1
  add r5 r5 r7
  goto cond1 #0
label end1
  call turn #1
  set r13 r1
  set r14 #1
  add r13 r13 r14
  set r1 r13
  goto cond0 #0
label end0
  stop
