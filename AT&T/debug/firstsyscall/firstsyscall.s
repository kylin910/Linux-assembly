.section .data

EatMsg: db "Eat at Joe's!",10
EatLen: equ $-EatMsg

.section .bss ;包含未初始化的数据段
.section .text ;包含代码的段

.global _start　;连接器需要根据此找到入口点

_start:
	nop		;这个无操作指令让gdb非常高兴
	movl eax,4	;指定sys_write系统调用
	movl ebx,1	;指定文件描述符１：标准输出
	movl ecx,EatMsg	;传递显示信息的偏移地址
	movl edx,EatLen	;传递显示信息的长度
	int 80H		;进行系统调用来输出文本到标准输出
	movl eax,1	;指定Exit系统调用
	movl ebx,0	;返回一个零代码
	int 80H		;进行系统调用来终止程序
