#include "copy.h"
#include "algs\copy.h"
#include "algs\utils.h"
#include <vector>
#include <random>
#include <chrono>
#include <cstdint>
#include <limits>
#include <iostream>
#include <cstring>

void benchmark_copy() {
	std::random_device rdev;
	std::default_random_engine reng(rdev());
	std::uniform_int_distribution<std::uint64_t> rdist(0,std::numeric_limits<std::uint64_t>::max());
	
	std::vector<std::uint64_t> rv64(4092*1000,0);
	for (auto& e : rv64) {
		e = rdist(reng);
	}

	std::vector<std::uint64_t> rv64_dest(rv64.size(),0);
	for (int i=0; i<10; ++i) {
		rv64_dest.clear();
		std::cout << "std::memcpy():  ";
		auto tstart = std::chrono::steady_clock::now();
		std::memcpy(rv64_dest.data(),rv64.data(),rv64_dest.size()*sizeof(std::uint64_t));
		auto tend = std::chrono::steady_clock::now();
		std::chrono::duration<double> elapsed_seconds = tend-tstart;
		std::cout << elapsed_seconds.count() << "s\n";
		opaque_function(rv64_dest.data(),rv64_dest.data()+7);

		rv64_dest.clear();
		std::cout << "copy_bytes():  ";
		tstart = std::chrono::steady_clock::now();
		copy_bytes(reinterpret_cast<char*>(rv64.data()),
					reinterpret_cast<char*>(rv64.data()+rv64.size()),
					reinterpret_cast<char*>(rv64_dest.data()));
		tend = std::chrono::steady_clock::now();
		elapsed_seconds = tend-tstart;
		std::cout << elapsed_seconds.count() << "s\n";
		opaque_function(rv64_dest.data(),rv64_dest.data()+7);

		rv64_dest.clear();
		std::cout << "copy_64():  ";
		tstart = std::chrono::steady_clock::now();
		copy_64(rv64.data(),rv64.data()+rv64.size(),rv64_dest.data());
		tend = std::chrono::steady_clock::now();
		elapsed_seconds = tend-tstart;
		std::cout << elapsed_seconds.count() << "s\n";
		opaque_function(rv64_dest.data(),rv64_dest.data()+7);

		std::cout << std::endl;
	}
}

