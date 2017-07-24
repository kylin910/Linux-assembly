assume cs:code

code segment
	mov ax,123Bh	
	mov ds,ax	;将123BH送入ds中，作为数据段的段地址
	mov ax,0	;用ax存放累加结果
	add ax,[0]	;将数据段第一个字（偏移地址为0）加到ax中
	add ax,[2]	;将数据段第一个字（偏移地址为2）加到ax中
	add ax,[4]	;将数据段第一个字（偏移地址为4）加到ax中

	mov ax,4c00h
	int 21h
code ends
end