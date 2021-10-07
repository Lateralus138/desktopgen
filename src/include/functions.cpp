#include "functions.h"
#include <unistd.h>
#include <iostream>

#include <cerrno>
#include <cstring>

#define MAXBUFFER 256

#include <typeinfo>
template <typename T>
void print_type (T variable)
{
  std::cout
    << "Value: " << variable
    << "\nType: " << typeid (variable).name ()
    << std::endl;
}

std::string get_stdout (std::string cmdstring)
{
  std::string data;
  FILE * filestream;
  char buffer [MAXBUFFER];
  if (filestream = popen (cmdstring.c_str(), "r"))
  {
    while (!feof (filestream))
    {
      if (fgets (buffer, MAXBUFFER, filestream) != NULL)
      {
      	data.append (buffer);
      }
    }
    auto result = pclose (filestream);
    errno = ((result == EXIT_SUCCESS)?0:8);
  }
  else
  {
    errno = ((errno == 0)?5:errno);
  }
  return data;
}

std::vector <std::string> delim_to_vector (std::string string_t, std::string delim, bool reject_empty)
{
  size_t delim_pos = 0;
  std::string token;
  std::vector <std::string> string_vector;
  while ((delim_pos = string_t.find (delim)) != std::string::npos)
  {
    token = string_t.substr(0, delim_pos);
		string_t.erase(0, delim_pos + delim.length());
		if (reject_empty && token.empty ()) continue;
		string_vector.push_back (token);
  }
	if (!(reject_empty && string_t.empty ()))
  	string_vector.push_back (string_t);
  return string_vector;
}

std::string pad_string (std::string text, std::string pad_text, bool pad_left, int full_len)
{
  std::string
    result = text,
    pad_string = "";
  for  (auto index = 0; index < (int)(full_len - text.length ()); index++ )
  {
    pad_string.append (pad_text);
  }
  result.insert((pad_left?0:text.length ()), pad_string);
  return result;
}

std::string to_upper (std::string string_)
{
  auto _string_ = string_;
  if (!string_.empty ())
  {
    for (auto index = 0; index <= _string_.length (); index++)
    {
      _string_ [index] = std::toupper (_string_ [index]);
    }
  }
  return _string_;
}
