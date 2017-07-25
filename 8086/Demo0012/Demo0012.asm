assume cs:code

code segment
	mov ax,1000H
	mov ds,ax
	mov ax,2000H
	mov ss,ax
	mov sp,0010H
	push [0]
	push [2]
	push [4]
	push [6]
	push [8]
	push [A]
	push [C]
	push [E]

	mov ax,4c00H
	int 21H
code ends
end