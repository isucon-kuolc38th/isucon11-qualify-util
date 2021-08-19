#!/bin/bash

set -e
utilhome=$(pwd)

if [ $# != 1 ]; then
	branch=master
else
	branch=$1
fi

source ${utilhome}/tools/lib/pull_in_each_remote.sh $branch
source ${utilhome}/tools/lib/restart_in_each_remote.sh
