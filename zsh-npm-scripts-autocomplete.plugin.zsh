local _plugin_path=$0
local _PWD=`echo $_plugin_path | sed -e 's/\/zsh-npm-scripts-autocomplete\.plugin\.zsh//'`
__zna_pwd="$_PWD"

__znsaGetDependencies() {
  local pkgJson="$1"
  node "$__zna_pwd/getDependencies.js" "$pkgJson" 2>/dev/null
}

__znsaGetScripts() {
  local pkgJson="$1"
  node "$__zna_pwd/getScripts.js" "$pkgJson" 2>/dev/null
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
  # Return if the length of arguments is not 2 or 3
  local argsLength="$(__znsaArgsLength)"
  [[ "$argsLength" -ne "2" && "$argsLength" -ne "3" ]] && return

  # Return if package.json is not found
  local pkgJson="$(__znsaFindFile package.json)"
  [[ "$pkgJson" == "" ]] && return

  # Handle `yarn <script>` command
  if [[ "$argsLength" = "2" ]]; then
    # Get the scripts
    local -a options=(${(f)"$(__znsaGetScripts $pkgJson)"})
    [[ "$#options" = 0 ]] && return

    # Describe the options for autocompletion
    _describe 'values' options
    return
  fi

  # Handle `yarn/pnpm remove/rm <dependency>` command
  if [[ "$argsLength" = "3" ]]; then
    # Return if the command is not `remove` or `rm`
    [[ "${words[2]}" != "rm" && "${words[2]}" != "remove" ]] && return

    # Get the dependencies
    local -a options=(${(f)"$(__znsaGetDependencies $pkgJson)"})
    [[ "$#options" = 0 ]] && return

    # Describe the options for autocompletion
    _describe 'values' options
    return
  fi
}

compdef __znsaYarnRunCompletion pnpm
compdef __znsaYarnRunCompletion yarn
compdef __znsaNpmRunCompletion bun
