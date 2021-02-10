.data
;no data

.code

; dest_end = copy(src_beg, src_end, dest)
; rcx=src_begin;  rdx=src_end;  r8==dest_beg
; rax=dest_end
copy_bytes_lodsb_stosb_and_loop proc
	sub rdx,rcx  ;rdx == n, the number of chars to copy
	mov rsi,rcx  ;rsi==src_beg
	mov rdi,r8  ;rdi==dest_beg
	mov rcx,rdx  ;rcx == n
	; rcx, rdx contain the number of chars to copy
	cmp rcx,0  ;if src_beg==src_end, don't copy anything
	jz exit
	cld
	next_byte:
		lodsb  ;loads from rsi into rax (al) and increments rsi
		stosb  ;stores from rax (al) into rdi and increments rdi
	loop next_byte
	
	exit:
	add r8,rdx
	mov rax, r8
	ret
copy_bytes_lodsb_stosb_and_loop endp



; dest_end = copy(src_beg, src_end, dest)
; rcx=src_begin;  rdx=src_end;  r8==dest_beg
; rax=dest_end
copy_bytes proc
	cmp rcx,rdx
	je exit
	
	next_byte:
		mov ax,[rcx]
		mov [r8],ax
		inc r8
		inc rcx
		cmp rcx,rdx
	jne next_byte
	
	;r8 points one past the last byte copied into dest
	exit:
	mov rax,r8
	ret
copy_bytes endp


; dest_beg = copy(src_beg, src_end, dest_end)
; rcx=src_begin;  rdx=src_end;  r8==dest_end
; rax=dest_beg
; copies [src_beg,sec_end) into [dest_beg,dest_end), returns a ptr to dest_beg
copy_bytes_backwards proc
	cmp rcx,rdx
	je exit
	
	next_byte:
		dec rdx
		mov ax,[rdx]
		dec r8
		mov [r8],ax
		cmp rcx,rdx
	jne next_byte
	
	;r8 points directly at the last byte copied into dest
	exit:
	mov rax,r8
	ret
copy_bytes_backwards endp



; rcx=beg; rdx=end
; TODO:  BUGGY - pointers may cross in loop
reverse_bytes_return_void proc
	cmp rcx,rdx
	je exit
	dec rdx
	cmp rcx,rdx
	je exit
	
	loop_top:
		mov rax,[rcx]
		mov r8, [rdx]
		mov [rcx],r8
		mov [rdx],rax
		inc rcx
		dec rdx
		cmp rcx,rdx
	jne loop_top
	
	exit:
	ret
reverse_bytes_return_void endp


end
