;==给DD数x赋值的宏==将DD型的两个数X,Y其中Y的值赋给X
give macro x,y
	mov ax,y
	mov x,ax
	mov ax,y[2]
	mov x[2],ax
endm
;**给DD数x赋值的宏**将DD型的两个数X,Y其中Y的值赋给X

;==判断正负宏==   判断DD型x,y的正负利用fhx、fhy两个常数记录下并将
;                 他们都化为正数方便运算
judge macro x,y
local judge1,judge2,judge3,judge4;;标号注释，用于保证宏的重复调用
							;;定位的标号不错乱
	mov ax,x
	cmp ax,0
	jge judge1
	mov fhx,1;;记录x的正负
	neg x;;转换为正数
judge1:
	mov ax,x[2]
	cmp ax,0
	jge judge2
	mov fhx,1
	neg x[2]
judge2:
	mov ax,y
	cmp ax,0
	jge judge3
	mov fhy,1
	neg y
judge3:
	mov ax,y[2]
	cmp ax,0
	jge judge4
	mov fhy,1
	neg y[2]
judge4:
endm
;**判断正负宏结束**

;==根据介入y值的0，1将x结果转为正或负==
change macro x,y
local change1	
	cmp y,0
	je change1
	neg x
	neg x[2]
change1:
endm
;**根据介入y值的0，1将x结果转为正或负**

;==进位宏开始== 对小数部分除以100，将商进位，余数补回小数
carry macro x
	push cx;;免除对宏外面的cx,dx值造成干扰
	push dx
	mov ax,x[2]
	mov cx,100
	mov dx,0
	div cx
	mov x[2],dx
	add x,ax
	pop dx
	pop cx
endm
;**进位宏结束**

;==新的加法宏开始== 算法，同号相加，异号相减
newadd macro x,y
	local subsub,endnewadd,returnadd1,xbig,endadd1,endadd2,endadd3,endadda,endaddc
	judge number3,number4;;不能直接代用x,y.
	         ;;x其实既number3,y既number4。原因，下面一条注释
	mov ax,fhx
	cmp fhy,ax
	jne	subsub
;;------两个数符号相等则，直接两部分相加
	mov ax,y
	add	x,ax
	mov ax,y[2]
	add x[2],ax
	carry number3
	change number3,fhx
	jmp endnewadd
;;---如果符号相反则，大数减去小数
subsub:
	mov ax,y
	cmp x,ax
	ja	xbig
	jne  endadda
	mov ax,y[2] 
	cmp x[2],ax
	ja  xbig
endadda:
	mov ax,x
	sub y,ax
	add y[2],100
	mov ax,x[2]
	sub y[2],ax
	cmp y[2],100
	jnb  endadd1
	sub y,1
	jmp endaddc
endadd1:
	sub y[2],100
endaddc:
	give number3,number4
	change number3,fhy
	jmp endnewadd
xbig:
	mov ax,y
	sub x,ax
	add x[2],100
	mov ax,y[2]
	sub x[2],ax
	cmp x[2],100
	jnb  endadd2
	sub x,1
	jmp endadd3
endadd2:
	sub x[2],100
endadd3:
	change number3,fhx
	jmp endnewadd
endnewadd:
	mov fhx,0
	mov fhy,0
endm
;**新的加法宏结束**

;==新的减法宏==
newsub macro x,y
	mov fhx,1
	change number4,fhx
	mov fhx,0
	newadd number3,number4
endm
;**新的减法宏**

;==新的乘法宏==	算法 (a1+b1)*(a2+b2)=a1*a2+a1*b2+a2*1+b1*b2
newmul macro x,y
	judge number3,number4
	push bx
	push dx
	mov bx,y
	mov ax,x
	mul bx
	push ax;;压栈用于后面的加法
	mov ax,x[2]
	mul bx
	push ax;;正数部分乘小数部分的结果可以直接加到小数部分
	mov bx,y[2]
	mov ax,x
	mul bx
	push ax
	mov ax,x[2]
	mul bx
	mov dx,0
	mov bx,100;;小数部分乘小数部分的结果必需再缩小100倍，才
			;;能再加回小数位
	div bx
	mov x[2],ax
	pop ax
	add x[2],ax
	pop ax
	add x[2],ax
	pop ax
	mov x,ax
	carry number3
	mov ax,fhy
	xor fhx,ax
	change number3,fhx
	mov fhx,0
	mov fhy,0
	pop dx
	pop bx
