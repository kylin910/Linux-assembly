assume cs:code

code segment
	mov bx,0
	mov cx,6

s:	mov ax,0ffffH
	mov ds,ax
	mov dx,ds:[bx]

	mov ax,0020H
	mov ds,ax
	mov ds:[bx],dx
	add bx,2
	loop s

	mov ax,4c00H
	int 21H
code ends
end