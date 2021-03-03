; Main
; ├──Assignment
; │   ├i─left
; │   └─ 1
; ├──Assignment
; │   ├i─right
; │   └─ -1
; ├──Assignment
; │   ├i─back
; │   └─ 2
; ├──Assignment
; │   ├i─state
; │   └─ 0
; └──While
;    ├c─1==1
;    ├──Call
;    │   ├i─pick
;    │   └─ color
;    ├──Branch
;    │   ├c─state==0
;    │   ├i─┐
;    │   │  └──Branch
;    │   │     ├c─color==0
;    │   │     ├i─┐
;    │   │     │  ├──Call
;    │   │     │  │   ├i─paint
;    │   │     │  │   └─ 1
;    │   │     │  ├──Call
;    │   │     │  │   ├i─turn
;    │   │     │  │   └─ left
;    │   │     │  └──Assignment
;    │   │     │     ├i─state
;    │   │     │     └─ 0
;    │   │     e
;    │   │     ├──Call
;    │   │     │   ├i─paint
;    │   │     │   └─ 1
;    │   │     ├──Call
;    │   │     │   ├i─turn
;    │   │     │   └─ right
;    │   │     └──Assignment
;    │   │        ├i─state
;    │   │        └─ 1
;    │   e
;    │   └──Branch
;    │      ├c─color==0
;    │      ├i─┐
;    │      │  ├──Call
;    │      │  │   ├i─paint
;    │      │  │   └─ 0
;    │      │  ├──Call
;    │      │  │   ├i─turn
;    │      │  │   └─ right
;    │      │  └──Assignment
;    │      │     ├i─state
;    │      │     └─ 0
;    │      e
;    │      ├──Call
;    │      │   ├i─paint
;    │      │   └─ 0
;    │      ├──Call
;    │      │   ├i─turn
;    │      │   └─ left
;    │      └──Assignment
;    │         ├i─state
;    │         └─ 1
;    └──Call
;       ├i─move
;       └─ 1

label start
  set r0 #1
  set r1 r0
  set r2 #1
  sub r2 #0 r2
  set r3 r2
  set r4 #2
  set r5 r4
  set r6 #0
  set r7 r6
label cond0
  set r8 #1
  set r9 #1
  test_eq r10 r8 r9
  goto end0 r10
  call pick r11
  set r12 r7
  set r13 #0
  test_eq r14 r12 r13
  goto else1 r14
  set r15 r11
  set r16 #0
  test_eq r17 r15 r16
  goto else2 r17
  call paint #1
  call turn r1
  set r18 #0
  set r7 r18
  goto end2 #0
label else2
  call paint #1
  call turn r3
  set r19 #1
  set r7 r19
label end2
  goto end1 #0
label else1
  set r20 r11
  set r21 #0
  test_eq r22 r20 r21
  goto else3 r22
  call paint #0
  call turn r3
  set r23 #0
  set r7 r23
  goto end3 #0
label else3
  call paint #0
  call turn r1
  set r24 #1
  set r7 r24
label end3
label end1
  call move #1
  goto cond0 #0
label end0
  stop
