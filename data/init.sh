#!/bin/bash -x

cd $(dirname $0)

# setup users
for user in isucon fkarasaw mtaguchi hatotaka
do
  sudo useradd $user -d /home/$user -s /bin/bash -p delta
  sudo mkdir -p /home/$user/.ssh
  sudo chmod 700 /home/$user/.ssh
  sudo cp authorized_keys /home/$user/.ssh/authorized_keys
  sudo chown -R $user:$user /home/$user
done

