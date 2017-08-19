assume cs:codesg

codesg segment

	mov ax,1
	add ax,ax
	mov ax,4c00h
	int 21h
codesg ends
end