############### ZSH ###############
# Path to your oh-my-zsh installation.
export ZSH="/Users/dwright/.oh-my-zsh"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
# TODO: checkout other plugins 

ZSH_THEME="agnoster"

source $ZSH/oh-my-zsh.sh
# ------------------------------------------------------------ User configuration ------------------------------------------------------------

############### RENAME ITERM2 TABS TO CURRENT DIR ###############
DISABLE_AUTO_TITLE="true"

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

############### NVM SETUP ###############
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

############### BUN ###############
[ -s "/Users/dwright/.bun/_bun" ] && source "/Users/dwright/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

############### CUSTOM FUNCTIONS ###############

############### AUTO RUN NVM USE AND CHECK STATUS ###############
function cd() {
  builtin cd "$@"
  
  if [[ -f .nvmrc ]]
  then
     nvm use
  fi

  if [[ -e .git ]]
  then
    gst
   fi
  ls -a
}

############### GET A NEW REPO OR MASTER BRANCH SETUP ###############
function gsetup(){
	gcm
	git fetch origin
    git reset --hard origin/$(echo $(git branch --show-current))
    git clean -f -d

	exists=`git show-ref refs/heads/bump`
    if [ -n "$exists" ]; then
        git branch -D bump
    fi
	if [[ -f .nvmrc ]]; then
		nvm use
	fi

	if [[ -f package-lock.json ]]; then
		npm ci
	elif [[ -f package.json ]]; then
		npm i
	else
		echo "*************** NO PACKAGE.JSON FILES PRESENT ***************"
		echo "Are you sure you're in a node.js app?"
	fi
}

############### DELETE MULTIPLE GIT BRANCHES BY A COMMON PATTERN ############### 
function gdel(){
	git branch | grep $1 | xargs git branch -D
}

############### PULL CURRENT BRANCH FROM ORIGIN ###############
function gpullcurrent(){
	git pull origin $(echo $(git branch --show-current))
}

############### PUSH CURRENT BRANCH TO ORIGIN ############### 
function gpushcurrent(){
    git push origin $(echo $(git branch --show-current))
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

    grep $args -Rli --exclude-dir=node_modules 
}

############### K8s ###############
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)


