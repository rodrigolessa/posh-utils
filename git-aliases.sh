[alias] chs = !git checkout $1 && git status

#alias d = !git diff --name-only HEAD^

#git config --global alias.d 'diff --name-only HEAD^'

#git config --global alias.c 'add . && git commit -m '

# git config --global alias.unstage 'reset HEAD --'

# git config --global alias.last 'log -1 HEAD'

# c = "!git add -A && git commit -m "

# amend = !git add -A && git commit --amend --no-edit

# p = !git push origin $(git rev-parse --abbrev-ref HEAD)

# p = !git push origin $(git rev-parse --abbrev-ref HEAD)

# f = !git fetch --all && git rebase origin/master

# n = !git checkout -b

# git diff --name-only master

# git diff --name-only bug/8741..master

# git archive -o pacote.zip HEAD $(git diff --name-only bug/8741..master)

## 2.3 Git Basics - Viewing the Commit History

## https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History

# git log --pretty=format:"%h - %an, %ar : %s" --name-only

# git log --pretty=format:"%h - %an, %ar : %s"

# my_alias = "!f() { 〈your complex command〉 }; f"

# reset = !git reset --hard HEAD && git clean -qfdx

# ra = "!f() { git remote add $1 https://bitbucket.org/$2.git; }; f"

# d = "!f() { git diff --name-only @r..master; }; f"
# d = "!f() { git diff --name-only HEAD^; }; f"

## 0.0 Squash commits into one with Git

## https://www.internalpointers.com/post/squash-commits-into-one-git

# git rebase --interactive HEAD~[N]

# git rebase --interactive [commit-hash]
