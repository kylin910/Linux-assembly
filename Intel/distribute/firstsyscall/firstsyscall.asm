;可执行程序名：firstsyscall
;版本：1.0
;创建日期：9/4/2017
;最后修改日期：9/4/2017
;作者：kylin
;描述：一个简单的Linux下的汇编应用程序，使用NASM 2.11.08
;演示了Linux　INT 80H系统调用显示文本的用法
;使用这些命令生产：
;nasm -f elf -g -F stabs firstsyscall.asm
;ld -o firstsyscall firstsyscall.o

section .data

EatMsg: db "Eat at Joe's!",10
EatLen: equ $-EatMsg

section .bss
section .text

global _start
_start:
	nop	
	mov eax,4
	mov ebx,1
	mov ecx,EatMsg
	mov edx,EatLen
	int 80H	
	mov eax,1	
	mov ebx,0
	int 80H
