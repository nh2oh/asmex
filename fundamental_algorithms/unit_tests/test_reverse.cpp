#include "gtest\gtest.h"
#include "algs\reverse.h"
#include <vector>


TEST(reverse_bytes_return_void, EmptyRange) {
	std::vector<char> v_init {'a','b','c','d','e'};
	auto v = v_init;
	auto pbeg = v.data()+1;
	auto pend = pbeg;
	reverse_bytes_return_void(pbeg,pend);
	for (int i=0; i<v.size(); ++i) {
		EXPECT_TRUE(v_init[i]==v[i]);
	}
}

TEST(reverse_bytes_return_void, VectorCharabcde) {
	std::vector<char> v {'a','b','c','d','e'};
	std::vector<char> v_final {'e','d','c','b','a'};
	auto pbeg = v.data();
	auto pend = pbeg+v.size();
	reverse_bytes_return_void(pbeg,pend);
	for (int i=0; i<v.size(); ++i) {
		EXPECT_TRUE(v[i]==v_final[i]);
	}
}



