# PERSONAL
alias screens='bash /Users/dwright/screens.sh'

# WORK
alias mongod='mongod --dbpath=/Users/dwright/data/db'
alias mongods='mongod --config /usr/local/etc/mongod.conf --fork'

# AWSUDO FAIRHAIR-WEB
alias onfhdev='awsudo -u fhw_dev'
alias onfhstaging='awsudo -u fhw_staging'
alias onfhprod='awsudo -u fhw_prod'

# K8s
alias proxy='open -a Google\ Chrome.app http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/\#/overview\?namespace\=default && kubectl proxy'

