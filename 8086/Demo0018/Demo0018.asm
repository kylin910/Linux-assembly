assume cs:code

code segment
	mov ax,0ffffH 
	mov ds,ax	;����dsֵΪFFFF
	mov bx,000AH	;����ƫ�Ƶ�ַΪ000A��ʹ�õ�ǰָ��ds:[000A]�ֵ�Ԫ

	mov ax,0020H
	mov ss,ax	
	mov sp,000CH	;����ջ�ε�ջ��ss:spָ��0020:000C,��ʱջΪ��

	mov cx,6	;����ѭ������Ϊ6��
s:	push ds:[bx]	;��ds:[bx]����ffff:000A�ֵ�Ԫ���е�������ջ
	sub bx,2	;��ƫ�Ƶ�ַ��2��ʹ��ָ��ds:[bx]����ffff:0008��
	loop s		;ѭ����ת������ѹջ
	
	mov ax,4c00H
	int 21H
code ends
end