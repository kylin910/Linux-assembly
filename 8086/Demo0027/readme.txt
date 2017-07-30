程序说明：
将下面的程序编译连接，用Debug加载、跟踪，然后回答问题
assume cs:code,ds:data,ss:stack

data segment
	dw 0123H,0456H
data ends

stack segment
	dw 0,0
stack ends

code segment

start:	mov ax,stack
	mov ss,ax
	mov sp,16
	
	mov ax,data
	mov ds,ax
	
	push ds:[0]
	push ds:[2]
	pop ds:[2]
	pop ds:[0]
	
	mov ax,4c00H
	int 21H

code ends
end start

1）CPU执行程序，程序返回前，data段中的数据为多少？
2）CPU执行程序，程序返回前，cs=____、ss=____、ds=____
3）设程序加载后，code段的段地址为X，则data段的段地址为____，stack段的段地址为____
4）对于如下定义的断：
name segment
…
name ends
如果段中的数据占N个字节，则程序加载后，该段实际占有的空间为____

回答：
1）CPU执行程序，程序返回前，data段中的数据不变
2）CPU执行程序，程序返回前，cs=0B3B,ss=0B3A,ds=0b39
3）设程序加载后，code段的段地址为X，则data段的段地址为X-2，stack段的段地址为X-1
4）对于如下定义的断：
name segment
…
name ends
如果段中的数据占N个字节，则程序加载后，该段实际占有的空间为((N+15)/16)*16

N分为被16整除和不能被16整除
当N被16整除时：占有的空间为(N/16)*16
当N不能被16整除时：占有的空间为(N/16+1)*16，N/16得出的是可以整除的部分，还有一个余数，余数肯定小于16，加上一个16
程序加载后分配空间是以16个字节为单位的，也就是说如果不足16个字节的也分配16个字节。
两种情况总结成一个通用的公式：((N+15)/16)*16