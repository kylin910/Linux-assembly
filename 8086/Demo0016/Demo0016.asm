assume cs:code

code segment
	mov ax,0ffffH ;在汇编源程序中，数据不能以字母开头，所以要在前面加0.
	mov ds,ax
	mov bx,6
	mov al,[bx]
	mov ah,0
	sub dx,dx
	mov cx,3
s:	add dx,ax
	loop s

	mov ax,4c00H
	int 21H
code ends
end