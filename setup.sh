#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

set -e

########## Configuration

dir=$HOME/dotfiles                    # dotfiles directory
olddir=$HOME/dotfiles_old             # old dotfiles backup directory
files=".vimrc .vim .zshrc .zlogin .zsh .gvimrc"    # list of files/folders to symlink in homedir

config_dir=$HOME/.config
config_olddir=$olddir/.config
config_files="starship.toml"

plugins="https://github.com/lukechilds/zsh-better-npm-completion.git https://github.com/lukechilds/zsh-nvm.git"
plugin_dir=$dir/.zsh/plugins

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

echo "Setting up fzf"
if [[ $platform == 'Darwin' ]]; then
    which -s brew
    $(brew --prefix)/opt/fzf/install --bin
else 
    echo "Please install fzf manually!"
fi

# install zsh-nvm plugin
echo "Installing plugins..."
cd $plugin_dir
for plugin in $plugins; do
    git clone $plugin
done

cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file $olddir || true
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

# move any existing config files to $config_olddir, then create symlinks for all files in $config_dir
for file in $config_files; do 
    echo "Moving any existing config files from ${config_dir} to ${config_olddir}"
    mv $config_dir/$file $config_olddir/$file || true
    echo "Creating symlink to $file in $config_dir"
    ln -s $dir/.config/$file $config_dir/$file
done

function install_zsh {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone http://github.com/michaeljsmalley/oh-my-zsh.git
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install zsh
        install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        if brew install zsh; then
            install_zsh
        else
            echo "Please install zsh, then re-run this script!"
            exit
        fi
    fi
fi
}

install_zsh
