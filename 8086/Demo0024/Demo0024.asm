assume cs:code

code segment

dw 0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H
dw 0,0,0,0,0,0,0,0,0,0 ;10个字单元用作栈空间

start:	mov ax,cs
	mov ss,ax
	mov sp,0024H ;或36（因为该程序总共开辟了18个字单元，也就是36个字节单元（即从ss:0000H~:ss:0035H），将其当做栈的话，若栈为空，则栈顶指向ss:0036H）
	
	mov ax,0
	mov ds,ax
	mov bx,0
	
	mov cx,8
s:	push [bx]
	pop cs:[bx]
	add bx,2
	loop s
	
	mov ax,4c00H
	int 21H
code ends
end start