#!/usr/bin/env zsh

function gpr() {
    local PR_TEMPLATE
    local BRANCH_DETAIL
    local PR_TITLE
    local LABELS=()
    local DRAFT
    local BASE_BRANCH="main" # Default base branch

    PR_TEMPLATE=$(git rev-parse --show-toplevel)/.github/pull_request_template.md
    BRANCH_DETAIL=$(git branch --show-current | cut -d '/' -f2 | cut -d '-' -f1,2)
    PR_TITLE="fix: [$BRANCH_DETAIL] $1"
    shift

    while (( $# )); do
        case "$1" in
            -b)
                BASE_BRANCH="$2"
                shift 2
                ;;
            -s)
                LABELS+=("-l" "Ship")
                PR_TITLE="$PR_TITLE [SHIP]"
                shift
                ;;
            -n)
                LABELS+=("-l" "No Auto Merge")
                shift
                ;;
            -d)
                DRAFT="--draft"
                shift
                ;;
            *)
                echo "Invalid option $1"
                return 1
                ;;
        esac
    done

    gh pr create -B "$BASE_BRANCH" -F "$PR_TEMPLATE" --title "$PR_TITLE" $DRAFT "${LABELS[@]}" -a "@me"
}
