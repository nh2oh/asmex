.data
;no data

.code

; void swap_n(void*, void*, std::uint64_t)
swap_n proc
	cmp r8,0
	jz exit

	next_byte_pair:
		mov al,[rcx]
		mov r9b,[rdx]
		mov [rcx],r9b
		mov [rdx],al
		inc rcx
		inc rdx
		dec r8
	jnz next_byte_pair

	exit:
	ret
swap_n endp

end
