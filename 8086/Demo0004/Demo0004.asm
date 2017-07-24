assume cs:code

code segment
	mov ax,0000h
	add ax,0123h
	mov bx,ax
	jmp bx
	mov ax,4c00h
	int 21h
code ends
end