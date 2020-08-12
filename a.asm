.model small 

public str1,str2,strc 

extrn concat:far,compare_p:far,occur_p:far 

.data 

str1 db 25H,?,25H dup("$") 

str2 db 25H,?,25H dup("$") 

strc db 50H dup("$") 

msg_e1 db 10,13,"Enter String 1:-$" 

msg_e2 db 10,13,"Enter String 2:-$" 

msg_c db 10,13,"Concatenated Ouptut:-$" 

menu db 10,13,"1)Concat 2 Strings" 

 db 10,13,"2)Compare 2 Strings" 

 db 10,13,"3)Check Occurances" 

 db 10,13,"4)Exit" 

 db 10,13,"Enter your choice code:-$" 

 

.code 

 mov ax,@data 

 mov ds,ax 

 mov es,ax 


 

 show macro var 

 mov ah,09H 

 lea dx,var 

 int 21H 

 endm 

 

 show msg_e1 

 mov ah,0aH 

 lea dx,str1 

 int 21H 

 

 show msg_e2 

 mov ah,0aH 

 lea dx,str2 

 int 21H 

 

 menu_l:show menu 

 mov ah,01H 

 int 21H 

 

 cmp al,31H 

 jnz next2 

 call concat 

 show msg_c 

 show strc 

 jmp menu_l 

 


 next2:cmp al,32H 

 jnz next3 

 call compare_p 

 jmp menu_l 

 

 next3:cmp al,33H 

 jnz next4 

 call occur_p 

 jmp menu_l 

 

 

 next4: mov ah,4cH 

 int 21H 

 end 

 

 mov ah,4cH 

 int 21H 

 end 

 
