#程序名:BSSTest3.s
#功能:演示.bss段的使用

.section .data
buffer:.fill 10000

.section .text

.globl _start

_start:
	movl $1,%eax
	movl $0,%ebx
	int $0x80


