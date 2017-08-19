assume cs:code

code segment
	mov ax,2000H
	mov ds,ax
	mov ax,1000H
	mov ss,ax
	mov sp,0000H
	pop [E]
	pop [C]
	pop [A]
	pop [8]
	pop [6]
	pop [4]
	pop [2]
	pop [0]

	mov ax,4c00H
	int 21H
code ends
end