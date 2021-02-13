#include "gtest\gtest.h"
#include "algs\swap.h"
#include <cstdint>


TEST(swap_n, chars) {
	char a = 'a';
	char b = 'b';

	swap_n(&a,&b,1);
	EXPECT_EQ(a,'b');
	EXPECT_EQ(b,'a');
}

TEST(swap_n, int64) {
	std::int64_t a = -1234567;
	std::int64_t b = 9876543;

	swap_n(&a,&b,sizeof(std::int64_t));
	EXPECT_EQ(a,9876543);
	EXPECT_EQ(b,-1234567);
}

TEST(swap_n, doubles) {
	double a = -1234567.38189742;
	double b = 9876543.02021021;

	swap_n(&a,&b,sizeof(double));
	EXPECT_EQ(a,9876543.02021021);
	EXPECT_EQ(b,-1234567.38189742);
}


TEST(swap_n, WeirdStruct) {
	struct weird_struct {
		double a;
		char b;
		std::int64_t c;
		bool d;
		double e;
	};

	weird_struct a_init {-1234567.38189742,'a',9876543,false,9876543.02021021};
	weird_struct b_init {9876543.02021021,'b',-1234567,true,-1234567.38189742};
	auto a = a_init;
	auto b = b_init;

	swap_n(&a,&b,sizeof(weird_struct));

	EXPECT_EQ(a.a,b_init.a);
	EXPECT_EQ(a.b,b_init.b);
	EXPECT_EQ(a.c,b_init.c);
	EXPECT_EQ(a.d,b_init.d);
	EXPECT_EQ(a.e,b_init.e);

	EXPECT_EQ(b.a,a_init.a);
	EXPECT_EQ(b.b,a_init.b);
	EXPECT_EQ(b.c,a_init.c);
	EXPECT_EQ(b.d,a_init.d);
	EXPECT_EQ(b.e,a_init.e);
}

