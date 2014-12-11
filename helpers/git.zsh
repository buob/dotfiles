function _git_in_repo {
  git rev-parse --is-inside-work-tree > /dev/null 2>&1; echo $?
}

function _git_get_repo {
  git rev-parse --show-toplevel 2>/dev/null | xargs basename
}

function _git_get_path {
  git rev-parse --show-prefix 2>/dev/null | sed -e 's|/$||' -e '/^./ s|^|/|'
}

function _git_get_branch {
  git symbolic-ref --short HEAD 2>/dev/null
}

function _git_any_unstaged {
  git diff-index --quiet --cached HEAD >/dev/null 2>&1; test $? -eq 0 && echo 1 || echo 0
}

function _git_any_uncommited {
  git diff-files --quiet >/dev/null 2>&1; test $? -eq 0 && echo 1 || echo 0
}

function _git_any_untracked {
  git ls-files --other --error-unmatch --exclude-standard . >/dev/null 2>&1; echo $?
}
