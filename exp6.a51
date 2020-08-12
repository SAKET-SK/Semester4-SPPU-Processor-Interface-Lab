org 00
ljmp start
arr : db 11H,12H,13H,14H,15H
start: mov r0,#0
          mov r1,#0
          mov r2,#5
          mov dptr,#arr
up:     clr a
           movc a,@a+dptr
           add a,r0
           jnc next
           inc r1
next:   mov r0,a
           inc dptr
           djnz r2,up
           mov p0,r1
           mov p1,r0
           end