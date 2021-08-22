#!/bin/bash

set -e
utilhome=$(pwd)
source ${utilhome}/tools/lib/default.sh

if [ $# != 1 ]; then
	profile_time_length=90
else
	profile_time_length=$1
fi

source ./tools/clear_logs.sh

echo "watch for ${profile_time_length} [s]"
# curl -s http://${app_ip}/debug/pprof/profile?seconds=${profile_time_length} >./pprof/cpu.pprof &
# curl -s http://${app_ip}/debug/pprof/heap?seconds=${profile_time_length} >./pprof/memory.pprof &
sleep $profile_time_length
echo "finish watching"

source ./tools/collect_logs.sh

# # pprofの結果や変数$log_idが必要なため，このコマンドはcollect_logs.shの後である必要がある
# echo "hosting pprof"
# pkill -f pprof
# nohup go tool pprof -http=localhost:8081 ${utilhome}/log/${log_id}/pprof/cpu.pprof </dev/null &>/dev/null &
# nohup go tool pprof -http=localhost:8082 ${utilhome}/log/${log_id}/pprof/memory.pprof </dev/null &>/dev/null &
# echo "pprof is shown at:"
# echo "http://${app_ip}:81"
# echo "http://${app_ip}:82"
