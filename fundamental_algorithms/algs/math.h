#pragma once
#include <cstdint>

extern "C" {
	// Returns the low bits of the result of param1*param2; there is no advantage
	// to using this function over the built in C or C++ operator *
	std::uint64_t multiply_u64(std::uint64_t,std::uint64_t);

	// For results that do _not_ overflow the low bits:  
	//     For results >= 0, result.high == 0;
	//     For results < 0, result.high == -1
	// For results that _do_ overflow ...
	struct multiply_u64_t {
		std::uint64_t low;
		std::uint64_t high;
	};
	multiply_u64_t multiply_u64_highlow(std::uint64_t,std::uint64_t);

	// For results that do _not_ overflow the low bits:  
	//     For results >= 0, result.high == 0;
	//     For results < 0, result.high == -1
	// For results that _do_ overflow ...
	struct multiply_i64_t {
		std::int64_t low;
		std::int64_t high;
	};
	multiply_u64_t multiply_i64_highlow(std::int64_t,std::int64_t);


	bool is_pow2_ui64ref_return_bool(const std::uint64_t&);

}