endm
;**新的乘法宏**

;==新的除法宏== 利用减法完成除法运送，但是为了减少逐减次数，所以
				;先用a1/(a2+1)得要一个商，这个商一定不会大于逐减
				;次数，所以就可以从（a1+b1）-商*（a2+b2)开始逐减，
				;直到减出负数后，回加一个（a2+b2)得（a3+b3)。这时
				;候的次数，就是结果的整数部分。最后将(a3+b3)*100
				;按前面的方法,就可以得到，结果的两位小数部分。
newdiv macro x,y
local endnewdiv
	push bx
	push dx
	push cx
	judge number3,number4
	give fhdx,fhx
	mov fhx,0
	mov fhy,0
	give divn4,number4
	intdiv number3,number4;;求结果的整数部分
	mov bx,100;;将减完的剩余数扩大100倍
	mov ax,number3
	mul bx
	mov number3,ax
	mov ax,number3[2];;小数位扩大100倍，就等于直接进入整数位
	add number3,ax
	mov number3[2],0
	give number4,divn4
	intdiv number3,number4;;求结果的小数部分
	pop number3[2]
	pop number3
endnewdiv:	
	mov ax,fhdy
	xor fhdx,ax
	change number3,fhdx
	mov fhdx,0
	mov fhdy,0
	pop cx
	pop dx
	pop bx	
endm
;**新的除法宏**

;==除法的逐减宏==
intdiv macro x,y
local intdiv1,intdiv2,endintdiv;;内嵌宏，用于逐减
	mov ax,x
	mov bx,y
	add bx,1
	mov dx,0
	div bx
	push ax
	mov bx,y
	mul bx
	mov y,ax
	pop ax
	push ax
	mov bx,y[2]
	mul bx
	mov y[2],ax
	carry number4
	pop cx
	newsub number3,number4
	give number4,divn4;防止减法运算后改变的了number4的值
intdiv1:
	newsub number3,number4
	give number4,divn4
	inc cx
	cmp number3,0
	jl endintdiv
	je intdiv2
	jmp intdiv1
intdiv2:
	cmp number3[2],0
	jl endintdiv
	jmp intdiv1
endintdiv:
	newadd number3,number4
	dec cx
	push cx
endm
;**除法的逐减宏**

;==设置光标宏==
curse macro cury,curx
	mov ah,2
	mov dh,cury
	mov dl,curx
	mov bh,0
	int 10h
endm
;**设置光标宏**

;==定位字符串显示宏==
menu  macro op1,op2,op3 ;菜单显示宏定义 将op3的内容显示到op1,op2的位置      
   mov ah,02h
   mov bh,00h
   mov dh,op1
   mov dl,op2
   int 10h
   mov ah,09h
   lea dx,op3
   int 21h
endm
;**定位字符串显示宏**

;==清屏加色宏==
scroll macro n,ulr,ulc,lrr,lrc,att
	mov ah,06
	mov al,n;n=上卷行数;n=0时，整个窗口空白
	mov ch,ulr;左上角行号
	mov cl,ulc;左上角列号
	mov dh,lrr;右下角行号
	mov dl,lrc;右下角列号
	mov bh,att;卷入行属性
	int 10h
