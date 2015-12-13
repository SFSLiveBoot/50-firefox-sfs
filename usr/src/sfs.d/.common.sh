: ${locale:=en-US}
: ${arch:=$(uname -m)}
: ${name:=firefox}
: ${inst_path:=opt}
: ${app_ini:=$DESTDIR/$inst_path/$name/application.ini}

: ${redirector_url:=https://download.mozilla.org/?product=${name}-latest&os=linux64&lang=$locale}

: ${dl_base:=http://ftp.mozilla.org/pub/mozilla.org/$name/releases/latest/linux-$arch/$locale/}

latest_url() {
  curl -s -I "$redirector_url" | awk '/^Location: /{print $2}' | tr -d \\r
}

available_version() {
  local ret
  ret="$(basename $(latest_url) .tar.bz2)"
  echo "${ret#$name-}"
}

installed_version() {
  grep ^Version= "$app_ini" | cut -f2 -d=
}
