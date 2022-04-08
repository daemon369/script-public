#!/bin/sh

# rebase when pull
git config --global pull.rebase true
# gpg signing for commit and tag
git config --global commit.gpgSign true
git config --global tag.gpgSign true
# alias
git config --global alias.a add
git config --global alias.b branch
git config --global alias.bl "branch -l"
git config --global alias.br "branch -r"
git config --global alias.c commit
git config --global alias.cm "commit -m"
git config --global alias.co checkout
git config --global alias.cp cherry-pick
git config --global alias.cpx "cherry-pick -x"
git config --global alias.d diff
git config --global alias.f "fetch --prune"
git config --global alias.p "pull --rebase"
git config --global alias.s status
git config --global alias.st stash
git config --global alias.stp "stash pop"
git config --global alias.sw switch