endm
;**清屏加色宏**

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;程序开始
data segment
	fhx dw 0;记录x值的正负
	fhy dw 0;记录y值的正负
	fhdx dw 0;记录除法运算中的x值正负
	fhdy dw 0;记录除法运算中的y值正负
	divn4 dd 0;除法中帮助暂存number4
	number0 db 100;计入键盘输入字符串
			db 0
			db 100 dup(0);
	number dw 200 dup(0);存入输入公式处
	number2 dw 200 dup(0);读取去括号后的公式暂存处
	number3 dd 0;存储用于计算的x数
	number4 dd 0;存储用于计算的y数
	crx  db 20;记录光标列
	cry  db 10;记录光标行
	crx2 db 2;记录光标列2
	cry2 db 2;记录光标行2
	memb dw 0;记录bx中的值是否储存过
	memx db 0;记录是否应该进入小数存储部分
	memcl db 0;记录已经存储到小数的第几位
	rsi dw 0
	begain db 'Welcome to use our calculator!','$'
	begain1 db 'data:2009/11/28','$'
	begain2 db 'made by ：Wangjue','$'
	begain3 db '          LiangJinquan','$'
	begain4 db '          ZhuGengfeng','$'
	begain5 db 'press "E" key to exit','$'
	begain6 db 'press any key to contiune','$'
	begain7 db 'Press "Enter" key to introudction','$'
	help   db 'Confine:32512.99~(-32768.00)','$'
	help1  db 'Format: 1.32*99+(98.43/(-34))= ','$'
	help2  db 'Notice 1:negative must like (-x)','$'
	help3  db '       2:only can abet double decimal fraction as 567.33','$'
	help4  db 'press any key go on!','$'
	error1 db ' Error!',13,10,'$'
	DBUFFER DB 8 DUP (':'),12 DUP (' ');时间的底
data ends
code segment
assume cs:code,ds:data,es:data
start:
	mov ax,data
	mov ds,ax
	mov ax,data
	mov es,ax
;----欢迎界面-----
	scroll 0,0,0,24,79,0;清屏
	scroll 25,0,0,24,79,50h;开外窗口，品红底
	scroll 21,2,2,22,77,0fh;开内窗口，黑底白字
	menu 4,20,begain
	menu 6,20,begain1
	menu 8,20,begain2
	menu 10,20,begain3
	menu 12,20,begain4
	menu 14,20,begain5
	menu 16,20,begain6
	menu 18,20,begain7
	mov ah,01
	int 21h
	cmp al,0dh;'Enter'
	jne helpo
	scroll 21,2,2,22,77,0fh;清屏，内窗	
	menu 6,20,help
	menu 8,20,help1
	menu 10,20,help2
	menu 12,20,help3
	menu 14,20,help4
	mov ah,01
	int 21h
	scroll 21,2,2,22,77,0fh;清屏，内窗	
	jmp start1
helpo:
	cmp al,45h;'E'
	je exit
	scroll 21,2,2,22,77,0fh;清屏，内窗	
;----清零处理-----
start1:
	call time
  start3:
	curse  10,25;光标定位中间
	mov cx,200
	mov si,0
  sclear:
	mov number[si],0
	add si,2
	loop sclear
	mov cx,0
	mov si,0
	mov bx,0
	mov crx,25
	scroll 1,10,25,10,77,0fh;清除原来等式
;---开始----
	call write
	call loopcount
	curse cry,crx
	call output
	mov ah,01
	int 21h
	scroll 1,cry2,2,cry2,77,0fh;清除原来等式
	menu cry2,crx2,number0[2]
	inc cry2
	cmp cry2,10
	jl  start2
	mov cry2,2
start2:
	jmp start1
exit:
	mov ah,4ch
	int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;程序结束
;====写入函数======
;数据格式：定义一个DD双字数组，双字的第一个字存数的整数部分，第二个字
;          存数的小数部分。但是为了最后的输出方便，以及乘法运算的小数
;          部分运算后向整数部分进位，小数部分采用100进一制

;存数范围：十进制32512.99~(-32767.00),十六进制7F00.63~8001.00(补码)

;存数算法：整数部分  正数ai=ai*10+a(i+1),负数对正数求补码
;		   小数部分  正数bi=b1*10+b2,负数对正数求补码

