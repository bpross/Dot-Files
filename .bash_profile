#My .bash_profile

#Get aliases and functions
source ~/.bashrc


##
# Your previous /Users/benjaminross/.bash_profile file was backed up as /Users/benjaminross/.bash_profile.macports-saved_2015-07-07_at_14:06:49
##

# MacPorts Installer addition on 2015-07-07_at_14:06:49: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/Users/benjaminross/bin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash

    # Need this for aliases
    __git_complete ga _git_add
    __git_complete gp _git_push
    __git_complete gs _git_status
    __git_complete gpl _git_pull
    __git_complete gb _git_branch
    __git_complete gco _git_checkout
fi
