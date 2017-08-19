assume cs:code

code segment
	mov ax,1000H
	mov ss,ax
	mov sp,0010H
	mov ax,001AH
	mov bx,001BH
	push ax
	push bx
	pop ax
	pop bx

	mov ax,4c00H
	int 21H
code ends
end