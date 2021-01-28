includelib kernel32.lib
ExitProcess proto

.code
main proc
mov rcx,rsp
call ExitProcess
main endp

end
