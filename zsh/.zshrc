# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"
COMPLETION_WAITING_DOTS="true"


plugins=(git)

source $ZSH/oh-my-zsh.sh


alias dots="cd ~/.dotfiles"
alias lsdt="lsd --tree --depth=1"
alias nv="nvim"
