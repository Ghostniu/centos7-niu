#!/bin/sh

NUM="$#"
CODE_NAME="$1"_"$2"
TMP_DIR="/tmp/code"
RETVAL="0"
name="niu"
IP="192.168.2.171"

check(){

	if [[  $NUM -ne 2 ]]; then
		#echo $"usage: $0 code_depth code_ver code_dir"
		exit 1 
	fi 
	
}

deploy_pro(){

	/usr/bin/scp -P 52113 $TMP_DIR/"$CODE_NAME".tar.gz $IP:/home/niu &>/dev/null 
	[ $? -ne 0 ]&& exit 3
	/usr/bin/ssh -p52113 $name@$IP  "sudo /bin/cp /home/niu/"$CODE_NAME".tar.gz /data/code/"
	[ $? -ne 0 ]&& exit 4
	/usr/bin/ssh -p52113 $name@$IP  "sudo tar -zxf /data/code/"$CODE_NAME".tar.gz -C /data/code/"
	[ $? -ne 0 ]&& exit 5 
	/usr/bin/ssh -p52113 $name@$IP  "sudo mv /data/db/config /tmp/"
	[ $? -ne 0 ]&& exit 6
	/usr/bin/ssh -p52113 $name@$IP  "sudo ln -s /data/code/$CODE_NAME/ /data/db/config " 
	RETVAL="$?"

}


main(){

	check
    deploy_pro 
    echo $RETVAL

}

main


