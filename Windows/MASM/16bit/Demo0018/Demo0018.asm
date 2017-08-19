assume cs:code

code segment
	mov ax,0ffffH 
	mov ds,ax	;设置ds值为FFFF
	mov bx,000AH	;设置偏移地址为000A，使得当前指向ds:[000A]字单元

	mov ax,0020H
	mov ss,ax	
	mov sp,000CH	;设置栈段的栈顶ss:sp指向0020:000C,此时栈为空

	mov cx,6	;设置循环次数为6次
s:	push ds:[bx]	;将ds:[bx]（即ffff:000A字单元）中的内容入栈
	sub bx,2	;将偏移地址减2，使其指向ds:[bx]（即ffff:0008）
	loop s		;循环跳转，继续压栈
	
	mov ax,4c00H
	int 21H
code ends
end