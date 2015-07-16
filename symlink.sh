#!/bin/bash

########## Variables

dir=$HOME/dotfiles/prefs                    # dotfiles directory
olddir=$HOME/.dotfiles_old             # old dotfiles backup directory
files="vimrc vim tmux.conf gitconfig gitignore zshrc z.sh"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
      echo "Moving any existing dotfiles from ~ to $olddir"
      mv -f $HOME/.$file $olddir
      echo "Creating symlink to $file in home directory."
      ln -s $dir/$file $HOME/.$file
done
echo "Done symlinking dotfiles"
