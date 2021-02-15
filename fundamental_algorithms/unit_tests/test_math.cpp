#include "gtest\gtest.h"
#include "algs\math.h"
#include <vector>
#include <cstdint>
#include <limits>

TEST(multiply_u64, NonOverflowingParameters) {
	struct multiply_tests_t {
		std::uint64_t a;
		std::uint64_t b;
	};
	std::vector<multiply_tests_t> tests {
		{std::numeric_limits<std::uint64_t>::max(),0},
		{std::numeric_limits<std::uint64_t>::max(),0},
		{0,0},
		{1,1},
		{1,2},
		{2,1},
		{2,2},
		{2,3},
		{3,2},
		{3,3},
		// The largest power of 2 is max()-1; hence multiplying half of that by
		// 2 should not overflow
		{(std::numeric_limits<std::uint64_t>::max()-1)/2,2},
		{2,(std::numeric_limits<std::uint64_t>::max()-1)/2},
	};

	for (int i=0; i<tests.size(); ++i) {
		auto curr_ans = (tests[i].a)*(tests[i].b);
		auto curr_result = multiply_u64(tests[i].a,tests[i].b);
		EXPECT_EQ(curr_ans,curr_result);
	}
}

TEST(multiply_u64, OverflowingParameters) {
	struct multiply_tests_t {
		std::uint64_t a;
		std::uint64_t b;
	};
	std::vector<multiply_tests_t> tests {
		// The smallest that should overflow:  expect exactly 1 bit of overflow
		{(std::numeric_limits<std::uint64_t>::max()/2)+1,2},
		{2,(std::numeric_limits<std::uint64_t>::max()/2)+1}
	};

	for (int i=0; i<tests.size(); ++i) {
		auto curr_ans = (tests[i].a)*(tests[i].b);
		auto curr_result = multiply_u64(tests[i].a,tests[i].b);
		EXPECT_EQ(curr_ans,curr_result);
	}
}

TEST(multiply_u64_highlow, NonOverflowingParameters) {
	struct multiply_tests_t {
		std::uint64_t a;
		std::uint64_t b;
	};
	std::vector<multiply_tests_t> tests {
		{std::numeric_limits<std::uint64_t>::max(),0},
		{std::numeric_limits<std::uint64_t>::max(),0},
		{0,0},
		{1,1},
		{1,2},
		{2,1},
		{2,2},
		{2,3},
		{3,2},
		{3,3},
		// The largest power of 2 is max()-1; hence multiplying half of that by
		// 2 should not overflow
		{(std::numeric_limits<std::uint64_t>::max()-1)/2,2},
		{2,(std::numeric_limits<std::uint64_t>::max()-1)/2},
	};

	for (int i=0; i<tests.size(); ++i) {
		multiply_u64_t curr_ans;
		curr_ans.low = (tests[i].a)*(tests[i].b);
		curr_ans.high = 0;
		auto curr_result = multiply_u64_highlow(tests[i].a,tests[i].b);
		EXPECT_EQ(curr_ans.low,curr_result.low);
		EXPECT_EQ(curr_ans.high,curr_result.high);
	}
}

TEST(multiply_u64_highlow, OverflowingParameters) {
	struct multiply_tests_t {
		std::uint64_t a;
		std::uint64_t b;
	};
	std::vector<multiply_tests_t> tests {
		{std::numeric_limits<std::uint64_t>::max(),2},
		{std::numeric_limits<std::uint64_t>::max(),2}
	};

	for (int i=0; i<tests.size(); ++i) {
		multiply_u64_t curr_ans;
		curr_ans.low = (tests[i].a)*(tests[i].b);
		curr_ans.high = 1;
		auto curr_result = multiply_u64_highlow(tests[i].a,tests[i].b);
		EXPECT_EQ(curr_ans.low,curr_result.low);
		EXPECT_EQ(curr_ans.high,curr_result.high);
	}
}



