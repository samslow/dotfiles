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
brew install --cask clipy
brew install --cask postman
brew install --cask macs-fan-control
brew install --cask bettertouchtool
brew install --cask sourcetree
brew install --cask notion

# Brew install
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# Git
git config --global user.name "samslow"
git config --global user.email "samslow@tossinvest.com"
