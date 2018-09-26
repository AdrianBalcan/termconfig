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
alias awsblu="yes | cp ~/.aws/blugento.config ~/.aws/config && yes | cp ~/.aws/blugento.credentials ~/.aws/credentials"
alias awscamv="yes | cp ~/.aws/camv.config ~/.aws/config && yes | cp ~/.aws/camv.credentials ~/.aws/credentials"
alias gdev="gcloud config set project camversity-183908"
alias gprod="gcloud config set project camversity-prod"
alias ncos_qa="gcloud config set project jlr-dl-ncos-qa"
function kncos {
  gcloud container clusters get-credentials $( cat ~/.kube/ncos | fzf ) --project jlr-dl-ncos-qa
}
alias kdev="gcloud container clusters get-credentials dev --zone europe-west1-b --project camversity-183908"
alias kstaging="gcloud container clusters get-credentials staging --zone europe-west1-b --project camversity-183908"
alias kprod="gcloud container clusters get-credentials prod --zone us-east1-b --project camversity-prod"
alias kblu="export KOPS_STATE_STORE=s3://kube01-kops && kops export kubecfg kube01.blugento.eu"
alias kblu2="awsblu && export KOPS_STATE_STORE=s3://kube01-kops && kops export kubecfg kube02.blugento.eu"
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
function kfix {
  if [ -z $1 ]
  then
    NS=$(kubectl get ns | fzf | awk "{print \$1}")
  else
    NS=$1
  fi
  POD=$(kubectl get pods -n $NS | grep blugento | head -1 | awk "{print \$1}")
  kubectl exec -it $POD -c php -n $NS -- su -c "cp -rf /var/local/bg-pvc/bg-pvc-*/* /var/local/bg-pvc/"
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
  COUNT_CONTAINERS=$(echo $CONTAINERS | wc -w | tr -d ' ')
  if [ "$COUNT_CONTAINERS" -gt "1" ]
  then
    kubectl logs $POD -c $(echo $CONTAINERS | tr " " "\n" | fzf) -n $NS -f
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
function wkp {
  NS=$(kubectl get ns | fzf | awk "{print \$1}")
  watch "kubectl get pods -n $NS && printf '%20s\n' | tr ' ' - && kubectl get hpa -n $NS"
}
#  kubectl get pods --field-selector=metadata.name=
#  kubectl get pods POD_NAME_HERE -o jsonpath='{.spec.containers[*].name}'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
