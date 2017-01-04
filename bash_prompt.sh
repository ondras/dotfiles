#!/bin/bash
#
# DESCRIPTION:
#
#   Set the bash prompt according to:
#    * the branch/status of the current Git or Mercurial repository
#    * the return value of the previous command
#
# USAGE:
#
#   1. Save this file as ~/.bash_prompt
#   2. Add the following line to the end of your ~/.bashrc or ~/.bash_profile:
#        . ~/.bash_prompt
#
# LINEAGE:
#
#   https://gist.github.com/2959821
#   https://gist.github.com/31967
#   https://gist.github.com/2394150

# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Detect whether the current directory is a Mercurial repository.
function is_mercurial_repository {
  branch=$(hg branch 2>/dev/null)
  if [ -n "${branch}" ]; then
    return 0
  else
    return 1
  fi
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working tree clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${LIGHT_RED}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # Get the name of the branch.
  branch_pattern="^(#\s+)?On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[2]}
  else 
    branch="?"
  fi

  # Set the final branch string.
  BRANCH="${state}(git:${branch})${remote}${COLOR_NONE} "
}

# Determine the branch/state information for this Mercurial repository.
function set_mercurial_branch {
  # Get the name of the branch.
  branch=$(hg branch 2>/dev/null)
  # Default state
  state="${GREEN}"

  if [ -n "${branch}" ]; then
    # Capture the output of the "hg status" command.
    hg_status="$(hg status | wc -l)"

    # Set color based on clean/staged/dirty.
    if [ "${hg_status}" -ne "0" ]; then
      state="${RED}"
    fi
  else
    branch="?"
  fi

  bookmarks=$(hg summary | grep "^bookmarks" | sed -e "s/^bookmarks: //" -e "s/ /,/")
  if [ -n "${bookmarks}" ]; then
    bookmarks="/${bookmarks}"
  fi

  # Set the final branch string.
  BRANCH="${state}(hg:${branch}$bookmarks)${COLOR_NONE} "
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="\$"
  else
      PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
  fi
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  elif is_mercurial_repository ; then 
    set_mercurial_branch
  else
    BRANCH=''
  fi

  echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"

  # Set the bash prompt variable.
  PS1="${GREEN}\u@\h ${GREEN}${YELLOW}\w${COLOR_NONE} ${BRANCH}${PROMPT_SYMBOL} "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
