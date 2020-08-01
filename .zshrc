# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ZSH customs

export PATH=$PATH:~/bin
setopt clobber
zstyle ':completion:*' rehash true

unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"

##### aliases ######

alias ccat="pygmentize -O style=native -g "
alias chromium-socks='chromium --proxy-server=socks://localhost:3000'
alias curlmobile='curl -A "Mozilla/5.0 (Linux; Android 9; AR 4G) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Mobile Safari/537.36"'
alias curlr='curl -o /dev/null -w "\n\nCode:   \t%{http_code}\n\nDNS:    \t%{time_namelookup}\nConnect:\t%{time_connect}\nStartTransfer:\t%{time_starttransfer} (PreTransfer:%{time_pretransfer})\nTotal:   \t%{time_total}\n\n"'
alias curlh='curl -sD - -o /dev/null'
alias duh='du -sch .[!.]* *'
alias gb="git checkout \$(git branch -avv | fzf +m | awk '{print \$1}')"
alias open='xdg-open'
alias yayU='yay -Suy --noconfirm'
alias mknamedvenv='mkvirtualenv $(basename $PWD) -r requirements.txt'
alias dkillall='docker rm -f $(docker ps -qa)'

##### tilix #####

if [ $TILIX_ID ] || [ $VTE_VERSION ]  ; then
    source /etc/profile.d/vte.sh
fi

##### default apps #####

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export BROWSER='/usr/bin/firefox'

##### venvs ######

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
alias workondir='workon $(basename $(pwd))'

##### fzf #####

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

fzf-file-widget-hidden () {
  fd --type f --hidden -I --follow --exclude .git --exclude .cache | fzf
}

dexec () {
  local cid
  local cmd=("$@")

  if [ -z "$1" ]; then
    cmd=(bash)
  fi

  cid=$(docker ps -a | sed 1d | fzf -1 | awk '{print $1}')

  [ -n "$cid" ] && docker exec -ti "$cid" "${cmd[@]}"
}

kexec () {
  local cid
  local cmd=("$@")

  if [ -z "$1" ]; then
    cmd=(bash)
  fi

  cid=$(kubectl get pods | sed 1d | fzf -1 | awk '{print $1}')

  [ -n "$cid" ] && kubectl exec -ti "$cid" -- "${cmd[@]}"
}

export FZF_DEFAULT_COMMAND="fd --type f --follow -I"
export FZF_DEFAULT_OPTS="-m --reverse --bind 'ctrl-o:execute(xdg-open {})+abort,ctrl-e:execute({})+abort,ctrl-y:execute(echo {} | xclip -selection clipboard -in)+abort'"
export FZF_CTRL_T_OPTS="--no-height --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || pygmentize {} 2> /dev/null | head -500'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

bindkey '^P' fzf-file-widget
zle     -N   fzf-file-widget-hidden
bindkey '^H' fzf-file-widget-hidden

## SSH agent

if [ -z $SSH_AUTH_SOCK ] && [ -S "${XDG_RUNTIME_DIR}/ssh-agent.socket" ]; then
   export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi

# Autocompletion
autoload -U compinit
compinit
source /usr/bin/aws_zsh_completer.sh

# custom device

source ~/.zshrc_custom
