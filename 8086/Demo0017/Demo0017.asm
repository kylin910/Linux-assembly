assume cs:code

code segment
	mov ax,0ffffH
	mov ds,ax
	mov bx,0
	mov dx,0
	mov cx,12
s:	mov ah,0
	mov al,ds:[bx]
	add dx,ax
	inc bx
	loop s

	mov ax,4c00H
	int 21H
code ends
end
