#!/bin/bash

# Installer Ruby et Bundler
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv install 3.2.2 --skip-existing
rbenv global 3.2.2

# Vérifier l'installation
ruby -v
gem install bundler
bundle install
