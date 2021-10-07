#pragma once
#ifndef PE_H
#define PE_H

#include "ProgramErrors.h"

int formatted_return
(
  bool is_verbose,
  bool is_monochrome,
  ProgramErrors & _error_,
  std::string prefix,
  std::string suffix
);

#endif
