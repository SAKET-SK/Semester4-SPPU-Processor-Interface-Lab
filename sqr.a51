//Generation of square wave of 2KHz using Timer 0 in mode 1
org 00
sjmp start
start:	mov TMOD,#01H    ;operates timer 0 in mode 1
	mov TH0,#0FFH
	mov TL0,#1AH

	cpl p1.1
	clr TF0
	setb TR0

here:	jnb TF0,here
	clr TR0
	clr TF0
	cpl p1.1

	mov TH0,#0FFH
	mov TL0,#1AH

	setb TR0
	ljmp here
	end
	