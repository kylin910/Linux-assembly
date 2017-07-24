assume cs:code

code segment
	mov ax,123BH
	mov ds,ax
	mov al,0
	add al,[0]
	add al,[1]
	add al,[2]	

	mov ax,4c00H
	int 21H
code ends
end