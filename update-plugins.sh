#! /bin/bash
cd ~/.vim/
git submodule foreach git checkout master
git submodule foreach git pull
