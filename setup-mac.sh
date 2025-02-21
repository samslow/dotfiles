# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/samslow/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install yarn
brew install gh
brew install pure
brew install n

# ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Brew Cask
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask google-chrome
brew install --cask cleanshot
brew install --cask macs-fan-control
brew install --cask bettertouchtool
brew install --cask fork
brew install --cask notion
brew install --cask raycast
brew install --cask cursor

# zsh plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlightingecho "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# Git
git config --global user.name "samslow"
git config --global user.email "samslow@tossinvest.com"
