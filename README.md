# めんどくさい #

**めんどくさい** is a public home (`~`) config directory with useful configs, scripts, cheat codes, shell libraries for Linux / Git Bash for every day.

## Installation ##

Just click and copy:

```bash
mkdir -p /home/alimektor/.config/mendokusai
git clone git@github.com:Alimektor/mendokusai.git
alias mendo='/usr/bin/git --git-dir=$HOME/.config/mendokusai/git --work-tree=$HOME'
mendo checkout
mendo config --local status.showUntrackedFiles no
mendo config --local core.filemode true
mendo config --local push.default current
echo "alias mendo='/usr/bin/git --git-dir=${HOME}/.config/mendokusai/git --work-tree=${HOME}'" >> $HOME/.bashrc
```

(Additional) For Windows Git Bash change `core.filemode`:

```bash
mendo config --local core.filemode false
```

Deal with merge conflict. I know it might be.

Now `mendo` is just a alias for this bare Git.

## Update ##

Just use:

```bash
mendo pull
```

and be happy!

## Links ##

- [Dotfiles: Best Way to Store in a Bare Git Repository on Atlassian](https://www.atlassian.com/git/tutorials/dotfiles)