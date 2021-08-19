#!/bin/bash

set -e
utilhome=$(pwd)
source ${utilhome}/tools/lib/default.sh

if [ $# != 1 ]; then
	echo Error: no branch name
	exit 1
fi

branch=$1
script_in_server="cd /home"
script_in_server+=" && sudo -u isucon git --git-dir=${server_git_dir}/.git --work-tree=${server_git_dir} fetch origin"
script_in_server+=" && sudo -u isucon git --git-dir=${server_git_dir}/.git --work-tree=${server_git_dir} checkout ${branch}"
script_in_server+=" && sudo -u isucon git --git-dir=${server_git_dir}/.git --work-tree=${server_git_dir} pull origin ${branch}"

for remote_host in ${remote_hosts[@]}; do
	echo "-------------"
	echo "${remote_host}"
	ssh -t $remote_host $script_in_server
done
