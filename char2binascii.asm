; Similar to what is on p.89

.data
p_hex_digs byte "0123456789ABCDEF"

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


; rcx:  the value to print (will be truncated to a max of 8 bits)
; rdx:  ptr to the first byte of the destination array
; returns:  ptr to one byte past the last written in the dest array
; (will always be 2 bytes away from the starting ptr passed in rcx)
char2hexascii proc
	push rbx  ; once again not using the shadow space
	lea rbx, p_hex_digs
	
	mov rax, rcx
	shr al, 4
	xlat
	mov [rdx], al
	inc rdx
	
	mov rax, rcx
	and al, 1111b
	xlat
	mov [rdx], al
	inc rdx
	
	mov rax, rdx
	pop rbx
	ret
char2hexascii endp






end
