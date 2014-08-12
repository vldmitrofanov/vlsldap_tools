#!/bin/bash

function generate_pass (){
        local MYSSWD=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w $PASSD_LENGTH | head -n 1)
        echo $MYSSWD
}

function generate_sambaSID (){
	sambaSID=
        for num in 1 2 3 ;do
            randNum=$(od -vAn -N4 -tu4 < /dev/urandom | sed -e 's/ //g')
            if [ -z "$sambaSID" ];then
                sambaSID="S-1-5-21-$randNum"
            else
                sambaSID="${sambaSID}-${randNum}"
            fi
        done
        echo $sambaSID
}

function generate_ssha (){
       local mypass=$(/usr/sbin/slappasswd -h {SSHA} -s $1)
       echo $mypass
}

