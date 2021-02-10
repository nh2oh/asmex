.data
;no data

.code
; rcx=beg; rdx=end
reverse_bytes_return_void proc
	cmp rcx,rdx
	je exit
	dec rdx
	cmp rcx,rdx
	je exit
	
	loop_top:
		mov al,[rcx]
		mov r8b, [rdx]
		mov [rcx],r8b
		mov [rdx],al
		inc rcx
		cmp rcx,rdx
		je exit
		dec rdx
		cmp rcx,rdx
	jne loop_top
	
	exit:
	ret
reverse_bytes_return_void endp


; rcx=beg; rdx=end
reverse_ui64_return_void proc
	cmp rcx,rdx
	je exit
	sub rdx,8
	cmp rcx,rdx
	je exit
	
	loop_top:
		mov rax,[rcx]
		mov r8, [rdx]
		mov [rcx],r8
		mov [rdx],rax
		add rcx,8
		cmp rcx,rdx
		je exit
		sub rdx,8
		cmp rcx,rdx
	jne loop_top
	
	exit:
	ret
reverse_ui64_return_void endp


end
