assume cs:code

code segment
	mov ax,1000H
	mov ss,ax
	mov sp,0010H
	push ax
	push bx
	push ds

	mov ax,4c00H
	int 21H
code ends
end