function config --wraps='usr/bin/git --git-dir=/home/gabriel/.cfg/ --work-tree=/home/gabriel' --wraps='/usr/bin/git --git-dir=/home/gabriel/.cfg/ --work-tree=/home/gabriel' --description 'alias config=/usr/bin/git --git-dir=/home/gabriel/.cfg/ --work-tree=/home/gabriel'
  /usr/bin/git --git-dir=/home/gabriel/.cfg/ --work-tree=/home/gabriel $argv; 
end
