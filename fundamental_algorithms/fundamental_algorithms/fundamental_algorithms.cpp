#include <iostream>
#include <string>
#include <cstdint>
#include <vector>
#include "algs\reverse.h"
#include "algs\dummy_func.h"
#include "print_helpers.h"


int main() {
	std::string msg = "Hello World!";
	std::cout << msg << '\n';
	
	auto pbeg = msg.data();
	auto pend = msg.data()+msg.size();
	reverse_bytes_return_void(pbeg,pend);
	//dummy_func(pbeg,pend);
	std::cout << msg << '\n';

	std::vector<std::uint64_t> vui64 {0,1,2,3,4,5,6,7,8,9,10};
	print_csv(vui64.begin(),vui64.end());
	std::cout << '\n';
	reverse_ui64_return_void(vui64.data(),vui64.data()+vui64.size());
	print_csv(vui64.begin(),vui64.end());


	return 0;
}