;存数说明：采用单个字符一个一个输入的方式,字符为0~9时进入存数算法,当输
;          入是运算符号时结束存数算法,并且开始存数及存运算符.但是这里要
;          考虑一个问题不能每次有运算符号进入时都存数,比方A+((X)),如果每
;		   次都存,A就会被存3次.所以这里我们定义了一个常数remb记录每个数存
;          入情况,方便存数时判断

;负数处理：负数的介入要求格式为(-X),因为在读取部分,会依次去括号,这样就
;          变为了-X,所以只需要判断一串公式开头位'-'号,就知道介入的为负
;          数,再直接对X求补。(注：这步处理放在支持混合运算的si_ze宏部分)

;小数处理: 通过介入'.'来判断是否开始存入小数部分

;特别说明： 1：由于运算符号的ASCLL较小,会与介入的数字相等,所以把运算符的
;              ASCLL码加上7F00H在存入,这样也就要把7F00H~7FFFH预留给运算
;              符号,同时这也会导致存数范围的缩小,不过个人觉得是值的.

;输入格式: 按照平时正常等式的输入方式输入,以等号结尾.
;          例如：11*(1-3)/(-3)=
write proc near
;--写入函数主部分----
startw:
	lea dx,number0
	mov ah,0ah
	int 21h
	xor cx,cx
	mov cl,number0[1]
	mov si,cx
	add si,2
	mov rsi,si
	mov si,0
	mov di,2
	mov bx,0
startw2:
	mov al,number0[di]
	inc di
	inc crx
	mov ah,0
	cmp al,45h;'E' 用于程序退出
	jz  exit
	cmp al,2ah;'*'
	jz  memory;转入存数及存运算符
	cmp al,2fh;'/'
	jz  memory
	cmp al,2bh;'/'
	jz  memory
	cmp al,2dh;'-'
	jz  memory
	cmp al,29h;')'
	jz  memory
	cmp al,28h;'('
	jz  memory
	cmp al,2eh;'.'
	jz  memoryx;转入存入小数程序
	cmp al,3dh;'='
	jz  memory
	cmp al,0dh;'CR'
	jz	endwrite
	sub al,30h;为存数算法做准备,让'1'真正变成二进制码的1
	cmp al,0
	jl  error;报错程序
	cmp al,9
	ja  error
	cmp memx,2
	je  error
	cmp memx,1
	je  arithmeticx;小数存数算法程序
	jmp arithmetic;整数存数算法程序
;---memory存入部分---
memory:
	cmp memb,0;remb位0时表示数已经数存储过；注：开始为remb赋值时
	          ;也一定要为0,因为这是为了防止'(1+3)*4'这样直接以运
			  ;算符开始的等式
	je  memory1
	mov number[si],bx;存入数
	cmp memx,1;
	je  memory2;存小数部分程序
	add si,4
   gomemory1:
	add ax,7f00h;将运算符转换到7F00~7FFF之间
	mov number[si],ax;存入运算符
	mov memb,0;说明数已经存储过
	mov memx,0   
	mov memcl,0
	mov bx,0
	add si,4
   loop startw2
   jmp endwrite
 memory1:;只存运算符号
	add ax,7f00h
	mov number[si],ax    
	add si,4
	loop startw2
	jmp endwrite
 memory2:
    add si,2
	jmp gomemory1
;-memoryx小数存入部分-
memoryx:
	mov memx,1;当remx为1时表示开始准备小数存入
	mov number[si],bx                        
	mov bx,0
	add si,2;没有加四,应为这下是要转入存小数的下个字节
	loop startw2
	jmp endwrite
;-arithmetic存数算法--
arithmetic:
    ;算法bx=bx*10+ax
	push ax
	mov ax,bx
	push cx
	mov cx,10
	mul cx 
	pop cx
	pop bx
	add ax,bx
	mov bx,ax
	mov memb,1;说明开始存数
	cmp bx,7f00h;保证数在合适范围内
	jae error
	loop startw2
	jmp endwrite
