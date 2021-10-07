#pragma once
#ifndef PROGRAMERRORS_H
#define PROGRAMERRORS_H

#include <string>
#include <vector>

class ProgramErrors
{
private:
  std::vector <std::string> error_message_vector
  {
    // ALWAYS KEEP
    // INITIAL VALUE
    // YOU CAN LEAVE AN EMPTY STRING
    "No error.",
    "Invalid number of arguments passed to the program."
  };
  int error_current_integer = 0;
  std::string
    error_current_message =
      error_message_vector [error_current_integer],
    error_current_message_formatted =
      "[\x1b[1;91m"
      + std::to_string (error_current_integer)
      + "\x1b[m]: \x1b[1;93m"
      + error_current_message
      + "\x1b[m";
public:
  ProgramErrors (int error_integer);
  int error ();
  std::string message ();
  std::string getMessageByIndex (int error_integer);
  void setErrorIndex (int error_integer);
  void setMessageByIndex (int error_integer, std::string error_message);
  int getErrorArraySize ();
  void setFormat (std::string optional_prefix, std::string optional_suffix);
  void printf (std::string optional_prefix, std::string optional_suffix);
  int printf_return (std::string optional_prefix, std::string optional_suffix);
  void print ();
  void appendError (std::string error_string);
  int print_return ();
  void insertError (int index_offset, std::string error_string);
  void generate (int max_index);
};

#endif
