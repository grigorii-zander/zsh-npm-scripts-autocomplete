# zsh-npm-scripts-autocomplete
This plugin shows autocomplete suggestions for `npm` scripts from `package.json` at current working directory.
Works with `npm` and `yarn`

![](docs/demo.gif)

## Installation
### oh-my-zsh

#### Step 1
Clone this repository to oh-my-zsh plugins folder  
(by default `~/.oh-my-zsh/custom/plugins`):
```shell
$ git clone \
  git@github.com:grigorii-zander/zsh-npm-scripts-autocomplete.git \
  ~/.oh-my-zsh/custom/plugins/zsh-npm-scripts-autocomplete
```

#### Step 2
Add plugin to your `.zshrc` config:
```shell
plugins=(
  zsh-npm-scripts-autocomplete
)

```

#### Step 3
Restart your terminal or reload `.zshrc` config with following command:
```shell
$ source ~/.zshrc
```
