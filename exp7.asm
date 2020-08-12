org 00
ljmp start
multip_lb: db 34H
multip_hb: db 12H
multiplier: db 12H
start:	mov dptr,#multiplier
	clr a
	movc a,@a+dptr
	mov b,a
	
	mov dptr,#multip_lb
	clr a
	movc a,@a+dptr

	mul ab
	mov r1,b
	mov r2,a

	mov dptr,#multiplier
	clr a
	movc a,@a+dptr
	mov b,a

	mov dptr,#multip_hb
	clr a
	movc a,@a+dptr
	 	
	mul ab

	add a,r1
	jnc next
	inc b

next:	mov p0,b
	mov p1,a
	mov p2,r2
end