#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt.uld stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ZSH customs

export PATH=$PATH:~/bin
setopt clobber
zstyle ':completion:*' rehash true
zstyle ':completion:*' special-dirs true

# export HISTFILE=~/.zsh_history
# export HISTFILESIZE=100000
# export HISTSIZE=100000

unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"
PROMPT_EOL_MARK=''

##### aliases ######

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
alias k=kubectl
alias icat='kitten icat --align=left'
alias idiff='kitten diff'
alias issh='kitten ssh'
alias ls='ls --group-directories-first --color=auto --hyperlink=auto'
alias bkpwd='rm -rf ${PWD}.bak ; cp -a $PWD{,.bak}'
alias rgh="rg --hidden --glob '!.git/'"
alias fdh='fd --hidden --no-ignore --exclude .git'
alias vim=nvim
alias neovim=nvim
alias disable-hl='ZSH_HIGHLIGHT_MAXLENGTH=0'
alias atuin_delete='atuin search --delete --search-mode=full-text $1'
alias atuin_search='atuin search --search-mode=full-text $1'

##### Functions to be used from command line #####

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

siteinfo () {
  local url=$(echo "$1" | sed 's#^https\?://##')
  local ip="$(dig +short "$url" | tail -1)"

  whois "$ip"
  echo "Technology detected for $url with IP $ip"
  httpx-toolkit -silent -json -follow-redirects -ip -tech-detect -target "$url" | jq -rc '.tech'
}

##### tilix ####

if [ $TILIX_ID ] || [ $VTE_VERSION ]  ; then
    source /etc/profile.d/vte.sh
fi

##### default apps #####

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export BROWSER='/usr/bin/vivaldi-stable'

##### venvs ######

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper_lazy.sh
alias workondir='workon $(basename $(pwd))'

##### fzf #####

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

fzf-file-widget-hidden () {
  fd --type f --hidden --follow --exclude .git --exclude .cache | fzf
}

export FZF_DEFAULT_COMMAND="fd --type file --follow"
export FZF_DEFAULT_OPTS="-m --reverse \
                        --color 'info:#00AAFF,prompt:#FFFFFF,pointer:#00AAFF,hl:#1AE51A,hl+:#1AE51A' \
                        --tabstop=4"
                        # --bind 'ctrl-o:execute(xdg-open {})+abort,ctrl-e:execute({})+abort,ctrl-y:execute(echo {} | xclip -selection clipboard -in)+abort'"
export FZF_CTRL_T_OPTS="--no-height --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || pygmentize {} 2> /dev/null | head -500'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

bindkey '^P' fzf-file-widget
zle     -N   fzf-file-widget-hidden
bindkey '^H' fzf-file-widget-hidden

## SSH agent

if [ -z $SSH_AUTH_SOCK ] && [ -S "${XDG_RUNTIME_DIR}/ssh-agent.socket" ]; then
   export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi

## direnv

eval "$(direnv hook zsh)"

# Atuin zsh history

eval "$(atuin init zsh)"

# custom device

source ~/.zshrc_custom

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#zprof
