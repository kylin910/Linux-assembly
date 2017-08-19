程序说明：
下面的程序实现依次用内存0:0~0:15单元中的内容改写程序中的数据，数据的传送用栈来进行。栈空间设置在程序内。完成程序：

assume cs:code

code segment

dw 0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H
dw 0,0,0,0,0,0,0,0,0,0 ;10个字单元用作栈空间

start:	mov ax,___
	mov ss,ax
	mov sp,___
	
	mov ax,0
	mov ds,ax
	mov bx,0
	
	mov cx,8
s:	push [bx]
	_________
	add bx,2
	loop s
	
	mov ax,4c00H
	int 21H
code ends
end start