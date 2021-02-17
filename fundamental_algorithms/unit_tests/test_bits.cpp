#include "gtest\gtest.h"
#include "algs\bits.h"
#include <vector>
#include <cstdint>
#include <limits>

TEST(parity_ui64ref_return_ui64, OddAndEvenExamples) {
	std::vector<std::uint64_t> even_tests {
		0,3,5,std::numeric_limits<std::uint64_t>::max()
	};

	for (int i=0; i<even_tests.size(); ++i) {
		auto curr_result = parity_ui64ref_return_ui64(even_tests[i]);
		EXPECT_EQ(curr_result,0);
	}

	std::vector<std::uint64_t> odd_tests {
		1,2,4,std::numeric_limits<std::uint64_t>::max()-1
	};

	for (int i=0; i<odd_tests.size(); ++i) {
		auto curr_result = parity_ui64ref_return_ui64(odd_tests[i]);
		EXPECT_EQ(curr_result,1);
	}
}

