function prompt_streamplatformenv(){
  [[ -n ${SPF_CONTEXT} ]] || return
  p10k segment -s SPF -f blue -t "[${SPF_CONTEXT}]"
 }

 # disables prompt mangling in activatecontext.sh
 export SPF_ENV_DISABLE_PROMPT=1

 : "${SPF_HOME:=$HOME/code/coz/streamplatform}"

 alias spf-dev="source $SPF_HOME/manage/scripts/activate-dev"
 alias spf-test="source $SPF_HOME/manage/scripts/activate-test"