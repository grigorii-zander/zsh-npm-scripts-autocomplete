local plugin_path=$0
local _PWD=`echo $plugin_path | sed -e 's/\/zsh-npm-scripts-autocomplete\.plugin\.zsh//'`

znsaGetScripts() {
  local pkgJson="$1"
  node "$_PWD/getScripts.js" "$pkgJson"
}

znsaFindFile() {
  local filename="$1"
  local dir=$PWD
  while [ ! -e "$dir/$filename" ]; do
    dir=${dir%/*}
    [[ "$dir" = "" ]] && break
  done
  [[ ! "$dir" = "" ]] && echo "$dir/$filename"
}

znsaArgsLength() {
  echo "$#words"
}

znsaYarnRunCompletion() {
  # Only run on `yarn ?`
  [[ ! "$(znsaArgsLength)" = "2" ]] && return
  local pkgJson="$(znsaFindFile package.json)"
  [[ "$pkgJson" = "" ]] && return
  local -a options
  options=(${(f)"$(znsaGetScripts $pkgJson)"})
  [[ "$#options" = 0 ]] && return
  _describe 'values' options
}

znsaNpmRunCompletion() {
  [[ ! "$(znsaArgsLength)" = "3" ]] && return
  local pkgJson="$(znsaFindFile package.json)"
  [[ "$pkgJson" = "" ]] && return
  local -a options
  options=(${(f)"$(znsaGetScripts $pkgJson)"})
  [[ "$#options" = 0 ]] && return
  _describe 'values' options
}

znsaHandleYarn() {
  znsaYarnRunCompletion
}

znsaHandleNpm(){
  case "${words[2]}" in
    run)
      znsaNpmRunCompletion
      ;;
  esac
}

alias nr="npm run"
compdef znsaYarnRunCompletion yarn
compdef znsaYarnRunCompletion nr
compdef znsaHandleNpm npm
