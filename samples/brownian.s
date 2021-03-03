; Main
; └──While
;    ├c─1==1
;    ├──Call
;    │   ├i─paint
;    │   └─ 1
;    ├──Call
;    │   ├i─random
;    │   └─ a
;    ├──Assignment
;    │   ├i─a
;    │   └─ a+a
;    ├──Call
;    │   ├i─random
;    │   └─ b
;    ├──Assignment
;    │   ├i─a
;    │   └─ a+b
;    ├──Call
;    │   ├i─turn
;    │   └─ a
;    └──Call
;       ├i─move
;       └─ 1

label start
label cond0
  set r0 #1
  set r1 #1
  test_eq r2 r0 r1
  goto end0 r2
  call paint #1
  call random r3
  set r4 r3
  set r5 r3
  add r4 r4 r5
  set r3 r4
  call random r6
  set r7 r3
  set r8 r6
  add r7 r7 r8
  set r3 r7
  call turn r3
  call move #1
  goto cond0 #0
label end0
  stop
