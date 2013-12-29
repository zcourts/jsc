#!/bin/sh
action=$1
cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$1" ]
then #if argument is empty default to publish
   action="publish"
fi
shift #effectively get rid of first argument (the action)
sh ${cur_dir}/jsc_${action}.sh "$@"