assume cs:code

code segment
	mov ax,1000H
	mov ds,ax
	mov ax,[0]
	mov bx,[2]
	mov cx,[1]
	add bx,[1]
	add cx,[2]

	mov ax,4c00h
	int 21h
code ends
end