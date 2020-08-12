.model small
.data
sname db 25 dup(0)
dname db 25 dup(0)
h1 dw 0
h2 dw 0
buff db 10H dup('$')
msg_p db 10,13,"PARAMETER ERROR$"
msg_c db 10,13,"1 File(s) Copied!$"
msg_e1 db 10,13,"Error in creating source file!$"
msg_e2 db 10,13,"Error in creating destination file!$"
msg_e3 db 10,13,"Error in opening destination file!$"
msg_e4 db 10,13,"Error in reading source file!$"
msg_e5 db 10,13,"Error in writing destination file!$"
msg_e6 db 10,13,"Error in closing source file!$"
msg_e7 db 10,13,"Error in closing destination file!$"
msg_s db 10,13,"File opeartions handled$"
msg_dec db 10,13,"Do you want to overwrite the existing file?(Y/N):-$"
msg_e8 db 10,13,"Overwrite error!$"
.code
mov ax,@data
mov ds,ax
show macro var
mov ah,09H
lea dx,var
int 21H
endm
input macro
mov ah,01H
int 21H
endm
mov ah,62H ;return PSP base address
int 21H
mov es,bx
mov di,80H
mov al,es:[di] ;80H where count is stored, moved in al
cmp al,0 ;check if count is non-zero
jnz down ;perforn further operations
show msg_p
jmp exit
down:mov di,82H ;start reading source file name
lea si,sname
again:mov al,es:[di] ;continue till space is not encountered
cmp al,' '
jz down1
mov [si],al
inc si
inc di
jmp again
down1:inc di
lea si,dname ;start reading destination file name
up:mov al,es:[di] ;continue till enter key is encountered
cmp al,0DH
jz down2
mov [si],al
inc si
inc di
jmp up
down2:show msg_c
mov ah,3Dh ;opening source file in read mode
lea dx,sname
mov al,0 ;0->read 1->write 2->read/write
int 21H
jmp overwrite
show msg_e1
jmp exit
overwrite:
mov h1,ax
mov ah,5BH
mov cx,0
lea dx,dname
int 21H
jnc d_create
show msg_dec
input
cmp al,'Y'
jz d_create
show msg_e8
jmp exit
d_create:
mov ah,3Ch ;creating destination file
lea dx,dname
mov cx,0 ;read only
int 21H
jnc d_open
show msg_e2
jmp exit
d_open:
mov ah,3Dh ;open destination file
lea dx,dname
mov al,02 ;read/write
int 21H
jnc s_read
show msg_e3
jmp exit
s_read:mov h2,ax ;reading source file
again1:mov ah,3FH
mov bx,h1
mov cx,10H ;can be equal/greater:No.of bytes=10H byte
lea dx,buff
int 21H
jnc d_write
show msg_e4
jmp exit
d_write: cmp ax,0
jz s_close
mov ah,40H ;writing destination file
mov bx,h2
mov cx,10H
lea dx,buff
int 21H
jnc again1
show msg_e5
jmp exit
s_close:
mov ah,3Eh ;closing source file
mov bx,h1
int 21H
jnc d_close
show msg_e6
jmp exit
d_close:
mov ah,3Eh ;closing destination file
mov bx,h2
jnc success
show msg_e7
jmp exit
success:show msg_s
exit:mov ah,4cH
int 21h
end