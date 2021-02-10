#include "gtest\gtest.h"
#include <vector>


TEST(std_vector_tests, TestCtor) {
	std::vector<int> v {0,1,2,3,4,5};
	for (int i=0; i<v.size(); ++i) {
		EXPECT_TRUE(v[i]==i);
	}
}

