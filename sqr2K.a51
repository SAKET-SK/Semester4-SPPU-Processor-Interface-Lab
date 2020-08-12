//Generation of Square wave of 2KHz using interrupts using Timer 1 in mode 1
org 00H
sjmp start

org 001BH    ;address of internal timer ET1
clr TR1

mov TH1,#0FFH
mov TL1,#1AH

cpl p1.1
setb TR1
reti               ;returns to the point where it was called

start:	mov TMOD,#10H
	mov TH1,#0FFH
	mov TL1,#1AH

	cpl p1.1
	
	setb EA
	setb ET1
	setb TR1

here:	sjmp here
	end

