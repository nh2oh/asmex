#pragma once

extern "C" {
	char* copy_bytes_lodsb_stosb_and_loop(const char*, const char*, char*);
	char* copy_bytes(const char*, const char*, char*);


	char* copy_bytes_backwards(const char*, const char*, char*);
}
