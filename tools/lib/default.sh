remote_hosts=()
isucon1_server_logs=()
isucon2_server_logs=()
isucon3_server_logs=()
isubench_server_logs=()
isucon1_local_logs=()
isucon2_local_logs=()
isucon3_local_logs=()
isubench_local_logs=()

utilhome=$(pwd)
if [ $# != 1 ]; then
	log_id=$(date '+%m%d%H%M%S')
else
	log_id=$1
fi

remote_hosts+=("isucon1")
# remote_hosts+=("isucon2")
remote_hosts+=("isucon3")

app_ip="54.199.41.247" # ! 要編集

server_home="/home/isucon"
server_git_dir="${server_home}/webapp" # ! 要編集

# SERVER
# isucon1_server_logs+=("/home/isucon/isubata/webapp/go/log/app.log")
isucon1_server_logs+=("/var/log/nginx/access.log")
isucon1_server_logs+=("/var/log/nginx/error.log")
# isucon1_server_logs+=("/var/log/redis/redis-server.log")

# isucon2_server_logs+=("/var/log/mysql/error.log")
# isucon2_server_logs+=("/var/log/mysql/query.log")
# isucon2_server_logs+=("/var/log/mysql/slow_query.log")

# isucon3_server_logs+=("/home/isucon/isubata/webapp/go/log/app.log")
# isucon3_server_logs+=("/var/log/nginx/access.log")
# isucon3_server_logs+=("/var/log/nginx/error.log")
isucon3_server_logs+=("/var/log/mysql/error.log")
isucon3_server_logs+=("/var/log/mysql/query.log")
isucon3_server_logs+=("/var/log/mysql/slow_query.log")

# LOCAL
# isucon1_local_logs+=("${utilhome}/log/${log_id}/app/app1.log")
isucon1_local_logs+=("${utilhome}/log/${log_id}/nginx/access1.log")
isucon1_local_logs+=("${utilhome}/log/${log_id}/nginx/error1.log")
# isucon1_local_logs+=("${utilhome}/log/${log_id}/redis/redis-server.log")

# isucon2_local_logs+=("${utilhome}/log/${log_id}/mysql/error2.log")
# isucon2_local_logs+=("${utilhome}/log/${log_id}/mysql/query2.log")
# isucon2_local_logs+=("${utilhome}/log/${log_id}/mysql/slow_query2.log")

# isucon3_local_logs+=("${utilhome}/log/${log_id}/app/app3.log")
# isucon3_local_logs+=("${utilhome}/log/${log_id}/nginx/access3.log")
# isucon3_local_logs+=("${utilhome}/log/${log_id}/nginx/error3.log")
isucon3_local_logs+=("${utilhome}/log/${log_id}/mysql/error3.log")
isucon3_local_logs+=("${utilhome}/log/${log_id}/mysql/query3.log")
isucon3_local_logs+=("${utilhome}/log/${log_id}/mysql/slow_query3.log")
