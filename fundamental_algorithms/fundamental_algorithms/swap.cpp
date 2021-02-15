#include "algs\swap.h"
#include "algs\copy.h"
#include "algs\utils.h"
#include <vector>
#include <random>
#include <chrono>
#include <cstdint>
#include <limits>
#include <iostream>

void benchmark_swap() {
	struct weird_struct {
		double a;
		char b;
		std::int64_t c;
		bool d;
		double e;
	};
	std::random_device rdev;
	std::default_random_engine reng(rdev());
	std::uniform_int_distribution<std::uint64_t> rdist(0,std::numeric_limits<std::uint64_t>::max());
	
	std::size_t n_elements = 100'000'000;

	std::vector<weird_struct> rv1(n_elements);
	for (auto& element : rv1) {
		auto rint = rdist(reng);
		element.a = rint;
		element.b = static_cast<char>(rint);
		element.c = rint;
		element.d = false;
		element.e = 1.23557*rint;
	}
	std::vector<weird_struct> rv2(n_elements);
	for (auto& element : rv2) {
		auto rint = rdist(reng);
		element.a = rint;
		element.b = static_cast<char>(rint);
		element.c = rint;
		element.d = false;
		element.e = 1.23557*rint;
	}

	
	for (int i=0; i<10; ++i) {
		std::cout << "std::swap():  ";
		auto tstart = std::chrono::steady_clock::now();
		for (std::size_t j=0; j<rv1.size(); ++j) {
			std::swap(rv1[j],rv2[j]);
		}
		auto tend = std::chrono::steady_clock::now();
		opaque_function(&rv1,&rv2);
		std::chrono::duration<double> elapsed_seconds = tend-tstart;
		std::cout << elapsed_seconds.count() << "s\n";

		std::cout << "swap_n():  ";
		tstart = std::chrono::steady_clock::now();
		auto p1 = rv1.data();  auto p2 = rv2.data();
		for (std::size_t j=0; j<rv1.size(); ++j) {
			swap_n(p1+j,p2+j,sizeof(weird_struct));
		}
		tend = std::chrono::steady_clock::now();
		opaque_function(&rv1,&rv2);
		elapsed_seconds = tend-tstart;
		std::cout << elapsed_seconds.count() << "s\n";

		std::cout << std::endl;
	}
}

