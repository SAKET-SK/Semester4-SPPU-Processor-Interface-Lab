;TITLE Write an assembly language program to add array on n numbers stored into the memory
;NAME:-SAKET.S.KHOPKAR      ROLL NO:-SI072
.model small
.data                ; data segment starts
arr db 6 dup(0)      ;array arr for 6 digits with 0 duplicate values  
carry db 0           ;variable for storing carry
count db 6           ;for storing count 
count1 db 0
res db 0             ;result variable
msg db 10,13,"Result of addition is $"       ;message display
msg1 db 10,13,"Enter two digit number $"

.code
        mov ax,@data
        mov ds,ax                          ;activates data segment

        input macro         ;macro for input the numbers
        mov ah,01           ;function value for input
        int 21H
        endm                 ;end of input macro

        output macro        ;macro for display output
        mov ah,02           ;function value for display
        int 21H
        endm                 ;end of output macro



        show macro var         ;show macro for message display
        mov ah,09              ;function value for string input
        lea dx,var
        int 21H
        endm                   ;end of show macro

        mov al,count
        mov count1,al
        lea si,arr

 again1:show msg1
        call accept                    ;calling accept procedure
        mov [si],bl                    ;input numbers
        inc si
        dec count1
        jnz again1

        mov ch,0
        mov cl,count
        lea si,arr
        mov dl,0

  again:add dl,[si]
        jnc next
        inc carry




   next:inc si
        loop again

        mov res,dl
        show msg
        mov dl,carry
        add dl,30H
        output                     ;call output macro

        call print                 ;call print procedure
        mov ah,4cH                 ;terminate program
        int 21H

  accept proc near                 ;accept procedure definition
         mov bl,0
         mov ch,02                 ;digit count
         mov cl,04                 ;rotation count

  up1:  rol bl,cl                 ;writing input logic
        input                     ;calling input macro
        sub al,30H                
        cmp al,09
        jbe down1
        sub al,7
  down1:add bl,al
        dec ch
        jnz up1
        ret
        endp                       ;end of accept procedure
  print proc near                   ;print procedure definition
        mov dh,res
        mov cl,04                   ;rotation count
        mov ch,02                   ;digit count

  up:   rol dh,cl                   ;writing display logic
        mov dl,dh
        and dl,0fH
        add dl,30H
        cmp dl,39H
        jbe down
        add dl,07

  down: output                ;call the output macro
        dec ch
        jnz up

        ret
        print endp            ;end of print procedure
        end                   ;end of the program





                