;-arithmeticx存数算法--
arithmeticx:
    cmp memcl,1
	je  arithmetix1
	push cx
	mov cx,10
	mul cx
	add bx,ax
	pop cx
	mov memb,1
	inc memcl
	loop startw2
	jmp endwrite
  arithmetix1:
	add bx,ax
	inc memcl
	loop startw2
	jmp endwrite
;---error报错部分----
error:
	curse cry,crx
	lea dx,error1
	mov ah,9
	int 21h
	jmp start1;重新运行程序
endwrite:
	mov di,0
	ret
write endp
;***写入函数结束***

;===去括号函数=====
;程序说明：比方'11+(3+99)='这个等式,先从number的首位开始每隔两个字取出数
;          与')'的现ASCLL码7f29h比较从而找到第一个')'的位置,再到回去找到
;		   最近的'('的位置,从而将中间没括号的等式读出到number3中,接着利
;		   用si_ze函数算出这个等式的值,并且赋值回number中,以替代原来的括
;		   号及括号能的等式
loopcount proc near
   startlp:
        mov bp,0  
        mov di,0
        mov bx,0
        mov si,0     
   startl:
        mov ax,number[si]
        cmp ax,7f29h
        je  rsee  
        add si,4
        cmp ax,7f3dh
        je  lastl
        jmp startl
   rsee:
        sub si,4
        mov ax,number[si]
        cmp ax,7f28h  
        je rwrite
        jmp rsee
    rwrite:
		push si
        ; mov lct2,si      
        mov di,0 
		add si,2
      rwrite1:
        add si,2  
        mov ax,number[si]
        mov number2[di],ax   
        cmp ax,7f29h
        je  rcount
        add di,2
        jmp rwrite1
    rcount: 
		push si
        ; mov lct1,si
        call si_ze
		pop ax
		pop di
		push ax
        ; mov di,lct2      
        mov ax,number3
        mov number[di],ax 
		mov number3,0
        mov ax,number3[2] 
        add di,2
        mov number[di],ax
		mov number3[2],0
		pop si
        ; mov si,lct1   
        add si,2
       rcount1:
            add si,2          
            add di,2
            mov ax,number[si]   
            mov number[di],ax 
            cmp ax,7f3dh
            je  startlp
            jmp rcount1
        
 lastl:
        mov si,0
    lastll:    
        mov ax,number[si]  
        mov number2[si],ax
        add si,2 
        cmp ax,7f3dh
        je  endl
        jmp lastll
        
 endl:  
     call si_ze        
        ret	
loopcount endp
;**去括号函数结束**

;==混合四则运算函数==
;说明： 通过先不处理加减，先把乘除运算进行，将算出的结果带回原来
;       的地方取代。最终得到一个只有加减的公式。来方便运算
;特别说明： 本运算还承贷着将（-1）转为ffffh存入number中,既负数输入
si_ze proc near
	mov si,4
	mov ax,number2
	cmp ax,7f2dh;'-'
	jne sstart
	give number3,number2[4]
	mov fhx,1
	change number3,fhx
	mov fhx,0
	jmp end4ze
sstart:
	mov ax,number2[si]
    cmp ax,7f2ah;'*'
    je mull;计算乘法
    cmp ax,7f2fh;'/'
    je divv        
    cmp ax,7f3dh;'='
    je sznext;去完乘除后跳转      
    cmp ax,7f29h;')'
    je sznext
	add si,4
	jmp sstart
mull:
	sub si,4
	give number3,number2[si]
	add si,8
	give number4,number2[si]
	newmul number3,number4
	sub si,8
	give number2[si],number3
	call sloop
	jmp sstart
divv:
	sub si,4
	give number3,number2[si]
	add si,8
	give number4,number2[si]
	newdiv number3,number4
	sub si,8
	give number2[si],number3
	call sloop
	jmp sstart
sznext:
	give number3,number2
	mov si,0
