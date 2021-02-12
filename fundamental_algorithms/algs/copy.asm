
.code


; dest_end = copy_bytes_lodsb_stosb_and_loop(src_beg, src_end, dest)
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



; dest_end = copy_bytes(src_beg, src_end, dest)
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



; dest_end = copy_64(src_beg, src_end, dest)
; rcx=src_begin;  rdx=src_end;  r8==dest_beg
; rax=dest_end
copy_64 proc
	; save rdi, rsi to restore later
	mov r9, rsi
	mov r10, rdi

	; prepare for copy loop
	mov rsi, rcx  ; rsi == src_beg
	mov rdi, r8  ; rdi == dest_beg

	; compute the number of iterations into rcx
	mov rcx, rdx ; rcx = src_end
	sub rcx, rsi  ; rcx -= src_beg (=> rcx == src_end-src_beg)
	shr rcx, 3
	; copy loop
	cld
	rep movsq
	mov rax,rdi
	
	; restore rsi, rdi
	mov rsi, r9
	mov rdi, r10
	
	ret
copy_64 endp


; dest_beg = copy_bytes_backwards(src_beg, src_end, dest_end)
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



end
