#include "gtest\gtest.h"
#include "algs\copy.h"
#include <vector>
#include <cstdint>


TEST(copy_bytes, VectorChar) {
	std::vector<char> v_src {'a','b','c','d','e'};
	std::vector<char> v_dest(v_src.size(),'x');
	auto p_src_beg = v_src.data();
	auto p_src_end = p_src_beg + v_src.size();
	auto p_dest_beg = v_dest.data();
	auto p_dest_end = p_dest_beg + v_dest.size();

	auto return_value = copy_bytes(p_src_beg,p_src_end,p_dest_beg);

	EXPECT_EQ(return_value,p_dest_end);
	for (int i=0; i<v_src.size(); ++i) {
		EXPECT_EQ(v_src[i],v_dest[i]);
	}
}
TEST(copy_bytes, VectorCharPartialCopy) {
	int num_to_copy = 2;
	std::vector<char> v_src {'a','b','c','d','e'};
	std::vector<char> v_dest(v_src.size(),'x');
	auto p_src_beg = v_src.data();
	auto p_src_end = p_src_beg + num_to_copy;
	auto p_dest_beg = v_dest.data();
	auto p_dest_end = p_dest_beg + num_to_copy;

	auto return_value = copy_bytes(p_src_beg,p_src_end,p_dest_beg);

	EXPECT_EQ(return_value,p_dest_end);
	for (int i=0; i<num_to_copy; ++i) {
		EXPECT_EQ(v_src[i],v_dest[i]);
	}
	for (int i=num_to_copy; i<v_src.size(); ++i) {
		EXPECT_EQ(v_dest[i],'x');
	}
}

TEST(copy_bytes, VectorInt32) {
	std::vector<std::int32_t> v_src {'a','b','c','d','e'};
	std::vector<std::int32_t> v_dest(v_src.size(),'x');
	auto p_src_beg = reinterpret_cast<char*>(v_src.data());
	auto p_src_end = p_src_beg + v_src.size()*sizeof(std::int32_t);
	auto p_dest_beg = reinterpret_cast<char*>(v_dest.data());
	auto p_dest_end = p_dest_beg+v_dest.size()*sizeof(std::int32_t);

	auto return_value = copy_bytes(p_src_beg,p_src_end,p_dest_beg);

	EXPECT_EQ(return_value,p_dest_end);
	for (int i=0; i<v_src.size(); ++i) {
		EXPECT_EQ(v_src[i],v_dest[i]);
	}
}

TEST(copy_64, VectorInt64) {
	std::vector<std::uint64_t> v_src {0,1,2,3,4,5};
	std::vector<std::uint64_t> v_dest(v_src.size(),7);
	auto p_src_beg = v_src.data();
	auto p_src_end = p_src_beg + v_src.size();
	auto p_dest_beg = v_dest.data();
	auto p_dest_end = p_dest_beg+v_dest.size();

	auto return_value = copy_64(p_src_beg,p_src_end,p_dest_beg);

	EXPECT_EQ(return_value,p_dest_end);
	for (int i=0; i<v_src.size(); ++i) {
		EXPECT_EQ(v_src[i],v_dest[i]);
	}
}
TEST(copy_64, VectorCharSizeIsMultipleOf8) {
	std::vector<char> v_src {'a','b','c','d','e','f','g','h'};
	std::vector<char> v_dest(v_src.size(),'x');
	auto p_src_beg = v_src.data();
	auto p_src_end = p_src_beg + v_src.size();
	auto p_dest_beg = v_dest.data();
	auto p_dest_end = p_dest_beg+v_dest.size();

	auto return_value = copy_64(reinterpret_cast<std::uint64_t*>(p_src_beg),
		reinterpret_cast<std::uint64_t*>(p_src_end),reinterpret_cast<std::uint64_t*>(p_dest_beg));

	EXPECT_EQ(return_value,reinterpret_cast<std::uint64_t*>(p_dest_end));
	for (int i=0; i<v_src.size(); ++i) {
		EXPECT_EQ(v_src[i],v_dest[i]);
	}
}

TEST(copy_bytes_lodsb_stosb_and_loop, VectorChar) {
	std::vector<char> v_src {'a','b','c','d','e'};
	std::vector<char> v_dest(v_src.size(),'x');
	auto p_src_beg = v_src.data();
	auto p_src_end = p_src_beg + v_src.size();
	auto p_dest_beg = v_dest.data();
	auto p_dest_end = p_dest_beg + v_dest.size();

	auto return_value = copy_bytes_lodsb_stosb_and_loop(p_src_beg,p_src_end,p_dest_beg);

	EXPECT_EQ(return_value,p_dest_end);
	for (int i=0; i<v_src.size(); ++i) {
		EXPECT_EQ(v_src[i],v_dest[i]);
	}
}

TEST(copy_bytes_lodsb_stosb_and_loop, VectorInt32) {
	std::vector<std::int32_t> v_src {'a','b','c','d','e'};
	std::vector<std::int32_t> v_dest(v_src.size(),'x');
	auto p_src_beg = reinterpret_cast<char*>(v_src.data());
	auto p_src_end = p_src_beg + v_src.size()*sizeof(std::int32_t);
	auto p_dest_beg = reinterpret_cast<char*>(v_dest.data());
	auto p_dest_end = p_dest_beg+v_dest.size()*sizeof(std::int32_t);

	auto return_value = copy_bytes_lodsb_stosb_and_loop(p_src_beg,p_src_end,p_dest_beg);

	EXPECT_EQ(return_value,p_dest_end);
	for (int i=0; i<v_src.size(); ++i) {
		EXPECT_EQ(v_src[i],v_dest[i]);
	}
}






