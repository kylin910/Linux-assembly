#程序名:movtest2.s
#功能:演示如何将一个寄存器值传送到指定内存位置处

.section .data
value:.int 1

.section .text

.globl _start

_start:
	nop
	movl $100,%eax
	movl %eax,value
	movl $1,%eax
	movl $0,%ebx
	int $0x80
