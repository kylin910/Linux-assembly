����˵����
����ĳ���ʵ���������ڴ�0:0~0:15��Ԫ�е����ݸ�д�����е����ݣ����ݵĴ�����ջ�����С�ջ�ռ������ڳ����ڡ���ɳ���

assume cs:code

code segment

dw 0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H
dw 0,0,0,0,0,0,0,0,0,0 ;10���ֵ�Ԫ����ջ�ռ�

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