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
char2binascii proto
char2hexascii proto

; constants
const_stdout equ -11

.data
p_msg byte "Here is a message."
p_spaces byte "    "
p_binascii_dest byte 8 dup (?)
p_hexascii_dest byte 2 dup (?)
p_newln byte 0DH,0AH  ; \r\n
h_stdout qword ?
n_chars_written qword ?


.code

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
		sub rsp, 40
		call WriteConsoleA
		add rsp, 40
		; Write 4 spaces
		mov rcx, h_stdout
		lea rdx, p_spaces
		mov r8, lengthof p_spaces
		lea r9, n_chars_written
		sub rsp, 40
		call WriteConsoleA
		add rsp, 40

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
		sub rsp, 40
		call WriteConsoleA
		add rsp, 40
		
		; Write 4 spaces
		mov rcx, h_stdout
		lea rdx, p_spaces
		mov r8, lengthof p_spaces
		lea r9, n_chars_written
		sub rsp, 40
		call WriteConsoleA
		add rsp, 40
		
		; Fill the hexascii buffer with the hexascii for the present byte
		mov rcx, [r12]  ; syntax ???? [] dereferences???
		lea rdx, p_hexascii_dest
		sub rsp, 40
		call char2hexascii
		add rsp, 40
		
		; Write the hexascii buffer
		mov rcx, h_stdout
		lea rdx, p_hexascii_dest
		mov r8, lengthof p_hexascii_dest
		lea r9, n_chars_written
		sub rsp, 40
		call WriteConsoleA
		add rsp, 40		
		
		; Write a line break
		mov rcx, h_stdout
		lea rdx, p_newln
		mov r8, lengthof p_newln
		lea r9, n_chars_written
		sub rsp, 40
		call WriteConsoleA
		add rsp, 40
		
		inc r12
		cmp r12, r13
	jne write_byte

main endp


; nv:  r12-r15

end



