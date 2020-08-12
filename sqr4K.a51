//Generation of Square wave of 4KHz using Timer 1 in Mode 2
org 00H
sjmp start
start:	mov TMOD,#20H
	mov TH1,#8DH

	cpl p1.1
	clr TF1
	setb TR1

here:	jnb TF1,here
	clr TR1
	clr TF1
	cpl p1.1

	setb TR1
	ljmp here
	end
