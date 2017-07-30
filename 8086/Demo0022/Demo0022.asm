assume cs:code

code segment
	dw 0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H
	dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

start:	mov ax,cs
	mov ss,ax
	mov sp,0030H
	
	mov bx,0
	mov cx,8

s:	push cs:[bx]
	add bx,2
	loop s

	mov bx,0
	mov cx,8

s0:	pop cs:[bx]
	add bx,2
	loop s0

	mov ax,4c00H
	int 21H
code ends
end start