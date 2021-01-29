; Similar to what is on p.89


.code

; rcx:  the value to print (will be truncated to a max of 8 bits)
; rdx:  ptr to the first byte of the destination array
; returns:  ptr to one byte past the last written in the dest array
; (will always be 8 bytes away from the starting ptr passed in rcx)
char2binascii proc
	push rdi  ; NB not using the shadow space (or, say, r9)
	mov rdi, rdx
	mov r8, rcx  ; r8 hold a copy of the value to be written out
	cld ; clear direction bit => str instructions will autoincrement rdi
	mov cl, 7  ; shift distance
	write_bit:
		mov rax, r8 ;rcx
		shr al, cl
		and al, 1
		add al, '0'
		stosb
		dec cl
	JGE write_bit
	mov rax, rdi
	pop rdi
	ret
char2binascii endp









end
