if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -U fish_greeting

# Utilities 
alias c="clear"
alias ll="lsd -1 -hal --blocks permission,user,size,name --group-dirs=first"
alias btop="btop --utf-force"
alias lg="lazygit"

# Package Manager
alias search="yay -Ss "
alias install="yay -S --needed "
alias update="yay -Syu "
alias remove="yay -R "

fish_vi_key_bindings
bind -M insert -m default ii backward-char force-repaint
bind -M insert \ef accept-autosuggestion

starship init fish | source

set -gx PATH $HOME/.pyenv/bin $PATH
status --is-interactive; and . (pyenv init --path | psub)
status --is-interactive; and . (pyenv init - | psub)
status --is-interactive; and . (pyenv virtualenv-init - | psub)

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/gajeet/.lmstudio/bin
