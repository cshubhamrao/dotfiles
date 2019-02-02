# Lines configured by zsh-newuser-install
#HISTFILE=~/.histfile
#HISTSIZE=1000
#SAVEHIST=1000
setopt autocd beep extendedglob
#POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k

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
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k

antigen theme bhilburn/powerlevel9k powerlevel9k
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
DEFAULT_USER=$USER
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(load context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time newline anaconda)
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
export PATH=$PATH:/home/shubham/devel/flutter/bin
export ANDROID_HOME=/home/shubham/devel/Android/sdk/

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/shubham/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/shubham/anaconda3/etc/profile.d/conda.sh" ]; then
 #       . "/home/shubham/anaconda3/etc/profile.d/conda.sh"
 #   else
 #       export PATH="/home/shubham/anaconda3/bin:$PATH"
 #   fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

