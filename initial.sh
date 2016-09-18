#!/bin/bash

cd $(dirname $0)

IP=$1

USERNAME=$2
USERNAME=${USERNAME:-isucon}


rsync -acv data $USERNAME@$IP:/tmp/
ssh $USERNAME@$IP "/tmp/data/init.sh"

for user in fkarasaw mtaguch hatotaka
do
  rsync -acv $user/* $user@$IP:/home/$user/
done
