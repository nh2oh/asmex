includelib kernel32.lib
;BOOL WINAPI WriteConsole(
;  _In_             HANDLE  hConsoleOutput,
;  _In_       const VOID    *lpBuffer,
;  _In_             DWORD   nNumberOfCharsToWrite,
;  _Out_opt_        LPDWORD lpNumberOfCharsWritten,
;  _Reserved_       LPVOID  lpReserved
;);
WriteConsoleA proto
GetStdHandle proto
;char2binascii proto

; constants
const_stdout equ -11

.data
p_msg byte "Here is a message."
p_spaces byte "    "
p_binascii_dest byte 8 dup (?)
p_newln byte 0DH,0AH  ; \r\n
h_stdout qword ?
n_chars_written qword ?


.code

; rcx:  the value to print (will be truncated to a max of 8 bits)
; rdx:  ptr to the first byte of the destination array
; returns:  ptr to one byte past the last written in the dest array
; (will always be 8 bytes away from the starting ptr passed in rcx)
char2binascii proc
	push rdi  ; NB not using the shadow space (or, say, r9)
	mov rdi, rdx
	mov r8, rcx  ; r8 hold a copy of the value to be written out
	cld ; clear direction bit => str instructions will autoincrement rdi
	mov cl, 7  ; shift distance
	write_bit:
		mov rax, r8 ;rcx
		shr al, cl
		and al, 1
		add al, '0'
		stosb
		dec cl
	JGE write_bit
	mov rax, rdi
	pop rdi
	ret
char2binascii endp



main proc
	mov rcx, const_stdout
	sub rsp, 40
	call GetStdHandle
	add rsp, 40
	mov h_stdout, rax
	
	
	lea r12, p_msg
	lea r13, p_msg
	add r13, lengthof p_msg

	; Write the present byte of the message
	write_byte:
		mov rcx, h_stdout
		mov rdx, r12  ; present byte of the message
		mov r8, 1
		lea r9, n_chars_written
		add rsp, 40
		call WriteConsoleA
		sub rsp, 40
		; Write 4 spaces
		mov rcx, h_stdout
		lea rdx, p_spaces
		mov r8, lengthof p_spaces
		lea r9, n_chars_written
		add rsp, 40
		call WriteConsoleA
		sub rsp, 40

		; Fill the binascii buffer with the binascii for the present byte
		mov rcx, [r12]  ; syntax ???? [] dereferences???
		lea rdx, p_binascii_dest
		sub rsp, 40
		call char2binascii
		add rsp, 40
		
		; Write the binascii buffer
		mov rcx, h_stdout
		lea rdx, p_binascii_dest
		mov r8, lengthof p_binascii_dest
		lea r9, n_chars_written
		add rsp, 40
		call WriteConsoleA
		sub rsp, 40
		
		; Write a line break
		mov rcx, h_stdout
		lea rdx, p_newln
		mov r8, lengthof p_newln
		lea r9, n_chars_written
		add rsp, 40
		call WriteConsoleA
		sub rsp, 40
		
		inc r12
		cmp r12, r13
	jne write_byte

main endp

; nv:  r12-r15

end



