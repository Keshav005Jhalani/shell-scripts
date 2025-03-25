#!/bin/bash
#Backup and rotation for 5 days

function check_args(){
	if [ $# -eq 0 ]; then
		echo Please give arguments while executing scipt
		echo "./backup.sh <path to your source> <path to backup folder>"
	fi
}

check_args "$@"  # passes all arguments to function

timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
source_dir=$1
backup_dir=$2

function create_backup(){
	zip -r "${backup_dir}/backup_${timestamp}.zip" ${source_dir} > /dev/null #use -r so that to zip all files in it recursively
	if [ $? -eq 0 ];then
		echo Backup generated succesfull for ${timestamp}
	else
		echo Error Occured ....Check if paths inputed are correct
	fi
}

function rotation(){
	backups=($(ls -t "${backup_dir}/backup_"*.zip))
	count=${#backups[@]}
	if [ $count -gt 5 ];then
		for((i=5;i< $count;i++));do
			rm -r "${backups[i]}"
		done
	fi
}
create_backup
rotation


