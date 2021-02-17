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
		multiply_u64_t ans;
	};
	std::vector<multiply_tests_t> tests {
		{std::numeric_limits<std::uint64_t>::max(),2,
			{std::numeric_limits<std::uint64_t>::max()<<1,1}},
		{std::numeric_limits<std::uint64_t>::max(),4,
			{std::numeric_limits<std::uint64_t>::max()<<2,3}},
		{std::numeric_limits<std::uint64_t>::max(),8,
			{std::numeric_limits<std::uint64_t>::max()<<3,7}},
		{std::numeric_limits<std::uint64_t>::max(),16,
			{std::numeric_limits<std::uint64_t>::max()<<4,15}},
		{std::numeric_limits<std::uint64_t>::max(),32,
			{std::numeric_limits<std::uint64_t>::max()<<5,31}},
		{std::numeric_limits<std::uint64_t>::max(),64,
			{std::numeric_limits<std::uint64_t>::max()<<6,63}},
		{std::numeric_limits<std::uint64_t>::max(),128,
			{std::numeric_limits<std::uint64_t>::max()<<7,127}},
		{std::numeric_limits<std::uint64_t>::max(),256,
			{std::numeric_limits<std::uint64_t>::max()<<8,255}},
		{std::numeric_limits<std::uint64_t>::max(),512,
			{std::numeric_limits<std::uint64_t>::max()<<9,511}},
		{std::numeric_limits<std::uint64_t>::max(),1024,
			{std::numeric_limits<std::uint64_t>::max()<<10,1023}},
		{std::numeric_limits<std::uint64_t>::max(),2048,
			{std::numeric_limits<std::uint64_t>::max()<<11,2047}}
	};

	for (int i=0; i<tests.size(); ++i) {
		auto curr_result = multiply_u64_highlow(tests[i].a,tests[i].b);
		EXPECT_EQ(tests[i].ans.low,curr_result.low);
		EXPECT_EQ(tests[i].ans.high,curr_result.high);
	}
}

TEST(is_pow2_ui64ref_return_bool, TrueAndFalseValues) {
	std::vector<std::uint64_t> not_pow_2s {
		0,3,5,6,7,9,10,11,12,13,14,15,
		std::numeric_limits<std::uint64_t>::max()
	};
	for (int i=0; i<not_pow_2s.size(); ++i) {
		auto curr_result = is_pow2_ui64ref_return_bool(not_pow_2s[i]);
		EXPECT_FALSE(curr_result);
	}

	std::vector<std::uint64_t> pow_2s {
		1,2,4,8,16,32,64,128,256,512,1024,2048,4096
	};
	for (int i=0; i<pow_2s.size(); ++i) {
		auto curr_result = is_pow2_ui64ref_return_bool(pow_2s[i]);
		EXPECT_TRUE(curr_result) << pow_2s[i];
	}
}

