

.code

; std::uint64_t parity_ui64ref_return_ui64(const std::uint64_t&);
;
parity_ui64ref_return_ui64 proc
	popcnt rax,[rcx]
	and rax,1
	ret
parity_ui64ref_return_ui64 endp

end
