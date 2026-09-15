# dotfiles

macOS 터미널 환경 백업. 새 맥에서 한 줄로 복원합니다.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/samslow/dotfiles/main/install.sh)"
```

`install.sh` 는 여러 번 실행해도 안전하며 다음을 수행합니다.

1. Homebrew 설치 → `Brewfile` 로 CLI·앱 일괄 설치 (`--no-brew` 로 건너뛰기)
2. oh-my-zsh + `zsh-autosuggestions`, `zsh-syntax-highlighting` 설치
3. `~/.zshrc`, `~/.zshenv`, `~/.zprofile`, `~/.gitconfig`, `~/.tool-versions` 를 이 리포로 심볼릭 링크 (기존 파일은 `~/.dotfiles-backup/` 로 백업)
4. `~/.zshrc.local` 이 없으면 템플릿 생성 (비밀값은 여기에)
5. iTerm2 가 `~/.dotfiles/iterm2` 폴더에서 설정을 읽도록 지정

## 구조

```
.
├── install.sh                 # 설치 스크립트
├── Brewfile                   # brew / cask / npm 패키지 목록
├── zsh/
│   ├── zshrc                  # → ~/.zshrc
│   ├── zshenv                 # → ~/.zshenv   (PATH 등)
│   ├── zprofile               # → ~/.zprofile (brew shellenv)
│   ├── aliases.zsh            # alias 모음
│   ├── functions/*.zsh        # 셸 함수 (gsd, gpr …)
│   └── zshrc.local.example    # ~/.zshrc.local 템플릿
├── git/gitconfig              # → ~/.gitconfig
├── asdf/tool-versions         # → ~/.tool-versions
├── iterm2/
│   ├── com.googlecode.iterm2.plist   # iTerm2 설정 (Load preferences from custom folder)
│   └── Samslow-profile.json          # 기본 프로필 (읽기용 참고)
├── bettertouchtool/Default.bttpreset # BTT 프리셋 (수동 import)
└── legacy/                    # 예전 회사에서 쓰던 함수·iTerm 프리셋 (보관용)
```

## 비밀값

토큰·API 키는 **절대 리포에 넣지 않습니다.** `~/.zshrc.local` 에 두면 `zshrc` 마지막에 자동으로 로드됩니다. (`*.local` 은 `.gitignore` 처리됨)

```bash
cp ~/.dotfiles/zsh/zshrc.local.example ~/.zshrc.local && chmod 600 ~/.zshrc.local
```

## 갱신

| 무엇을                | 어떻게                                                                 |
| --------------------- | ---------------------------------------------------------------------- |
| alias / 함수 / zshrc  | `~/.dotfiles/zsh/` 아래 파일을 직접 수정 (심볼릭 링크라 즉시 반영)     |
| brew 패키지 목록      | `brew bundle dump --file=~/.dotfiles/Brewfile --force --no-vscode`     |
| iTerm2 설정           | iTerm2 가 `iterm2/` 폴더에 자동 저장 (Preferences → General → Settings 에서 "Save changes: Automatically") |
| BetterTouchTool       | BTT → Presets → Export 로 `bettertouchtool/Default.bttpreset` 덮어쓰기 |

수정 후 `cd ~/.dotfiles && git add -A && git commit -m "..." && git push`
