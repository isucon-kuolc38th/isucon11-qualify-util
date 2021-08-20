#!/bin/bash

set -e
utilhome=$(pwd)
source ${utilhome}/tools/lib/default.sh

# リモートにsshして現在のコミットidをチェック
script_in_server="cd /home"
script_in_server+=" && sudo -u isucon git --git-dir=${server_git_dir}/.git --work-tree=${server_git_dir} rev-parse --short HEAD"
commit_id=$(ssh -t isucon1 $script_in_server | cut -c 1-7)

datetime=$(date '+%m%d%H%M%S')
log_id="${datetime}-${commit_id}"
# 1回目のsource default.shを上書き
source ${utilhome}/tools/lib/default.sh $log_id

mkdir -p ${utilhome}/log/${log_id}
touch ${utilhome}/log/${log_id}/result

# copy pprof result
cp -r ${utilhome}/pprof ${utilhome}/log/${log_id}/pprof

# fetch measure result
curl http://$app_ip/stats >${utilhome}/log/${log_id}/measure.csv
# csv -> tsv
# tr "," "\\t" <${utilhome}/log/${log_id}/measure.csv >${utilhome}/log/${log_id}/measure.tsv

echo "-------------"
echo "isucon1"
for ((i = 0; i < ${#isucon1_server_logs[@]}; i++)); do
	server_log="${isucon1_server_logs[$i]}"
	local_log="${isucon1_local_logs[$i]}"
	mkdir -p ${local_log%/*}
	scp isucon1:$server_log $local_log
done

echo "-------------"
echo "isucon2"
for ((i = 0; i < ${#isucon2_server_logs[@]}; i++)); do
	server_log="${isucon2_server_logs[$i]}"
	local_log="${isucon2_local_logs[$i]}"
	mkdir -p ${local_log%/*}
	scp isucon2:$server_log $local_log
done

echo "-------------"
echo "isucon3"
for ((i = 0; i < ${#isucon3_server_logs[@]}; i++)); do
	server_log="${isucon3_server_logs[$i]}"
	local_log="${isucon3_local_logs[$i]}"
	mkdir -p ${local_log%/*}
	scp isucon3:$server_log $local_log
done

# print SQL digest
# pt-query-digest ${utilhome}/log/${log_id}/mysql/slow_query2.log >${utilhome}/log/${log_id}/query_digest2
# pt-query-digest ${utilhome}/log/${log_id}/mysql/slow_query3.log >${utilhome}/log/${log_id}/query_digest3

# print ALP result
ltsv_format=""
ltsv_format+="/api/chair/[0-9]+,"
ltsv_format+="/api/chair/buy/[0-9]+,"
ltsv_format+="/api/estate/[0-9]+,"
ltsv_format+="/api/estate/req_doc/[0-9]+,"
ltsv_format+="/api/recommended_estate/[0-9]+"
cat ${utilhome}/log/${log_id}/nginx/access1.log | alp ltsv -m $ltsv_format --sort sum -r >${utilhome}/log/${log_id}/alp1

# 変更タグとスコアを入力
echo "Input change name:"
read change

echo "Input score:"
read score

mv ${utilhome}/log/${log_id} ${utilhome}/log/${log_id}-${change}-${score}
