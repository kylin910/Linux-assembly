assume cs:code

code segment
	mov ax,1000H
	mov ss,ax
	mov sp,0010H
	mov ax,0123H
	push ax
	mov bx,2266H
	push bx
	mov cx,1122H
	push cx
	pop ax
	pop bx
	pop cx

	mov ax,4c00h
	int 21h
code ends
end