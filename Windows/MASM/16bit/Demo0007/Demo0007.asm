assume cs:code

code segment
	mov ax,123Bh	
	mov ds,ax	;��123BH����ds�У���Ϊ���ݶεĶε�ַ
	mov ax,0	;��ax����ۼӽ��
	add ax,[0]	;�����ݶε�һ���֣�ƫ�Ƶ�ַΪ0���ӵ�ax��
	add ax,[2]	;�����ݶε�һ���֣�ƫ�Ƶ�ַΪ2���ӵ�ax��
	add ax,[4]	;�����ݶε�һ���֣�ƫ�Ƶ�ַΪ4���ӵ�ax��

	mov ax,4c00h
	int 21h
code ends
end