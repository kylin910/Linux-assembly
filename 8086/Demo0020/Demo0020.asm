assume cs:code

code segment
	mov ax,cs
	mov ds,ax
	mov ax,0020H
	mov es,ax
	mov bx,0
	mov cx,18h ;���ߴ˴����Ը�Ϊsub cx,5,��Ϊ��debug���س����ʱ�����CX�Ĵ�����ֵ�����˳���Ĵ�С����CX�Ĵ�����ֵ��ȥ��mov ax,4c00H��ָ��������λ�ã����õ���5
s:	mov al,[bx]
	mov es:[bx],al
	inc bx
	loop s

	mov ax,4c00H
	int 21H
code ends
end