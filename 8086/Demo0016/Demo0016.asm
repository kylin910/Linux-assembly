assume cs:code

code segment
	mov ax,0ffffH ;�ڻ��Դ�����У����ݲ�������ĸ��ͷ������Ҫ��ǰ���0.
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