assume cs:code

code segment
	mov ax,cs
	mov ds,ax
	mov ax,0020H
	mov es,ax
	mov bx,0
	mov cx,18h ;或者此处可以改为sub cx,5,因为从debug加载程序的时候可以CX寄存器的值看出此程序的大小，用CX寄存器的值减去“mov ax,4c00H”指令所处的位置，正好等于5
s:	mov al,[bx]
	mov es:[bx],al
	inc bx
	loop s

	mov ax,4c00H
	int 21H
code ends
end