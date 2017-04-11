#程序名:cpuid2.s
#功能:使用Ｃ库函数调用查看处理器生产商ID


#定义数据段:
.section .data
output:.asciz "The processor Vendor ID is '%s'\n"

#定义动态数据段:
.section .bss
.lcomm buffer, 12

#定义代码段:
.section .text

.globl _start

_start:
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
