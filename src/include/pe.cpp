#include "pe.h"

int formatted_return
(
  bool is_verbose,
  bool is_monochrome,
  ProgramErrors & _error_,
  std::string prefix = "",
  std::string suffix = ""
)
{
  return
    is_verbose
    ?is_monochrome
      ?_error_.print_return ()
      :_error_.printf_return (prefix, suffix)
    :_error_.error ();
};
