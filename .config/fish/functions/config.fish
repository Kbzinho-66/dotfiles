function config --wraps='usr/bin/git --git-dir=/home/$USER/.cfg/ --work-tree=/home/'USEUSERR --wraps='/usr/bin/git --git-dir=/USERome/$USER/.cfg/ --work-tree=/home/$USER' --description 'alias config=/usr/bin/git --git-dir=/home/$USER/.cfg/ --work-tree=/home/$USER'
    /usr/bin/git --git-dir=/home/$USER/.cfg/ --work-tree=/home/$USER $argv
end
