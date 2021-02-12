#pragma once
#include <cstdint>

extern "C" {
	char* copy_bytes_lodsb_stosb_and_loop(const char*, const char*, char*);
	char* copy_bytes(const char*, const char*, char*);

	std::uint64_t* copy_64(const std::uint64_t*, const std::uint64_t*, std::uint64_t*);

	char* copy_bytes_backwards(const char*, const char*, char*);
}
