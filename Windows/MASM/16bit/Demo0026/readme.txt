����˵����
������ĳ���������ӣ���Debug���ء����٣�Ȼ��ش�����
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

1��CPUִ�г��򣬳��򷵻�ǰ��data���е�����Ϊ���٣�
2��CPUִ�г��򣬳��򷵻�ǰ��cs=____��ss=____��ds=____
3���������غ�code�εĶε�ַΪX����data�εĶε�ַΪ____��stack�εĶε�ַΪ____

�ش�
1��CPUִ�г��򣬳��򷵻�ǰ��data���е�����Ϊ��
0123H,0456H,0789H,0abcH,0defH,0fedH,0cbaH,0987H
�����䣩
2��CPUִ�г��򣬳��򷵻�ǰ��cs=0B3B��ss=0B3A��ds=0B39
3���������غ�code�εĶε�ַΪX,��data�εĶε�ַΪX-2��stack�εĶε�ַΪx-1