#! /bin/zsh

## Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Install MacOs command line tools
xcode-select --install

## Install Ghostty
brew install --cask ghostty

## Install Google Cloud SDK
brew install google-cloud-sdk

## Install kubectl
brew install kubectl    

## Install nvm
brew install nvm

## Install Node.js
nvm install node --lts

## Install fonts
brew install --cask font-hack-nerd-font font-fragment-mono font-fragment-mono-sc font-meslo-lg-nerd-font font-0xproto font-0xproto-nerd-font font-monaspace
