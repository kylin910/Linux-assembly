程序说明：
下面的程序实现依次用内存0:0~0:15单元中的内容改写程序中数据，完成程序：
assume cs:code

code segment

dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h

start:	mov ax,0
	mov ds,ax
	mov bx,0
	
	mov cx,8
s:	mov ax,[bx]
	     ?
	___________
	
	add bx,2
	loop s
	
	mov ax,4c00H
	int 21H
code ends
end