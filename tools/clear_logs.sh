#!/bin/bash

set -e
utilhome=$(pwd)
source ${utilhome}/tools/lib/default.sh

# clear logs in server
clearing_command_1="echo 'clear isucon1 logs'"
for ((i = 0; i < ${#isucon1_server_logs[@]}; i++)); do
	clearing_command_1+=" && sudo cp /dev/null ${isucon1_server_logs[$i]}"
done
clearing_command_2="echo 'clear isucon2 logs'"
for ((i = 0; i < ${#isucon2_server_logs[@]}; i++)); do
	clearing_command_2+=" && sudo cp /dev/null ${isucon2_server_logs[$i]}"
done
clearing_command_3="echo 'clear isucon3 logs'"
for ((i = 0; i < ${#isucon3_server_logs[@]}; i++)); do
	clearing_command_3+=" && sudo cp /dev/null ${isucon3_server_logs[$i]}"
done

ssh -t isucon1 $clearing_command_1
ssh -t isucon2 $clearing_command_2
ssh -t isucon3 $clearing_command_3
