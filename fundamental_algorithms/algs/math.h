#pragma once
#include <cstdint>

extern "C" {
	// Returns the low bits of the result of param1*param2; there is no advantage
	// to using this function over the built in C or C++ operator *
	std::uint64_t multiply_u64(std::uint64_t,std::uint64_t);

	struct multiply_u64_t {
		std::uint64_t low;
		std::uint64_t high;
	};
	multiply_u64_t multiply_u64_highlow(std::uint64_t,std::uint64_t);
}

