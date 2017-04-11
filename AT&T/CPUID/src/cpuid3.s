#程序名:cpuid3.s View the CPUID Vendor ID string using C library calls
#功能:使用Ｃ库函数调用显示处理器生产商ID

#定义数据段:
.section .data
output:.asciz "The processor Vendor ID is '%s'\n"

#定义动态数据段:
.section .bss
.lcomm buffer, 12

#定义代码段:注意此时的入口符号引用使用了main,因为要使用gcc编译器对该源程序文件进行编译时，必须将入口符号引用写成main
.section .text

.globl main

main:
    movl $0, %eax
    cpuid
    movl $buffer, %edi
    movl %ebx, (%edi)
    movl %edx, 4(%edi)
    movl %ecx, 8(%edi)
    pushl $buffer
    pushl $output
    call printf
    addl $8, %esp
    pushl $0
    call exit
