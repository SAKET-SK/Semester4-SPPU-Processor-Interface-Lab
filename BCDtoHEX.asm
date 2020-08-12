.model small
.data
arr db 5 dup(0)
count db 5
res dw 0
var db 0
msg db 10,13,"Enter BCD NUMBER:-$"
msg_c db 10,13,"Equivelent HEX:-$"
msg1 db 10,13,"WRONG INPUT PLEASE ENTER THE NO AGAIN$"
.code
mov ax,@data
mov ds,ax
output macro
mov ah,02h
int 21h
endm
show macro var
mov ah,09h
lea dx,var
int 21h
endm
input macro
mov ah,01h
int 21h
endm
call accept
show msg_c
call convert
call display_n
mov ah,4ch
int 21h
accept proc near
lea si,arr
show msg
mov ch,0
mov cl,count
up:input
sub al,30h
cmp al,09h
jbe down
show msg1
jmp up
down:mov [si],al
inc si
loop up; dec cx, jnz up
ret
endp
convert proc near
lea si,arr
dec count
mov ah,0
mov al,[si]
mov bx,0Ah
up1:mul bx
inc si
mov ch,0
mov cl,[si]
add ax,cx
dec count
jnz up1
mov res,ax
ret
endp
display_n proc near
mov bx,res
mov cl,04h
mov ch,04h
up2:rol bx,cl
mov dl,bl
and dl,0fh
add dl,30h
cmp dl,39h
jbe next
add dl,07h
next:output
dec ch
jnz up2
ret
endp
end