#!/usr/bin/env bash
cd "$(dirname $0)"
error=11
exe=desktopgen
root='..'
debian="${root}/debian"
bin="${debian}/usr/bin"
released="${root}/release/linux/dynamic"
release="${released}/${exe}"
error=$((error + 1))
[[ ! -d "$root" ]] && exit $error
error=$((error + 1))
[[ ! -d "$debian" ]] && exit $error
error=$((error + 1))
[[ ! -d "$bin" ]] && exit $error
error=$((error + 1))
[[ ! -d "$released" ]] && exit $error
error=$((error + 1))
[[ ! -f "$release" ]] && exit $error
error=$((error + 1))
mkdir "${root}/release/debian" || exit $error
error=$((error + 1))
if cp "${release}" "${bin}/${exe}"; then
  error=$((error + 1))
  if dpkg-deb -b "${debian}" "${root}/release/debian/${exe}.deb"; then
    printf '%s\n' "Debian package created successfully." 
  else exit $error; fi
else exit $error; fi
