#!/usr/bin/env bash
cd "$(dirname $0)"
error=0
bld_lnx_rls='buildlinuxrelease.sh'
bld_dbn_rls='builddebianrelease.sh'
error=$((error + 1))
if [[ ! -f "$bld_lnx_rls" ]]; then
  exit $error
fi
error=$((error + 1))
if [[ ! -f "$bld_dbn_rls" ]]; then
  exit $error
fi
if ./${bld_lnx_rls}; then
  if ./${bld_dbn_rls}; then
    printf '%s\n' "All builds successful."
  else exit $?; fi
else exit $?; fi
