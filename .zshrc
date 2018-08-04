# Lines configured by zsh-newuser-install
#HISTFILE=~/.histfile
#HISTSIZE=1000
#SAVEHIST=1000
setopt autocd beep extendedglob
#source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

source ~/.antigen.zsh
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme robbyrussell
antigen theme bhilburn/powerlevel9k
# Tell Antigen that you're done.
antigen apply
# End of lines configured by zsh-newuser-install
HISTFILE=~/.histfile
setopt APPEND_HISTORY          # history appends to existing file
setopt HIST_FIND_NO_DUPS       # history search finds once only
setopt HIST_IGNORE_ALL_DUPS    # remove all earlier duplicate lines
setopt HIST_REDUCE_BLANKS      # trim multiple insgnificant blanks in history
setopt HIST_NO_STORE           # remove the history (fc -l) command from the history when invoked
#HISTFILE=$HOME/.zsh/history    # history file location
HISTSIZE=1000000               # number of history lines kept internally
SAVEHIST=1000000               # max number of history lines saved
