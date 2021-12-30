#!/bin/bash

# ----------------------------------------------------
# Setup
# 
# Requirements: 
#     * git
#     * mail address set to enlironment variable SETUP_EMAIL
# 
# cannot execute... とか言われたら直接インストーラ叩くよろし
# ----------------------------------------------------

#
# Variables
#

DOWNLOAD_PATH=$HOMR
echo "SETUP_EMAIL: $SETUP_EMAIL"


# 
# Run setting
# 

# git
cat <<EOF > ~/gitignore_global
#ignore thumbnails created by windows
Thumbs.db

#Ignore files generate by Visual Studio
*.obj
*.exe
*.pdb
*.user
*.aps
*.pch
*.vspscc
*_i.c
*_p.c
*.ncb
*.suo
*.tlb
*.tlh
*.bak
*.cache
*.ilk
*.log
*.dll
*.lib
*.sbr
EOF

cat <<EOF > ~/.gitconfig
[credential]
        helper = wincred
[core]
        autocrlf = false
        excludesfile = gitignore_global
        editor = vi
[push]
        default = upstream
[gui]
        encoding = utf-8
[user]
        name = alllllllez_c
        email = $SETUP_EMAIL
EOF


# ssh 
mkdir -p ~/.ssh/github/
echo "" | ssh-keygen -t rsa -b 4096 -C "$SETUP_EMAIL" -f ~/.ssh/github/github_ssh

cat <<EOF > ~/.ssh/config 
Host github github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github/github_ssh
EOF

# 確認用(それぞれ公開鍵を登録してからどうぞ)
# ssh -T git@github.com

# vim plugins
# Deno
curl -fsSL https://deno.land/x/install/install.sh | sh
# Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# run :PlugInstall on Vim.
