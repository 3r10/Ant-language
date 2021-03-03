; Main
; ├──Call
; │   ├i─paint
; │   └─ 1
; ├──Assignment
; │   ├i─i
; │   └─ 0
; ├──Assignment
; │   ├i─left
; │   └─ 1
; ├──Assignment
; │   ├i─right
; │   └─ -1
; ├──Assignment
; │   ├i─back
; │   └─ 2
; └──While
;    ├c─1==1
;    ├──For
;    │   ├i─j
;    │   ├r─1:1:i
;    │   ├──Assignment
;    │   │   ├i─value
;    │   │   └─ 0
;    │   ├──Call
;    │   │   ├i─turn
;    │   │   └─ back
;    │   ├──Call
;    │   │   ├i─move
;    │   │   └─ 1
;    │   ├──For
;    │   │   ├i─k
;    │   │   ├r─1:1:2
;    │   │   ├──Call
;    │   │   │   ├i─turn
;    │   │   │   └─ right
;    │   │   ├──Call
;    │   │   │   ├i─move
;    │   │   │   └─ 1
;    │   │   ├──Call
;    │   │   │   ├i─pick
;    │   │   │   └─ bit
;    │   │   └──Assignment
;    │   │      ├i─value
;    │   │      └─ value+bit
;    │   ├──Call
;    │   │   ├i─turn
;    │   │   └─ right
;    │   ├──Call
;    │   │   ├i─move
;    │   │   └─ 1
;    │   ├──Call
;    │   │   ├i─turn
;    │   │   └─ left
;    │   ├──Branch
;    │   │   ├c─value==2
;    │   │   ├i─┐
;    │   │   │  └──Assignment
;    │   │   │     ├i─value
;    │   │   │     └─ 0
;    │   │   e
;    │   ├──Call
;    │   │   ├i─paint
;    │   │   └─ value
;    │   └──Call
;    │      ├i─move
;    │      └─ 1
;    ├──Call
;    │   ├i─turn
;    │   └─ right
;    ├──Call
;    │   ├i─move
;    │   └─ 1
;    ├──Call
;    │   ├i─turn
;    │   └─ right
;    ├──Call
;    │   ├i─move
;    │   └─ i
;    ├──Call
;    │   ├i─turn
;    │   └─ back
;    └──Assignment
;       ├i─i
;       └─ i+1

label start
  call paint #1
  set r0 #0
  set r1 r0
  set r2 #1
  set r3 r2
  set r4 #1
  sub r4 #0 r4
  set r5 r4
  set r6 #2
  set r7 r6
label cond0
  set r8 #1
  set r9 #1
  test_eq r10 r8 r9
  goto end0 r10
  set r12 #1
  set r13 #1
  set r14 r1
  set r11 r12
label cond1
  test_le r15 r11 r14
  goto end1 r15
  set r16 #0
  set r17 r16
  call turn r7
  call move #1
  set r19 #1
  set r20 #1
  set r21 #2
  set r18 r19
label cond2
  test_le r22 r18 r21
  goto end2 r22
  call turn r5
  call move #1
  call pick r23
  set r24 r17
  set r25 r23
  add r24 r24 r25
  set r17 r24
  add r18 r18 r20
  goto cond2 #0
label end2
  call turn r5
  call move #1
  call turn r3
  set r26 r17
  set r27 #2
  test_eq r28 r26 r27
  goto else3 r28
  set r29 #0
  set r17 r29
  goto end3 #0
label else3
label end3
  call paint r17
  call move #1
  add r11 r11 r13
  goto cond1 #0
label end1
  call turn r5
  call move #1
  call turn r5
  call move r1
  call turn r7
  set r30 r1
  set r31 #1
  add r30 r30 r31
  set r1 r30
  goto cond0 #0
label end0
  stop
