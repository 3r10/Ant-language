; Main
; ├──Assignment
; │   ├i─a
; │   └─ 0
; ├──Assignment
; │   ├i─b
; │   └─ 1
; └──While
;    ├c─1==1
;    ├──For
;    │   ├i─n
;    │   ├r─1:1:4
;    │   ├──For
;    │   │   ├i─i
;    │   │   ├r─1:1:b
;    │   │   ├──Call
;    │   │   │   ├i─pick
;    │   │   │   └─ color
;    │   │   ├──Assignment
;    │   │   │   ├i─color
;    │   │   │   └─ 1-color
;    │   │   ├──Call
;    │   │   │   ├i─paint
;    │   │   │   └─ color
;    │   │   └──Call
;    │   │      ├i─move
;    │   │      └─ 1
;    │   └──Call
;    │      ├i─turn
;    │      └─ 1
;    ├──Call
;    │   ├i─move
;    │   └─ b
;    ├──Call
;    │   ├i─turn
;    │   └─ 1
;    ├──Call
;    │   ├i─move
;    │   └─ b
;    ├──Assignment
;    │   ├i─c
;    │   └─ a+b
;    ├──Assignment
;    │   ├i─a
;    │   └─ b
;    └──Assignment
;       ├i─b
;       └─ c

label start
  set r0 #0
  set r1 r0
  set r2 #1
  set r3 r2
label cond0
  set r4 #1
  set r5 #1
  test_eq r6 r4 r5
  goto end0 r6
  set r8 #1
  set r9 #1
  set r10 #4
  set r7 r8
label cond1
  test_le r11 r7 r10
  goto end1 r11
  set r13 #1
  set r14 #1
  set r15 r3
  set r12 r13
label cond2
  test_le r16 r12 r15
  goto end2 r16
  call pick r17
  set r18 #1
  set r19 r17
  sub r18 r18 r19
  set r17 r18
  call paint r17
  call move #1
  add r12 r12 r14
  goto cond2 #0
label end2
  call turn #1
  add r7 r7 r9
  goto cond1 #0
label end1
  call move r3
  call turn #1
  call move r3
  set r20 r1
  set r21 r3
  add r20 r20 r21
  set r22 r20
  set r23 r3
  set r1 r23
  set r24 r22
  set r3 r24
  goto cond0 #0
label end0
  stop
