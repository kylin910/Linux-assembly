section .text
global main
main:
mov eax,4
mov ebx,1
mov ecx,msg
mov edx,14
int 80h
mov eax,1
int 80h
msg:
db "Hello World!",0ah,0dh
