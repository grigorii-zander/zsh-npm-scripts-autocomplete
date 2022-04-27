local _plugin_path=$0
local _PWD=`echo $_plugin_path | sed -e 's/\/zsh-npm-scripts-autocomplete\.plugin\.zsh//'`

__znsaGetScripts() {
  local pkgJson="$1"
  node "$_PWD/getScripts.js" "$pkgJson" 2>/dev/null
}

__znsaFindFile() {
  local filename="$1"
  local dir=$PWD
  while [ ! -e "$dir/$filename" ]; do
    dir=${dir%/*}
    [[ "$dir" = "" ]] && break
  done
  [[ ! "$dir" = "" ]] && echo "$dir/$filename"
}

__znsaArgsLength() {
  echo "$#words"
}

__znsaYarnRunCompletion() {
  [[ ! "$(__znsaArgsLength)" = "2" ]] && return
  local pkgJson="$(__znsaFindFile package.json)"
  [[ "$pkgJson" = "" ]] && return
  local -a options
  options=(${(f)"$(__znsaGetScripts $pkgJson)"})
  [[ "$#options" = 0 ]] && return
  _describe 'values' options
}

## to lazy to handler different number of arguments
## just copy and paste it
__znsaNpmRunCompletion() {
  [[ ! "$(__znsaArgsLength)" = "3" ]] && return
  local pkgJson="$(__znsaFindFile package.json)"
  [[ "$pkgJson" = "" ]] && return
  local -a options
  options=(${(f)"$(__znsaGetScripts $pkgJson)"})
  [[ "$#options" = 0 ]] && return
  _describe 'values' options
}

__znsaHandleYarn() {
  __znsaYarnRunCompletion
}

__znsaHandleNpm(){
  case "${words[2]}" in
    run)
      __znsaNpmRunCompletion
      ;;
  esac
}

alias nr="npm run"
compdef __znsaYarnRunCompletion yarn
compdef __znsaYarnRunCompletion nr
compdef __znsaYarnRunCompletion pnpm
compdef __znsaHandleNpm npm
