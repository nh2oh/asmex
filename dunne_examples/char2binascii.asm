

.data
p_hex_digs byte "0123456789ABCDEF"
p_ch2decascii_bffr byte 3 dup (?)  ; internal buffer used by char2decascii

.code

; rcx:  the value to print (will be truncated to a max of 8 bits)
; rdx:  ptr to the first byte of the destination array
; returns:  ptr to one byte past the last written in the dest array
; (will always be 8 bytes away from the starting ptr passed in rdx)
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
	jge write_bit
	mov rax, rdi
	pop rdi
	ret
char2binascii endp


; rcx:  the value to print (will be truncated to a max of 8 bits)
; rdx:  ptr to the first byte of the destination array
; returns:  ptr to one byte past the last written in the dest array
; (will always be 2 bytes away from the starting ptr passed in rdx)
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


; rcx:  the value to print (will be truncated to a max of 8 bits)
; rdx:  ptr to the first byte of the destination array
; returns:  ptr to one byte past the last written in the dest array
; (will always be <= 3 bytes away from the starting ptr passed in rdx)
char2decascii proc
	mov rax, rcx
	mov r9, 10
	mov r8, rdx ; the destination array
	;lea rdx, p_ch2decascii_bffr + lengthof p_ch2decascii_bffr
	;lea r8, p_ch2decascii_bffr + lengthof p_ch2decascii_bffr
	write_number:
		inc rdx
		mov ah,0
		div r9b  ; quot in al, rem in ah
		add ah, '0'
		mov [rdx], ah
		and al, al
	jnz write_number
	
	mov rax, rdx
	ret
char2decascii endp



end
