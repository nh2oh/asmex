

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

; multiply_i64_t multiply_i64_highlow(std::int64_t a,std::int64_t b);
; rcx == ptr to destination struct
; rdx == paramater a, r8 == parameter b
; return ptr to struct in rax
multiply_i64_highlow proc
	mov rax,rdx
	imul r8  ; low bits in rax, high bits in rdx
	mov [rcx],rax
	mov [rcx+8],rdx
	mov rax,rcx
	ret
multiply_i64_highlow endp



; bool is_pow2_ui64ref_return_bool(const std::uint64_t&);
is_pow2_ui64ref_return_bool proc
	xor rdx,rdx
	popcnt rax,[rcx]
	cmp rax,1
	cmovne rax,rdx
	ret
is_pow2_ui64ref_return_bool endp

end
