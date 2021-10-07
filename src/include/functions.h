#pragma once
#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <string>
#include <vector>

template <typename T>
void print_type (T variable);

std::vector <std::string> delim_to_vector (std::string string_t, std::string delim, bool reject_empty);

std::string get_stdout (std::string cmdstring);

std::string pad_string (std::string text, std::string pad_text, bool pad_left, int full_len);

std::string to_upper (std::string string_);

#endif
