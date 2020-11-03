#!/bin/bash

# URL that contains all setup files
#URL="https://raw.githubusercontent.com/dandrewgarvin/dotfiles/master" # published
URL="." # localhost

# Install Homebrew
if [ $(which brew) == "brew not found" ]
then
  echo brew version is: $(which brew)
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "brew already installed. skipping."
fi

# Install oh-my-zsh
if [ $(which zsh) == "zsh not found" ]
then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed. skipping."
fi

# Run Brewfile from URL
if [ $URL == "." ]
then
  brew bundle --file="${URL}/config/Brewfile"
else
  curl "${URL}/config/Brewfile" | brew bundle --file=-
fi

echo -e "\n\nBrewfile installed!\n\n"

# setup zshrc file

if [ -f ~/.zshrc ]
then
  rm ~/.zshrc
fi

echo "export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh" >> ~/.zshrc

echo "zshrc file created"

# install nvm and node (latest)
source ~/.zshrc

nvm install node
nvm use node

# install rvm and ruby (2.5.7)
\curl -sSL https://get.rvm.io | bash -s stable --ruby

rvm -v
