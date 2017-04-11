#程序名:DataDefine.s
#功能:演示如何定义数据

#声明数据段
.section .data

#声明一个字符串常量
output1:.ascii "This is a string."

#声明一个以空字符结尾的文本字符串
output2:.asciz "This is a string with the end 0A."

#声明一个字节值
bvalue:.byte 0x0A

#声明一个双精度浮点数
douvalue:.double 3.1415926

#声明一个单精度浮点数
flovalue:.float 3.14

#声明一个32位整数
intvalue:.int 32

#声明一个32位整数（和.int相同）
longvalue:.long 32

#声明一个16字节整数
octavalue:.octa 1048576

#声明一个8字节整数
quadvalue:.quad 65536

#声明一个16位整数
shortvalue:.short 256

#声明一个单精度浮点数(和.float相同)
singlevalue:.single 3.14

#一行定义多个数据元素
length:.int 62,35,47
factors:.double 37.45,45.33,12.30

#定义静态符号
.equ factor,3
.equ LINUX_SYS_CALL,0X80

#声明代码段
.section .text

#声明程序入口
.globl _start

_start:
	nop
	#对静态数据元素进行引用
	movl $LINUX_SYS_CALL,%EAX
	#调用80H中断，退出程序
	movl $1,%EAX
	movl $0,%EBX
	int $0x80
