assume cs:code

data segment

     db 'welcome to masm!'

data ends

code segment

start:   mov ax,data

     mov ds,ax

     mov ax,0b800h

     mov es,ax

     mov bx,0720h                ;�����м����м��е��׵�ַ   

     mov si,0

     mov cx,16

s:   mov ax,[si]

     mov ah,2h

     mov es:[bx],ax              ;������ɫ����

     mov ah,24h

     mov es:[bx].0a0h,ax         ;�����̵׺�ɫ

     mov ah,71h

     mov es:[bx].0a0h.0a0h,ax    ;���ð׵���ɫ

     inc si                      ;ָ����һ�ַ�

     add bx,2                    ;ָ����һ�Դ浥Ԫ

     loop s

     mov ax,4c00h

     int 21h

code ends

end start
