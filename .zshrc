# tmux自動起動できるやーつ
#[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

########################################
# 環境変数
export LANG=ja_JP.UTF-8

# pyenv
export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# rbenv(URL：http://h2ham.net/ruby-rbenv)
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# jenv(URL: http://takmnagaya.hatenablog.com/entry/2017/01/08/141624)
export PATH=$HOME/.jenv/bin:$PATH
eval "$(jenv init -)"

# git
export PATH=/usr/local/Cellar/git/2.16.1/bin:$PATH

# java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
########################################
# 色を使用出来るようにする
autoload -Uz colors
colors

# node.js
export PATH=$HOME/.nodebrew/current/bin:$PATH

# vim 風キーバインドにする
bindkey -v

bindkey "^A" beginning-of-line
bindkey "^B" backward-char
bindkey "^D" delete-char-or-list
bindkey "^E" end-of-line
bindkey "^F" forward-char
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^N" history-beginning-search-forward
bindkey "^P" history-beginning-search-backward
bindkey "^Y" yank
#他は: http://mollifier.hatenablog.com/entry/20081213/1229148947

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# 1行表示
# PROMPT="%~ %# "
PROMPT="$ "
# 2行表示
# PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
# %# "


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
        /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス
alias vi="vim"
alias la='ls -a'
alias ll='ls -l'

#alias rm='rm -i'
#alias cp='cp -i'
#alias mv='mv -i'

alias vm="cd ~/dev/vagrant/ubuntu-16.04"
alias vh="vagrant halt"
alias vr="vagrant reload"
alias vu="vagrant up"
alias vs="vagrant ssh"
alias vsx="ssh -X vagrant"

alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gs='git status'
alias gcm='git checkout master'
alias gpom='git pull origin master'
alias gmm='git merge master'

# SSH
alias ksu="ssh -D 1080 i1788250@cc2000.kyoto-su.ac.jp"
alias seeds='ssh -i ~/.ssh/seeds.key root@192.168.100.11'

alias mkdir='mkdir -p'
alias camera='sudo killall VDCAssistant'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
    elif which xsel >/dev/null 2>&1 ; then
    # Linux
    #alias -g C='| xsel --input --clipboard'
    #elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    #alias -g C='| putclip'
fi



########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        #alias ls='ls -F --color=auto'
        ;;
esac

# vim:set ft=zsh:

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/ryosuke/Desktop/seeds/bigquery/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ryosuke/Desktop/seeds/bigquery/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/Users/ryosuke/Desktop/seeds/bigquery/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ryosuke/Desktop/seeds/bigquery/google-cloud-sdk/completion.zsh.inc'; fi
#export PATH="/usr/local/opt/gettext/bin:$PATH"
#export GOOGLE_APPLICATION_CREDENTIALS="/Users/ryosuke/Desktop/seeds/bigquery/wp_auth.json"

