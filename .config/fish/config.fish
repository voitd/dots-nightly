set -x LC_ALL en_US.UTF-8
set -g theme_nerd_fonts yes
set -g fish_key_bindings fish_vi_key_bindings

set fish_greeting ""

starship init fish | source

#set -gx TERM xterm-256color
set -gx OPENAI_API_KEY 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
#export TERMINAL="kitty"

# Colored man-pages
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")


source $HOME/.config/fish/abbreviations/git.fish
source $HOME/.config/fish/abbreviations/main.fish



