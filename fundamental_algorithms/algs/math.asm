

.code

; std::uint64_t multiply_u64(std::uint64_t,std::uint64_t);
multiply_u64 proc
	mov rax,rdx
	mul rcx
	ret
multiply_u64 endp


; multiply_u64_t multiply_u64_highlow(std::uint64_t a,std::uint64_t b);
; rcx == ptr to destination struct
; rdx == paramater a, r8 == parameter b
; return ptr to struct in rax
multiply_u64_highlow proc
	mov rax,rdx
	mul r8  ; low bits in rax, high bits in rdx
	mov [rcx],rax
	mov [rcx+8],rdx
	mov rax,rcx
	ret
multiply_u64_highlow endp

end
