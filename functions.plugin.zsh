############### AUTO RUN NVM USE AND CHECK STATUS ###############
function cd() {
  builtin cd "$@"
  
  if [[ -f .nvmrc ]]; then
    runNVMinstall
  fi

  if [[ -e .git ]]; then
    gst
  fi
  
  ls -a
}

function evalWrapper(){
  eval "$@"
}

function runNVMinstall() {
  useMessage=$(nvm use 2>&1)
  installedPattern='Now using node v'
  uninstalledPattern='nvm install [0-9.]+'

  if [[ $useMessage =~ $uninstalledPattern ]]; then
    evalWrapper ${BASH_REMATCH[0]}
  fi
}

function deleteSwapFiles(){
  setopt rm_star_silent
  rm -f /Users/dwright/.local/state/nvim/swap/*
  unsetopt rm_star_silent
  echo "******************** SWAP FILES DELETED ***********************"
}

############### GET A NEW REPO OR MASTER BRANCH SETUP OR BROUGHT TO BASELINE ###############
function gsetup(){
    setopt KSH_ARRAYS BASH_REMATCH
    git reset --hard origin/$(echo $(git branch --show-current))
    git clean -f -d
    gfa
    gcm
    git pull origin $(git_main_branch)
    deleteSwapFiles

    exists=`git show-ref refs/heads/bump`
    
    if [ -n "$exists" ]; then
        git branch -D bump
    fi
    
    if [[ -f .nvmrc ]]; then
       runNVMinstall 
    fi

    if [[ -f package-lock.json ]]; then
    	npm ci
    elif [[ -f package.json ]]; then
	    npm i
    else
        echo "*************** NO PACKAGE.JSON FILES PRESENT ***************"
	echo "Are you sure you're in a node.js app?"
    fi
    unsetopt KSH_ARRAYS BASH_REMATCH
}

############### PULL MAIN FROM ORIGIN ###############
function gpm(){
    git pull origin $(git_main_branch)
}

############### DELETE MULTIPLE GIT BRANCHES BY A COMMON PATTERN ############### 
function gdel(){
    git branch | grep $1 | xargs git branch -D
}

############### PULL CURRENT BRANCH FROM ORIGIN ###############
function gpull(){
    git pull origin $(echo $(git branch --show-current))
}

############### PUSH CURRENT BRANCH TO ORIGIN ############### 
function gpush(){
  git push origin $(echo $(git branch --show-current)) $@
}

############### GREP WRAPPER ###############
# NOTE: R = recursive, l = list files (don't show text), i = ignorecase, & exclude node_modules from search
function Find(){
    args=''
    index=0
    for arg in $@; do
      if [ $index = 0 ]; then
        args+=${arg}
      else
        args+="\|${arg}"
      fi
      index+=1
    done

    grep $args -Rli --exclude-dir=node_modules --exclude-dir=dist --exclude-dir=build
}

############### K8s ###############
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
