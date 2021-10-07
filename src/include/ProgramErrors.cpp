#include "ProgramErrors.h"
#include <iostream>

ProgramErrors::ProgramErrors (int error_integer)
{
  setErrorIndex
  (
    (error_integer < error_message_vector.size ())
      ?error_integer
      :error_current_integer
  );
}

int ProgramErrors::error ()
{
  return error_current_integer;
}

std::string ProgramErrors::message ()
{
  return error_current_message;
}

std::string ProgramErrors::getMessageByIndex (int error_integer)
{
  if (error_integer < error_message_vector.size ())
    return error_message_vector [error_integer];
  return "";
}

void ProgramErrors::setErrorIndex (int error_integer)
{
  if (error_integer < error_message_vector.size ())
  {
      error_current_integer = error_integer;
      error_current_message = error_message_vector [error_current_integer];
      error_current_message_formatted =
        "[\x1b[1;91m"
        + std::to_string (error_current_integer)
        + "\x1b[m]: \x1b[1;93m"
        + error_current_message
        + "\x1b[m";
  }
}

void ProgramErrors::setMessageByIndex (int error_integer, std::string error_message)
{
  if (error_integer < error_message_vector.size ())
  {
    error_message_vector [error_integer] = error_message;
  }
}
int ProgramErrors::getErrorArraySize ()
{
  return (int) error_message_vector.size ();
}

void ProgramErrors::setFormat (std::string optional_prefix = "", std::string optional_suffix = "")
{
  error_current_message_formatted =
    optional_prefix + error_current_message + optional_suffix;
}

void ProgramErrors::printf (std::string optional_prefix = "", std::string optional_suffix = "")
{
  if (!optional_prefix.empty () || !optional_suffix.empty ())
  {
    setFormat (optional_prefix, optional_suffix);
  }
  std::cerr
    << error_current_message_formatted
    << std::endl;
}

int ProgramErrors::printf_return (std::string optional_prefix = "", std::string optional_suffix = "")
{
  printf (optional_prefix, optional_suffix);
  return error_current_integer;
}

void ProgramErrors::print ()
{
  std::cerr
    << error_current_message
    << std::endl;
}
int ProgramErrors::print_return ()
{
  print ();
  return error_current_integer;
}

void ProgramErrors::appendError (std::string error_string)
{
  error_message_vector.push_back (error_string);
}

void ProgramErrors::insertError (int index_offset, std::string error_string)
{
  if (index_offset <= error_message_vector.size ())
  {
    error_message_vector.insert
    (
      error_message_vector.begin () + index_offset,
      error_string
    );
  }
}

void ProgramErrors::generate (int max_index)
{
  for
  (
    auto index = getErrorArraySize ();
    index < max_index;
    index++
  )
  {
    insertError (index, "");
  }
}
