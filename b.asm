.model small 

extrn str1:byte,str2:byte,strc:byte 

public concat,compare_p,occur_p 

.data 

msg_strx db 10,13,"Enter the string to check the occurances:-$" 

strx db 50H,?,50H dup("$") 

digit db 0 

word_c db 0 

space db 0 

u_case db 0 

l_case db 0 

special_char db 0 

msg_com db 10,13,"Strings are EQUAL$" 

msg_com1 db 10,13,"Strings are NOT EQUAL$" 

msg_word db 10,13,"Total WORDS:-$" 

msg_digit db 10,13,"No.of DIGITS:-$" 

msg_space db 10,13,"No.of SPACES:-$" 

msg_ucase db 10,13,"No.of UPPER CASE:-$" 

msg_lcase db 10,13,"No.of LOWER CASE:-$" 

msg_spec db 10,13,"No.of SPECIAL/OTHER SYMBOLS:-$" 


.code 

 mov ax,@data 

 mov ds,ax 

 mov es,ax 

 

 input macro var 

 mov ah,0aH 

 lea dx,var 

 int 21H 

 endm 

 

 show macro var 

 mov ah,09H 

 lea dx,var 

 int 21H 

 endm 

 

 output macro 

 mov ah,02H 

 int 21H 

 endm 

 

 mov ah,4cH 

 int 21H 

 

 

 

 

 


concat proc far 

 lea si,str1+2 

 lea di,strc 

 mov ch,00 

 mov cl,str1+1 

 cld 

 rep movsb 

 

 lea si,str2+2 

 mov ch,00 

 mov cl,str2+1 

 cld 

 rep movsb 

 

 ret 

 endp 

 

compare_p proc far 

 mov al,str1+1 

 mov bl,str2+1 

 cmp al,bl 

 jz next 

 show msg_com1 

 jmp exit 

 

 next:lea si,str1+2 

 lea di,str2+2 

 mov ch,00 

 mov cl,str1+1 


 cld 

 rep cmpsb 

 

 cmp cx,00 

 jnz next1 

 show msg_com 

 jmp exit 

 

 next1:show msg_com1 

 exit:ret 

 endp 

 

occur_p proc far 

 show msg_strx 

 input strx 

 show strx+2 

 lea si,strx+2 

 mov cx,00 

 mov cl,strx+1 

 

 again:mov al,[si] 

 cmp al,' ' 

 jb special_l 

 cmp al,' ' 

 ja next_a 

 inc space 

 inc word_c 

 jmp repeat 

 


 next_a:cmp al,'0' 

 jb special_l 

 cmp al,'9' 

 ja next_b 

 inc digit 

 jmp repeat 

 

 next_b:cmp al,'A' 

 jb special_l 

 cmp al,'Z' 

 ja next_c 

 inc u_case 

 jmp repeat 

 

 next_c:cmp al,'a' 

 jb special_l 

 cmp al,'z' 

 ja special_l 

 inc l_case 

 jmp repeat 

 

special_l:inc special_char 

 

 

 

 

 

 

 


 repeat:inc si 

 dec cx 

 jnz again 

 

 inc word_c 

 

 show msg_word 

 mov dl,word_c 

 add dl,30H 

 cmp dl,39H 

 jbe down1 

 add dl,07 

 down1:output 

 

 show msg_digit 

 mov dl,digit 

 add dl,30H 

 cmp dl,39H 

 jbe down2 

 add dl,07 

 down2:output 

 

 show msg_space 

 mov dl,space 

 add dl,30H 

 cmp dl,39H 

 jbe down_3 

 add dl,07 

 


 down_3:output 

 

 show msg_lcase 

 mov dl,l_case 

 add dl,30H 

 cmp dl,39H 

 jbe down3 

 add dl,07 

 down3:output 

 

 show msg_ucase 

 mov dl,u_case 

 add dl,30H 

 cmp dl,39H 

 jbe down4 

 add dl,07 

 down4:output 

 

 show msg_spec 

 mov dl,special_char 

 add dl,30H 

 cmp dl,39H 

 jbe down5 

 add dl,07 

 down5:output 

 ret 

 endp 

 

 end 