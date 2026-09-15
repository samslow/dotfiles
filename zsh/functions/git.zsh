unalias gsd 2>/dev/null

gsd() {
  local b="feat/DEL-$1"

  git fetch origin main
  git switch -c "$b" origin/main 2>/dev/null || git switch "$b"
  git push -u origin "$b"

  print "✅ $b"
}

unalias gpr 2>/dev/null
# gpr - GitHub Pull Request 생성 단축 커맨드
# 사용법: gpr "PR 제목"
# 현재 브랜치를 리모트에 푸시하고 gh pr create로 PR을 생성합니다.
gpr() {
  if [ -z "$1" ]; then
    echo "사용법: gpr \"PR 제목\""
    return 1
  fi

  local title="$*"
  local branch=$(git rev-parse --abbrev-ref HEAD)

  if [ "$branch" = "main" ] || [ "$branch" = "master" ] || [ "$branch" = "develop" ]; then
    echo "⚠️  현재 $branch 브랜치에서는 PR을 생성할 수 없습니다. 피처 브랜치에서 실행해주세요."
    return 1
  fi

  echo "🚀 리모트에 브랜치 푸시 중... ($branch)"
  git push -u origin "$branch" || return 1

  echo "📝 PR 생성 중..."
  gh pr create --title "$title" --fill

  if [ $? -eq 0 ]; then
    echo "✅ PR이 성공적으로 생성되었습니다!"
  else
    echo "❌ PR 생성에 실패했습니다."
    return 1
  fi
}
