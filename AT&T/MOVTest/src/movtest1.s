#程序名:movtest1.s
#功能:演示如何将数据从内存位置处传送至寄存器

#定义数据段
.section .data
#声明变量value,并初始化为32位整数１
value:.int 1

#定义代码段
.section .text

#声明起始点
.globl _start

_start:
	nop
	#将标签value处的4字节值传送给ecx寄存器
      	movl value,%ecx
      	movl $1,%eax
      	movl $0,%ebx
      	int $0x80

