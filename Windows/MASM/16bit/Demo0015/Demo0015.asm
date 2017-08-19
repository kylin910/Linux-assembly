assume cs:code

code segment
	mov ax,236
	mov cx,122
s:	add ax,ax
	loop s

	mov ax,4c00H
	int 21H
code ends
end