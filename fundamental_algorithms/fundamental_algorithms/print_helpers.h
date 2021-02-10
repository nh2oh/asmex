#pragma once
#include <vector>
#include <iostream>


template<typename I>
void print_csv(I beg, I end) {
	if (beg==end) {
		return;
	}
	while (true) {
		std::cout << *beg;
		++beg;
		if (beg==end) {
			break;
		}
		std::cout << ", ";
	}
}




