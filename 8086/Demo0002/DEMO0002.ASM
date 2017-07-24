assume cs:codesg

codesg segment
	mov ax,4e20h
	add ax,1406h
	mov bx,2000h
	add ax,bx
	mov bx,ax
	add ax,bx

	mov ax,4c00h
	int 21h
codesg ends
end