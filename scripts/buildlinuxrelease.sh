#!/usr/bin/env bash
cd "$(dirname $0)"
error=2
root='..'
source="${root}/src"
lib="${source}/lib"
include="${source}/include"
libs=( functions ProgramErrors pe )
error=$((error + 1))
[[ ! -d "$root" ]] && exit $error
error=$((error + 1))
[[ ! -d "$source" ]] && exit $error
error=$((error + 1))
[[ ! -d "$lib" ]] && exit $error
error=$((error + 1))
[[ ! -d "$include" ]] && exit $error
for libv in "${libs[@]}"; do
  error=$((error + 1))
  if [[ ! -f "${lib}/${libv}.o" ]]; then
    exit $error
  fi
  error=$((error + 1))
  if [[ ! -f "${include}/${libv}.h" ]]; then
    exit $error
  fi
done
cd "${root}"
error=$((error + 1))
if make cleantest test; then
  make cleantest
  error=$((error + 1))
  if make cleandebug debug; then
    make cleandebug
    error=$((error + 1))
    if make; then
      printf '%s\n' "All MAKE tasks completed successfully."
      cd "${root}"
    else exit $error; fi
  else exit $error; fi
else exit $error; fi
