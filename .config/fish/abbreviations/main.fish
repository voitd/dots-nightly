# General
abbr -ag ls "exa -G  --color auto --icons -a -s type"
abbr -ag ll "exa -alhF --group-directories-first --time-style=long-iso"

abbr -ag tree "exa -SlhgT --icons"
abbr -ag r "ranger"
abbr -ag n "nvim"
abbr -ag cc "clear"

abbr -ag python "python3"

abbr gist 'pbpaste | gh gist create | rg github | pbcopy'

abbr -ag .. "cd .."
abbr -ag ... "cd ../.."
abbr -ag .... "cd ../../.."


## get top process eating memory
abbr -ag psmem 'ps aux | sort -nr -k 4 | head -10'

## get top process eating cpu ##
abbr -ag pscpu 'ps -er -o pid,pcpu,comm | head -10'

abbr -ag reload "source ~/.config/fish/config.fish | echo "Reloaded!" "

abbr watts "/usr/sbin/ioreg -rw0 -c AppleSmartBattery | grep BatteryData | grep -o '"AdapterPower"=[0-9]*' | cut -c 16- | xargs -I %  lldb --batch -o "print/f %" | grep -o '$0 = [0-9.]*' | cut -c 6-"

abbr speed "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"

alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
