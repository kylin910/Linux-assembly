assume cs:code

code segment
	mov ax,0020H
	mov ds,ax
	mov bx,0
	mov cx,64

s:	mov ds:[bx],bl
	inc bx
	loop s

	mov ax,4c00H
	int 21H
code ends
end