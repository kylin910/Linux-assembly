assume cs:code

data segment

     db 'welcome to masm!'

data ends

code segment

start:   mov ax,data

     mov ds,ax

     mov ax,0b800h

     mov es,ax

     mov bx,0720h                ;设置中间行中间列的首地址   

     mov si,0

     mov cx,16

s:   mov ax,[si]

     mov ah,2h

     mov es:[bx],ax              ;设置绿色字体

     mov ah,24h

     mov es:[bx].0a0h,ax         ;设置绿底红色

     mov ah,71h

     mov es:[bx].0a0h.0a0h,ax    ;设置白底蓝色

     inc si                      ;指向下一字符

     add bx,2                    ;指向下一显存单元

     loop s

     mov ax,4c00h

     int 21h

code ends

end start
