TITLE:-Write an ALP to perform following string operations using near procedure
1) Find and reverse Length   2) Display reverse   3)Check palindrome
;NAME:-SAKET.S.KHOPKAR            ROLL NO:-SI072
.model small
.data
str1 db 25,?,25 dup("$")                ;original string
str2 db 25H dup("$")       ; for reverse and palindrome op
msg_a db 10,13,"Enter String:-$"
msg_d db 10,13,"Accepted String:-$"
msg_l db 10,13,"Length of string is:-$"
msg_r db 10,13,"Reverse of the string is:-$"
menu db 10,13,"1)Accept and Display string"
     db 10,13,"2)Calculate Length"
     db 10,13,"3)Reverse the Original string"
     db 10,13,"4)Check if Palindrome"
     db 10,13,"5)Exit"
     db 10,13,"Enter your choice code:-$"
msg_p1 db 10,13,"String is Palindrome$"
msg_p2 db 10,13,"String is not palindrome$"
line db 10,13,"-----------------------------------------$"

.code
        mov ax,@data
        mov ds,ax
        mov es,ax         ;data and extra segment initialized

        output macro               
        mov ah,02
        int 21H
        endm

        show macro var
        mov ah,09H
        lea dx,var
        int 21H
        endm

menu_l: show menu
        mov ah,01H      ;input a single digit
        int 21H

        cmp al,31H       ;if choice code is 1, HEX ASCII is 31
        jnz next         ;internally subtraction is done
        call accept      ;accept and display number
        jmp menu_l

  next: cmp al,32H       ;if choice code 2,HEX ASCII is 32
        jnz next1
        call length_p
        jmp menu_l



  next1:cmp al,33H
        jnz next2
        call reverse_p
        jmp menu_l

  next2:cmp al,34H
        jnz next3
        call palindrome_p
        jmp menu_l

   next3:mov ah,4cH                ;terminate is exit choice
        int 21H
        
        mov ah,4cH
        int 21H

        accept proc near     ;procedure to accept and display
        show msg_a
        mov ah,0aH      ;function value for accepting string
        lea dx,str1
        int 21H
  
        show msg_d
        show str1+2
        show line
        ret
        endp
        length_p proc near      ;procedure to calculate length
        show msg_l
        mov dl,str1+1
        add dl,30H
        cmp dl,39H
        jbe down
        add dl,07

  down: output
        show line
        ret
        endp

        reverse_p proc near           ;procedure to reverse 
        lea si,str1+1
        mov ch,00
        mov cl,str1+1
        add si,cx
        lea di,str2
  again:mov al,[si]
        mov [di],al

        inc di
        dec si
        loop again
        show msg_r
        show str2
        show line
        ret
        endp

        palindrome_p proc near     ;procedure for palindrome
        call reverse_p
        lea si,str1+2
        lea di,str2
        mov ch,00
        mov cl,str1+1
        cld
        repz cmpsb
        cmp cx,00
        jnz next4
        show msg_p1
        show line
        jmp ret1
   next4:show msg_p2
        show line
   ret1:ret
        endp

        end




 
 
 
