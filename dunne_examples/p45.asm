includelib kernel32.lib
; prototypes
;HANDLE WINAPI GetStdHandle(
;  _In_ DWORD nStdHandle
;);
GetStdHandle proto
;BOOL WINAPI WriteConsole(
;  _In_             HANDLE  hConsoleOutput,
;  _In_       const VOID    *lpBuffer,
;  _In_             DWORD   nNumberOfCharsToWrite,
;  _Out_opt_        LPDWORD lpNumberOfCharsWritten,
;  _Reserved_       LPVOID  lpReserved
;);
WriteConsoleA proto
ExitProcess proto
;constants
console equ -11

.data
msg byte "Hello World"
n_written qword ?
h_stdout qword ?


.code
main proc
	mov rcx, console
	sub rsp, 40
	call GetStdHandle
	add rsp, 40
	mov h_stdout, rax

	mov rcx, h_stdout
	lea rdx, msg
	mov r8, lengthof msg
	lea r9, n_written
	sub rsp, 40
	call WriteConsoleA
	add rsp, 40

	mov rcx, 0
	call ExitProcess
main endp

end


