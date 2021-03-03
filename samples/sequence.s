; Main
; ├──Assignment
; │   ├i─a
; │   └─ 6-7
; ├──Assignment
; │   ├i─b
; │   └─ -a+7
; └──Assignment
;    ├i─c
;    └─ a

label start
  set r0 #6
  set r1 #7
  sub r0 r0 r1
  set r2 r0
  set r3 r2
  sub r3 #0 r3
  set r4 #7
  add r3 r3 r4
  set r5 r3
  set r6 r2
  set r7 r6
  stop
