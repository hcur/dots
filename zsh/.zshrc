## !! macos .zshrc !!

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias dots="cd ~/.dotfiles"
alias l="lsd -a --tree --depth=1"

# Go development
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"
