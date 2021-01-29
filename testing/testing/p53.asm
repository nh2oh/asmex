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
p_input_bffr byte 20 dup (?)
h_console qword ?
h_keyboard qword ?
n_bytes_written qword ?
n_bytes_read qword ?  ; initialize w/ a dummy value > 2

.code
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
	mov rcx, h_console
	lea rdx, p_msg_prompt
	mov r8, lengthof p_msg_prompt
	lea r9, n_bytes_written
	sub rsp, 40
	call WriteConsoleA
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
	mov rcx, h_console
	lea rdx, p_input_bffr
	mov r8, n_bytes_read
	lea r9, n_bytes_written
	sub rsp, 40
	call WriteConsoleA
	add rsp, 40

	mov r8, n_bytes_read
	cmp r8, 2
	jg get_msg
	
	mov rcx, 0
	call ExitProcess
main endp

end

