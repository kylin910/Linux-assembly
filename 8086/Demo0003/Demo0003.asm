assume cs:codesg

codesg segment
	mov ax,001Ah
	mov bx,0026h
	add al,bl
	add ah,bl
	add bh,al
	mov ah,0
	add al,85h
	add al,93h

	mov ax,4c00h
	int 21h
codesg ends
end