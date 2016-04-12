#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/.dotfiles
############################

olddir=~/.dotfiles_bak
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir $olddir
echo "...done"

for file in $(ls -A); do
  if [ $file == ".git" ] || 
     [ $file == "README.md" ] || 
     [ $file == "makesymlinks.sh" ] || 
     [ $file == ".gitignore" ] || # If the current file is one of these blacklisted files,
     [ -h $file ] ; # or if the symlink already exists, skip this file.
  then
    continue
  fi

  echo "Moving $file from ~ to $olddir"
  mv ~/$file $olddir/
  echo "Creating symlink to $file in home directory."
  ln -s $PWD/$file ~/$file
done
