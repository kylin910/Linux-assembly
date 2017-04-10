;可执行程序名：HelloWorld
;作者：kylin
;版本：1.0
;创建日期：2017/4/10
;最终修改日期：2017/4/10
;编译器：NASM version 2.11.08
;编译指令：nasm -f elf -g -F stabs HelloWorld.asm
;连接指令：ld -o HelloWorld HelloWorld.o

section .data
PrintMsg:db "Hello World!",10
PrintMsgLen:equ $-PrintMsg

section .bss

section .text

global _start

_start:
    nop
    mov eax,4
    mov ebx,1
    mov ecx,PrintMsg
    mov edx,PrintMsgLen
    int 80H
    mov eax,1
    mov ebx,0
    int 80H
