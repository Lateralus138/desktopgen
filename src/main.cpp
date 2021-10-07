#include "functions.h"
#include "pe.h"
#include <iostream>
#include <regex>
#include <filesystem>
#include <map>
#include <fstream>

#include <cerrno>
#include <cstring>

int main (int argc, char * argv [])
{
  std::vector <char *> args (argv + 1, argv + argc);
  (void) argv; argc--;

  auto
    is_verbose = true,
    is_monochrome = false;

  auto
    working_pth = std::filesystem::canonical ("./"),
    full_pth = working_pth;

  auto _error_ = ProgramErrors (0);
  _error_.generate (15);

  std::string file_name = "";

  std::map <std::string, std::string> param_map
  {
    {"name",""},{"comment",""},{"exec",""},{"categories","GNOME;GTK;Utility;"},
    {"type","Application"},{"terminal","false"},{"icon",""},{"generic",""}
  };

  if ((int) args.size () < 1)
  {
    is_monochrome = true;
    _error_.setErrorIndex (1);
    return formatted_return
    (
      is_verbose,
      is_monochrome,
      _error_,
      "", ""
    );
  }
  else
  {
    auto skip = false;
    auto match = [] (char * arg, std::string rgx)
    {
      return std::regex_match (arg, std::regex(rgx));
    };
    auto char_to_str = [] (char * char_ptr)
    {
      return std::string (char_ptr, char_ptr+ strlen (char_ptr));
    };
    for (auto index = 0; index < argc; index++)
    {
      auto arg_param = char_to_str (args [index]);
      auto not_provided_closure =
        [arg_param] (int error_integer, ProgramErrors & _error_)
        {
          _error_.insertError
          (
            error_integer,
              "Argument for the \'"
            + arg_param
            + "' parameter not provided."
          );
          _error_.setErrorIndex (error_integer);
        };
      if (skip)
      {
        skip = false;
        continue;
      }
      if (match (args [index], "^-([hH]|-[hH][eE][lL][pP])$"))
      {
        std::cout
          << '\n'   << "  \'desktopgen\' - Generate .desktop shortcut files  "
          << '\n'   << "  from the command line.                          "
          << "\n\n" << "  USAGE: desktopgen [OPTIONS]...                  "
          << "\n\n" << "  OPTIONS:                                        "
          << '\n'   << "    -h,--help       This help screen.             "
          << '\n'   << "    -p,--path       Directory of the new file.    "
          << '\n'   << "    -f,--file       The name of the file without  "
          << '\n'   << "                    the .desktop extension. This  "
          << '\n'   << "                    parameter has to be provided. "
          << '\n'   << "    -m,--monochrome Remove color from all output. "
          << '\n'   << "    -q,--quiet      All errors are non-verbose.   "
          << '\n'   << "    -n,--name       [Name] string entry.          "
          << '\n'   << "    -g,--generic    [GenericName] string entry.   "
          << '\n'   << "    -c,--comment    [Comment] string entry.       "
          << '\n'   << "    -e,--exec       [Exec] string entry.          "
          << '\n'   << "    -T,--terminal   [Terminal] string entry.      "
          << '\n'   << "    -t,--type       [Type] string entry.          "
          << '\n'   << "    -i,--icon       [Icon] string entry.          "
          << '\n'   << "    -C,--categories [Categories] string entry.    "
          << '\n'
          << std::endl;
        return _error_.error ();
      }
      if (match (args [index], "^-([mM]|-[mM][oO][nN][oO][cC][hH][rR][oO][mM][eE])$"))
      {
        is_monochrome = true;
        continue;
      }
      if (match (args [index], "^-([qQ]|-[qQ][uU][iI][eE][tT])$"))
      {
        is_verbose = false;
        continue;
      }
      if (match (args [index], "^-([pP]|-[pP][aA][tT][hH])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (2, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        auto arg_arg = char_to_str (args [index + 1]);
        auto tmp_pth = std::filesystem::path (arg_arg);
        _error_.generate (3);
        if (!std::filesystem::exists (tmp_pth))
        {
          _error_.insertError (3, "\'" +  arg_arg + "\' is not a valid path.");
          _error_.setErrorIndex (3);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        if (!std::filesystem::is_directory (tmp_pth))
        {
          _error_.insertError (4, "\'" +  arg_arg + "\' is not a directory.");
          _error_.setErrorIndex (4);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        working_pth = std::filesystem::canonical (tmp_pth);
        skip = true;
        continue;
      }
      if (match (args [index], "^-([fF]|-[fF][iI][lL][eE])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (5, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        file_name = char_to_str (args [index + 1]);
        if (file_name.empty ())
        {
          _error_.insertError
          (
            6,
              "Argument for the \'"
            + arg_param
            + "' parameter can not be empty."
          );
          _error_.setErrorIndex (6);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        skip = true;
        continue;
      }
      if (match (args [index], "^-([nN]|-[nN][aA][mM][eE])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (7, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        param_map ["name"] = char_to_str (args [index + 1]);
        skip = true;
        continue;
      }
      if (match (args [index], "^-([c]|-[cC][oO][mM][mM][eE][nN][tT])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (8, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        param_map ["comment"] = char_to_str (args [index + 1]);
        skip = true;
        continue;
      }
      if (match (args [index], "^-([eE]|-[eE][xX][eE][cC])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (9, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        param_map ["exec"] = char_to_str (args [index + 1]);
        skip = true;
        continue;
      }
      if (match (args [index], "^-([C]|-[cC][aA][tT][eE][gG][oO][rR][iI][eE][sS])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (10, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        param_map ["categories"] = char_to_str (args [index + 1]);
        skip = true;
        continue;
      }
      if (match (args [index], "^-([t]|-[tT][yY][pP][eE])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (11, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        param_map ["type"] = char_to_str (args [index + 1]);
        skip = true;
        continue;
      }
      if (match (args [index], "^-([T]|-[tT][eE][rR][mM][iI][nN][aA][lL])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (12, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        param_map ["terminal"] = char_to_str (args [index + 1]);
        skip = true;
        continue;
      }
      if (match (args [index], "^-([iI]|-[iI][cC][oO][nN])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (13, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        param_map ["icon"] = char_to_str (args [index + 1]);
        skip = true;
        continue;
      }
      if (match (args [index], "^-([gG]|-[gG][eE][nN][eE][rR][iI][cC])$"))
      {
        if ((index + 1) >= argc)
        {
          not_provided_closure (14, _error_);
          return formatted_return
          (
            is_verbose,
            is_monochrome,
            _error_,
            "", ""
          );
        }
        param_map ["generic"] = char_to_str (args [index + 1]);
        skip = true;
        continue;
      }
    }
  }
  if (file_name.empty ())
  {
    if (is_verbose)
    {
      std::cerr
        << '['
        << (is_monochrome?"":"\x1b[1;91m")
        << 17
        << (is_monochrome?"":"\x1b[m")
        << "]: "
        << (is_monochrome?"":"\x1b[1;93m")
        << "No file name provided."
        << (is_monochrome?"":"\x1b[m")
        << std::endl;
    }
    return 17;
  }
  std::string wpstr = working_pth.c_str ();
  if (wpstr [wpstr.length () - 1] != '/')
  {
    wpstr.append ("/");
    working_pth = std::filesystem::path (wpstr);
  }
  full_pth =
    std::filesystem::path
    (
        working_pth.c_str ()
      + file_name
      + ".desktop"
    );
  if (std::filesystem::exists (full_pth))
  {
    _error_.insertError
    (
      15, "\""
      + (std::string) full_pth.c_str ()
      + "\" already exists."
    );
    _error_.setErrorIndex (15);
    return formatted_return
    (
      is_verbose,
      is_monochrome,
      _error_,
      "", ""
    );
  }
  std::ofstream file_stream (full_pth);
  if (errno == 13)
  {
    if (is_verbose)
    {
      std::cerr
        << '['
        << (is_monochrome?"":"\x1b[1;91m")
        << 16
        << (is_monochrome?"":"\x1b[m")
        << "]: "
        << (is_monochrome?"":"\x1b[1;93m")
        << std::strerror (errno)
        << '.'
        << (is_monochrome?"":"\x1b[m")
        << std::endl;
    }
    return 16;
  }
  file_stream
    << "[Desktop Entry]" << '\n'
    << "Name=" << param_map ["name"] << '\n'
    << "GenericName=" << param_map ["generic"] << '\n'
    << "Comment=" << param_map ["comment"] << '\n'
    << "Exec=" << param_map ["exec"] << '\n'
    << "Terminal=" << param_map ["terminal"] << '\n'
    << "Type=" << param_map ["type"] << '\n'
    << "Icon=" << param_map ["icon"] << '\n'
    << "Categories=" << param_map ["categories"]
    << std::endl;
  file_stream.close ();
  return _error_.error ();
}
