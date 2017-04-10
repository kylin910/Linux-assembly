.section .data
Msg:db "Hello World!",10
MsgLen:equ $-Msg

.section .bss

.section .text

.globl main

main:
	nop
	mov $4,%eax
	mov $1,%ebx,
	mov $Msg,%ecx
	mov $MsgLen,%edx
	int $0x80
	mov $1,%eax
	mov $0,%ebx
	int $0x80
