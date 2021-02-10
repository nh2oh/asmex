includelib kernel32.lib
; prototypes
;BOOL WINAPI ReadConsole(
;  _In_     HANDLE  hConsoleInput,
;  _Out_    LPVOID  lpBuffer,
;  _In_     DWORD   nNumberOfCharsToRead,
;  _Out_    LPDWORD lpNumberOfCharsRead,
;  _In_opt_ LPVOID  pInputControl
;);
ReadConsoleA proto
WriteConsoleA proto
GetStdHandle proto
ExitProcess proto

; constants
console equ -11
keyboard equ -10

.data
p_msg_prompt byte "Please enter your message:  "
p_newln byte 0DH,0AH  ; \r\n
p_input_bffr byte 20 dup (?)
h_console qword ?
h_keyboard qword ?
n_bytes_written qword ?
n_bytes_read qword ?  ; initialize w/ a dummy value > 2


.code

; Sets the global n_bytes_written
; Depends on the global h_console being a valid handle
; To call:  lea rdx, ptr_message;  mov r8, lengthof message
print_ascii proc
	mov rcx, h_console
	lea r9, n_bytes_written
	sub rsp, 40
	call WriteConsoleA
	add rsp, 40
	ret
print_ascii endp


main proc
	; Get handles to console and keyboard
	mov rcx, console
	sub rsp, 40
	call GetStdHandle
	add rsp, 40
	mov h_console, rax

	mov rcx, keyboard
	sub rsp, 40
	call GetStdHandle
	add rsp, 40
	mov h_keyboard, rax
	
	; Display message prompt
	lea rdx, p_msg_prompt
	mov r8, lengthof p_msg_prompt
	sub rsp, 40
	call print_ascii
	add rsp, 40

	; Read message
	get_msg:
		mov rcx, h_keyboard
		lea rdx, p_input_bffr
		mov r8, lengthof p_input_bffr
		lea r9, n_bytes_read
		sub rsp, 40
		call ReadConsoleA
		add rsp, 40

		; Print message
		lea r12, p_input_bffr
		mov r13, n_bytes_read
		print_line:
			mov rdx, r12
			mov r8, 1;
			sub rsp, 40
			call print_ascii
			add rsp, 40
			
			lea rdx, p_newln
			mov r8, lengthof p_newln;
			sub rsp, 40
			call print_ascii
			add rsp, 40
			
			inc r12  ; p_input_bffr
			dec r13  ; n_bytes_read
		JNZ print_line ;  note that no cmp is needed; dec sets the rflag(s)
		
		mov r8, n_bytes_read
		cmp r8, 2
	jg get_msg
	
	mov rcx, 0
	call ExitProcess
main endp




end

