assume cs:code

code segment

dw 0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H

start:	mov ax,0H
	mov ds,ax
	mov bx,0
	
	mov cx,8
s:	mov ax,ds:[bx]
	mov cs:[bx],ax
	add bx,2
	loop s
	
	mov ax,4c00H
	int 21H
code ends
end start