#!/bin/bash

ENV=$1
ENV2=$2


if [[ "$ENV" == '' ]]; then
   echo orig: $SSH_ORIGINAL_COMMAND
   ENV=`echo $SSH_ORIGINAL_COMMAND|awk -F' ' '{print $2}'`
   ENV2=`echo $SSH_ORIGINAL_COMMAND|awk -F' ' '{print $3}'`
fi

if [[ ! "$ENV" =~ ^[A-Za-z0-9_]+$ ]]; then  
   echo "$ENV not allowed, only [A-Za-z0-9_]+ allowed as environment"
   exit 1
fi

if [[ ! ( "$ENV2" == '' || "$ENV2" == '--puppetfile' ) ]]; then
   echo "only --puppetfile allowed as second argument"
   exit 1
fi

if [[ $ENV == 'all' ]]; then
   ENV=''
fi

(cd /etc/puppet; r10k -v --config=r10k.yaml deploy environment $ENV $ENV2)

