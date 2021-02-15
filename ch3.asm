includelib kernel32.lib
WriteConsoleA proto
GetStdHandle proto
ExitProcess proto

.data
sum dword 10000h
message byte "This is a sentence that",0Dh,0Ah,"Contains",0Dh,0Ah,"Multiple line breaks.  "
input byte ?
num_bytes_written byte ?

.code

main proc
	; Q 3.1, p.56
	mov rcx,-11
	sub rsp,40
	call GetStdHandle
	add rsp,40
	mov r12,rax  ;r12==stdout

	mov rcx,r12
	lea rdx,message
	mov r8,lengthof message
	lea r9,num_bytes_written
	sub rsp,40
	call WriteConsoleA
	add rsp,40
	
	call ExitProcess
main endp


end
