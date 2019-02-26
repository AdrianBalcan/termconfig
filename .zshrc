#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>


# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export PATH="$PATH:/Users/adrianbalcan/istio-0.2.12/bin"

source /usr/local/bin/aws_zsh_completer.sh

# Customize to your needs...

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/adrianbalcan/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/adrianbalcan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/adrianbalcan/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/adrianbalcan/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/opt/curl/bin:$PATH"

declare -x VISUAL=vim
declare -x EDITOR=vim
declare -x PATH="/usr/local/Cellar/vim/8.0.1500/bin/vim:$PATH"
alias k="kubectl"
alias t="terraform"
alias khelm="~/.kube/khelm.py get images"
alias awsblu="yes | cp ~/.aws/blugento.config ~/.aws/config && yes | cp ~/.aws/blugento.credentials ~/.aws/credentials"
function kncos {
  gcloud container clusters get-credentials $( cat ~/.kube/ncos | fzf )
}
alias kblu="export KOPS_STATE_STORE=s3://kube01-kops && kops export kubecfg kube01.blugento.eu"
alias k_dev_global="cp ~/.kube/dev-global ~/.kube/config"
alias k_prod_global="cp ~/.kube/prod-global ~/.kube/config"
alias myshell="kubectl run my-shell-adrian --rm -i --tty --image ubuntu -- bash"
export PATH="/usr/local/opt/curl/bin:$PATH"
function kconf {
  cp ~/.kube/$(ls ~/.kube | grep .conf | fzf) ~/.kube/config
}
function kdep {
  kubectl set image deployment/$1 $1=gcr.io/camversity-183908/$1:$2 --record=true
}
function kpods {
    kubectl get pods | less
}
function kpod {
    kubectl get pods | fzf
}
function kexec {
  if [ -z $1 ]
  then
    NS=$(kubectl get ns | fzf | awk "{print \$1}")
  else
    NS=$1
  fi
  POD=$(kubectl get pods -n $NS | fzf | awk "{print \$1}")
  CONTAINERS=$(kubectl get pods $POD -n $NS -o jsonpath='{.spec.containers[*].name}')
  COUNT_CONTAINERS=$(echo $CONTAINERS | wc -w | tr -d ' ')
  if [ "$COUNT_CONTAINERS" -gt "1" ]
  then
    kubectl exec -it $POD -c $(echo $CONTAINERS | tr " " "\n" | fzf) -n $NS -- sh
  else
    kubectl exec -it $POD -n $NS -- sh
  fi
}
function klogs {
  if [ -z $1 ]
  then
    NS=$(kubectl get ns | fzf | awk "{print \$1}")
  else
    NS=$1
  fi
  POD=$(kubectl get pods -n $NS | fzf | awk "{print \$1}")
  CONTAINERS=$(kubectl get pod $POD -n $NS -o jsonpath='{.spec.containers[*].name}')
  INITCONTAINERS=$(kubectl get pod $POD -n $NS -o jsonpath='{.spec.initContainers[*].name}')
  COUNT_CONTAINERS=$(echo $CONTAINERS | wc -w | tr -d ' ')
  if [ "$COUNT_CONTAINERS" -gt "1" ]
  then
    kubectl logs $POD -c $(echo -e "$INITCONTAINERS\n$CONTAINERS" | tr " " "\n" | fzf) -n $NS -f
  else
    kubectl logs $POD -n $NS -f
  fi
}
function kdel {
  NS=$(kubectl get ns | fzf | awk "{print \$1}")
  POD=$(kubectl get pods -n $NS | fzf | awk "{print \$1}")
  kubectl delete pod $POD -n $NS
}
function kdescribe {
  if [ -z $1 ]
  then
    NS=$(kubectl get ns | fzf | awk "{print \$1}")
  else
    NS=$1
  fi
  POD=$(kubectl get pods -n $NS | fzf | awk "{print \$1}")
  kubectl describe pod $POD -n $NS
}
function kdescribepod {
  kubectl describe $(kubectl get pods -o name | fzf)
}
function kdescribenode {
  kubectl describe $(kubectl get nodes -o name | fzf)
}
function kedit {
  NS=$(kubectl get ns | fzf | awk "{print \$1}")
  DEPLOY=$(kubectl get deploy -n $NS | fzf | awk "{print \$1}")
  kubectl edit deploy $DEPLOY -n $NS
}
function kimg {
  NS=$(kubectl get ns | fzf | awk "{print \$1}")
  DEPLOY=$(kubectl get deploy -n $NS | fzf | awk "{print \$1}")
  echo "initContainers:"
  kubectl get deployments $DEPLOY -n $NS -o json | jq .spec.template.spec.initContainers | grep '"image":'
  echo "Containers:"
  kubectl get deployments $DEPLOY -n $NS -o json | jq .spec.template.spec.containers | grep '"image":'
}
function wkp {
  NS=$(kubectl get ns | fzf | awk "{print \$1}")
  watch "kubectl get pods -o wide -n $NS && printf '%20s\n' | tr ' ' - && kubectl get hpa -n $NS"
}
#  kubectl get pods --field-selector=metadata.name=
#  kubectl get pods POD_NAME_HERE -o jsonpath='{.spec.containers[*].name}'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh