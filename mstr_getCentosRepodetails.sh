#!/bin/bash

#This script created to get centos 7 public repo base,extras and updates package counts.



if [[ $1 == 'os' || $1 == 'extras' || $1 == 'updates' ]]; then
	 mkdir -p logs/$1/

 	 curl -s http://mirror.centos.org/centos/7.6.1810/$1/x86_64/Packages/ > "logs/$1/public_repo_tmp"$(date +"%d-%m-%y")".log"
	 cut -d '=' -f 5 "logs/$1/public_repo_tmp"$(date +"%d-%m-%y")".log" | cut -d '"' -f2 | grep 'rpm' > "logs/$1/public_repo_"$(date +"%d-%m-%y")"_$1.log"
         count=$(cat "logs/$1/public_repo_"$(date +"%d-%m-%y")"_$1.log" | wc -l)
	 
	 echo -e "{\"$1\":\""$count"\"}"
		if [ $? -eq 0 ]; then
		
        		rm -f  "logs/$1/public_repo_tmp"$(date +"%d-%m-%y")".log"
		else
        		echo FAIL
		fi

else
	echo Enter Valid Argument 
fi	

