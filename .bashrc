function parse_git_branch {
  echo -n $(git branch --no-color 2>/dev/null | awk -v out=$1 '/^*/ { if(out=="") print $2; else print out}')
  }
  function parse_git_remote {
    echo -n $(git status 2>/dev/null | awk -v out=$1 '/# Your branch is / { if(out=="") print $5; else print out }')
}


export PS1='\[\033[01;35m\]\u\[\033[01;34m\]::\[\033[01;31m\]\h \[\033[00;34m\]{ \[\033[01;34m\]\w \[\033[00;34m\] $(parse_git_branch ):$(parse_git_branch)$(parse_git_remote "(")$(parse_git_remote)$(parse_git_remote ")") }\[\033[01;32m\]-> \[\033[00m\]'

export SVN_EDITOR=vim

alias la='ls -a'
alias ga='git add'
alias gp='git push'
alias gm='git commit -m'
alias gme='git commit --allow-empty -m'
alias gs='git status'
alias gpl='git pull'
alias gpu='git push'
alias gb='git branch'
alias gbr='git branch -r'
alias gco='git checkout'
alias gs='git status'
alias gpuo='gpu origin'

pyclean () {
    find . -name "*.pyc" -exec rm -rf {} \;
    find . -name "__pycache__" -exec rm -rf {} \;
}
