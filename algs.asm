

.data
;no data



.code



; dest_end = copy(src_beg, src_end, dest)
; rcx=src_begin;  rdx=src_end;  r8==dest_beg
; rax=dest_end
; TODO:  If src_beg==src_end rcx will contain 0 at the start of next_byte
; and the loop will iterate 2^64 times
copy proc
	sub rdx,rcx  ;rdx == n, the number of chars to copy
	mov rsi,rcx  ;rsi==src_beg
	mov rdi,r8  ;rdi==dest_beg
	mov rcx,rdx  ;rcx == n
	mov r9, rcx  ;needed after the loop to compute dest_end
	cld
	next_byte:
	lodsb  ;loads from rsi into rax (al) and increments rsi
	stosb  ;stores from rax (al) into rdi and increments rdi
	loop next_byte
	
	add r8,r9
	mov rax r8
	ret
copy endp



end








