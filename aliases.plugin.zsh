# PERSONAL
alias screens='bash /Users/dwright/screens.sh'

# WORK
alias mongod='mongod --dbpath=/Users/dwright/data/db'
alias mongods='mongod --config /usr/local/etc/mongod.conf --fork'

# AWSUME 
alias afd='awsume fh_dev'
alias afs='awsume fh_staging'
alias afp='awsume fh_production'

alias aid='awsume ia_development'
alias ais='awsume ia_staging'
alias aip='awsume ia_production'

alias acs='awsume cs_staging'
alias acp='awsume cs_production'

# K8s
alias kproxy='open -a Google\ Chrome.app http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/\#/overview\?namespace\=default && kubectl proxy'

# ZMV https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-zmv
alias zmv='noglob zmv'
alias zcp='zmv -C'
alias zln='zmv -L'
