.model small
.data
count db 0
num dw 0
msg_1 db 10,13,"Enter FOUR DIGIT HEX number:-$"
msg_c db 10,13,"Equivalent BCD:-$"
.code
mov ax,@data
mov ds,ax
input macro
mov ah,01H
int 21H
endm
output macro
mov ah,02H
int 21H
endm
show macro var
mov ah,09H
lea dx,var
int 21H
endm
call accept
show msg_c
call convert_p
mov ah,4cH
int 21H
accept proc near
show msg_1
mov ch,04 ;digit count
mov cl,04 ;rotate count
mov bx,00
up: rol bx,cl
input
sub al,30H
cmp al,09H
jbe down
sub al,07H
down:add bl,al
dec ch
jnz up
mov num,bx
ret
endp
convert_p proc near
mov ax,num
mov dx,0
mov bx,0AH
up1:div bx
push dx
inc count
mov dx,0
cmp ax,0
jnz up1
up2:pop dx
add dl,30H
output
dec count
jnz up2
ret
endp
end
