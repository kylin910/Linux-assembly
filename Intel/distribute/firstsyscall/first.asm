;可执行程序名：firstsyscall
;版本：1.0
;创建日期：9/4/2017
;最后修改日期：9/4/2017
;作者：kylin
;描述：一个简单的Linux下的汇编应用程序，使用NASM 2.11.08
;演示了Linux INT 80H系统调用显示文本的用法
;使用这些命令生产：
;nasm -f elf -g -F stabs firstsyscall.asm
;ld -o firstsyscall firstsyscall.o

section .data

EatMsg:db "Eat at Joe's!",10
EatLen:equ $-EatMsg

section .bss ;包含未初始化的数据段
section .text ;包含代码的段

global _start:

_start:
	nop ;这个无操作指令让gdb很高兴
	mov eax,4 ;指定sys_write系统调用
	mov ebx,1 ;指定文件描述符1:标准输出
	mov ecx,EatMsg ;传递显示信息的偏移地址
	mov edx,EatLen ;传递显示信息的长度
	int 80H ;进行系统调用来输出文本到标准输出
	mov eax,1 ;指定Exit系统调用
	mov ebx,0 ;返回一个零代码
	int 80H ;进行系统调用来终止程序
