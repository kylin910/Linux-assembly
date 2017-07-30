程序说明：
将下面的程序编译连接，用Debug加载、跟踪，然后回答问题
assume cs:code,ds:data,ss:stack

data segment
	dw 0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H
data ends

stack segment
	dw 0,0,0,0,0,0,0,0
stack ends

code segment

start:	mov ax,stack
	mov ss,ax
	mov sp,0016H
	
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

回答：
1）CPU执行程序，程序返回前，data段中的数据为：
0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H
（不变）
2）CPU执行程序，程序返回前，cs=0B3B、ss=0B3A，ds=0B39
3）设程序加载后，code段的段地址为X,则data段的段地址为X-2，stack段的段地址为x-1