#pragma once
#include <cstdint>

extern "C" {
	void reverse_bytes_return_void(char*,char*);
	void reverse_ui64_return_void(std::uint64_t*,std::uint64_t*);
}

