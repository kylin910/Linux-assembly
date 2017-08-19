assume cs:code,ds:data,es:table

data segment

     db 'welcome to masm!'

data ends

table segment

     dw 4000 dup (0)

table ends

code segment

start:   mov ax,data

     mov ds,ax

     mov ax,0b800h

     mov es,ax

     mov bx,0

     mov si,0

     mov cx,16

 

s0:  mov ax,[bx]

     mov es:[bx+720h][si],ax

     mov al,2

     mov es:[bx+721h][si],al

     inc bx

     inc si

    loop s0

 

     mov bx,0

     mov cx,16

     mov si,160

s1:  mov ax,[bx]

     mov es:[bx+720h][si],ax

     mov al,36

     mov es:[bx+721h][si],al

     inc bx

     inc si

     loop s1

 

     mov bx,0

     mov cx,16

     mov si,320

s2:  mov ax,[bx]

     mov es:[bx+720h][si],ax

     mov al,113

     mov es:[bx+721h][si],al

     inc bx

     inc si

     loop s2

 

     mov ax,4c00h

     int 21h

code ends

end start

