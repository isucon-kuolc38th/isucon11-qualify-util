#!/bin/bash

set -e
utilhome=$(pwd)
source ${utilhome}/tools/lib/default.sh

for remote_host in ${remote_hosts[@]}; do
	echo "-------------"
	echo "${remote_host}"

	script_in_server="cd /home"
	script_in_server+=" && export PATH=\$PATH:/home/isucon/local/go/bin"
	script_in_server+=" && source /home/isucon/isuumo/${remote_host}/restart.sh"
	# script_in_server+=" && sudo -u isucon bash ${server_git_dir}/${remote_host}/restart.sh"

	ssh -t $remote_host $script_in_server
done
