该程序用于测试访问起始地址为10000H的数据段中的数据，数据段的段地址默认存放在ds寄存器中，
8086CPU不支持直接改变段寄存器的值，因此使用一个通用寄存器作为中转，来改变段寄存器ds的值。具体做法是：
1）mov ax,1000H
2）mov ds,ax
此后，数据段的段地址就被设定了。
