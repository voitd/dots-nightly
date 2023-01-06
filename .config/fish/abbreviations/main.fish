# General
abbr -ag ls "exa -Slhg --icons"
abbr -ag lsa "exa -Slhga --icons"
abbr -ag tree "exa -SlhgT --icons"
abbr -ag r "ranger"
abbr -ag n "nvim"
abbr -ag cc "clear"

abbr gist 'pbpaste | gh gist create | rg github | pbcopy'

abbr -ag .. "cd .."
abbr -ag ... "cd ../.."
abbr -ag .... "cd ../../.."


## get top process eating memory
abbr -ag psmem 'ps aux | sort -nr -k 4 | head -10'

## get top process eating cpu ##
abbr -ag pscpu 'ps -er -o pid,pcpu,comm | head -10'

abbr -ag reload "source ~/.config/fish/config.fish | echo "Reloaded!" "