sznext1:
	add si,4
	mov ax,number2[si]
	cmp ax,7f2bh
	je  addd
	cmp ax,7f2dh
	je  subb
	cmp ax,7f3dh
	je end4ze
	cmp ax,7f29h
	je end4ze
	jmp sznext1
addd:
	add si,4
	give number4,number2[si]
	newadd number3,number4
	jmp sznext1
subb:
	add si,4
	give number4,number2[si]
	newsub number3,number4
	jmp sznext1
end4ze:
     RET    
si_ze endp	 

sloop proc near;用于循环赋值
	mov di,si
	add si,8
  sloop1:
	add di,4
	add si,4
	mov ax,number2[si]
	push ax
	give number2[di],number2[si]
	pop ax
	cmp ax,7f3dh;等号
	je  endsloop
	cmp ax,7f29h;括号
	je  endsloop
	jmp sloop1
endsloop:
	ret
sloop endp
;**混合四则运算结束**

;==输出函数==;通过除十取余的方法，将数从低位到高位逐一取出再加30h转为
;             ascll输出。注：先判断数的正负来考虑是否输出符号，接着输出
;             整数部分再输出一个“.”小数点最后输出小数部分
output proc near   
	mov si,rsi
	judge number3,number4
	cmp fhx,1
	jne output1
	mov number0[si],2dh
	inc si
	mov dx,2dh
	mov ah,02h
	int 21h
output1:
	mov ax,number3
	mov bx,10
	mov cx,0
	call intoutput
	mov number0[si],2eh
	inc si
	mov dx,2eh;输出小数点
	mov ah,02h
	int 21h
	mov ax,number3[2]
	mov bx,10
	mov cx,0
	call intoutput
	mov number0[si],'$'
	ret
output endp  

intoutput proc near
output2:
	mov dx,0
	div bx
	push dx
	inc cx
	cmp ax,0
	je  output3
	jmp output2
output3:
	pop ax
	add ax,30h
	mov number0[si],al
	inc si
	mov dx,ax
	mov ah,02
	int 21h
	loop output3
	ret
intoutput endp
;**输出函数**
 
CRLF PROC NEAR         ;回车、显示功能过程定义，属性为NEAR
     MOV DL,0DH         ;把回车的ASCII码0DH传给DL
     MOV AH,02H       ;送DOS 的中断调用功能号
     INT 21H            ; DOS 的中断调用
     
     MOV DL,0AH       ; 把换行的ASCII码0AH传给DL
     MOV AH,02H       ; 送DOS 的中断调用功能号
     INT 21H            ; DOS 的中断调用
     RET               ; 返回
CRLF ENDP             ;完成过程定义   

TIME   PROC NEAR        ;显示时间子程序
DISPLAY1:MOV SI,0
       MOV BX,100
       DIV BL
       MOV AH,2CH       ;取时间
       INT 21H
       MOV AL,CH
       CALL BCDASC      ;将时间数值转换成ASCII码字符
       INC SI
       MOV AL,CL
       CALL BCDASC
       INC SI
       MOV AL,DH
       CALL BCDASC
       MOV BP,OFFSET DBUFFER
       MOV DX,161dH
       MOV CX,8
       MOV BX,004EH
       MOV AX,1301H
       INT 10H
       MOV AH,02H
       MOV DX,0300H
       MOV BH,0
       INT 10H
       MOV BX,0018H
RE:    MOV CX,0FFFFH
REA:   LOOP REA
       DEC BX
       JNZ RE
       MOV AH,01H
       INT 16H
       JE  DISPLAY1
       JMP start3
       RET
TIME  ENDP

BCDASC PROC NEAR                ;时间数值转换成ASCII码字符子程序
       PUSH BX
       CBW
       MOV BL,10
       DIV BL
       ADD AL,'0'
       MOV DBUFFER[SI],AL
       INC SI
       ADD AH,'0'
       MOV DBUFFER[SI],AH
       INC SI
       POP BX
       RET
BCDASC ENDP

code ends
end start
