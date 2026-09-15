#!/usr/bin/env bash
#
# samslow/dotfiles 설치 스크립트 (macOS)
#
#   새 맥:           bash -c "$(curl -fsSL https://raw.githubusercontent.com/samslow/dotfiles/main/install.sh)"
#   clone 해둔 경우:  ~/.dotfiles/install.sh [--no-brew]
#
# 여러 번 실행해도 안전합니다. 기존 파일은 ~/.dotfiles-backup/<시각>/ 으로 옮긴 뒤 심볼릭 링크를 겁니다.

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
REPO_URL="https://github.com/samslow/dotfiles.git"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
SKIP_BREW=0

for arg in "$@"; do
  case "$arg" in
    --no-brew) SKIP_BREW=1 ;;
    *) echo "알 수 없는 옵션: $arg" >&2; exit 1 ;;
  esac
done

info() { printf '\n\033[1;34m==>\033[0m \033[1m%s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*"; }

# ---------------------------------------------------------------- Homebrew
brew_bin() {
  local b
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x $b ]] && { echo "$b"; return 0; }
  done
  return 1
}

if ! BREW="$(brew_bin)"; then
  info "Homebrew 설치 (Xcode Command Line Tools 포함)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  BREW="$(brew_bin)"
fi
eval "$("$BREW" shellenv)"

# ---------------------------------------------------------------- dotfiles repo
if [[ ! -d $DOTFILES/.git ]]; then
  info "dotfiles clone → $DOTFILES"
  git clone "$REPO_URL" "$DOTFILES"
fi

# ---------------------------------------------------------------- 패키지
if [[ $SKIP_BREW -eq 0 ]]; then
  info "brew bundle (Brewfile)"
  brew bundle --file="$DOTFILES/Brewfile" || warn "일부 패키지 설치에 실패했습니다. 위 로그를 확인하세요."
fi

# ---------------------------------------------------------------- oh-my-zsh
if [[ ! -d $HOME/.oh-my-zsh ]]; then
  info "oh-my-zsh 설치"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone_plugin() {
  [[ -d $ZSH_CUSTOM/plugins/$1 ]] || git clone --depth=1 "$2" "$ZSH_CUSTOM/plugins/$1"
}

info "zsh 플러그인"
clone_plugin zsh-autosuggestions     https://github.com/zsh-users/zsh-autosuggestions
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting

# ---------------------------------------------------------------- 심볼릭 링크
link() {
  local src="$DOTFILES/$1" dst="$2"
  if [[ -L $dst && "$(readlink "$dst")" == "$src" ]]; then
    echo "  ok      $dst"
    return
  fi
  if [[ -e $dst || -L $dst ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "  backup  $dst → $BACKUP_DIR/"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "  link    $dst → $src"
}

info "심볼릭 링크"
link zsh/zshrc          "$HOME/.zshrc"
link zsh/zshenv         "$HOME/.zshenv"
link zsh/zprofile       "$HOME/.zprofile"
link git/gitconfig      "$HOME/.gitconfig"
link asdf/tool-versions "$HOME/.tool-versions"

# ---------------------------------------------------------------- 비밀값 파일
if [[ ! -f $HOME/.zshrc.local ]]; then
  cp "$DOTFILES/zsh/zshrc.local.example" "$HOME/.zshrc.local"
  chmod 600 "$HOME/.zshrc.local"
  warn "~/.zshrc.local 을 만들었습니다. 토큰 등 비밀값을 채워 넣으세요."
fi

# ---------------------------------------------------------------- iTerm2
info "iTerm2 설정 폴더 → $DOTFILES/iterm2"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

info "완료! 새 터미널을 열거나 'exec zsh' 를 실행하세요. (iTerm2 는 재시작 후 설정이 적용됩니다)"
