; p.26
includelib kernel32.lib
ExitProcess proto

.code
main proc
mov rcx, 78
call ExitProcess
main endp

end



