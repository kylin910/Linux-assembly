assume cs:code

code segment

dw 0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H
dw 0,0,0,0,0,0,0,0,0,0 ;10���ֵ�Ԫ����ջ�ռ�

start:	mov ax,cs
	mov ss,ax
	mov sp,0024H ;��36����Ϊ�ó����ܹ�������18���ֵ�Ԫ��Ҳ����36���ֽڵ�Ԫ������ss:0000H~:ss:0035H�������䵱��ջ�Ļ�����ջΪ�գ���ջ��ָ��ss:0036H��
	
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