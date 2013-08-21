#!/bin/bash
echo "Host deploy_server" >> ~/.ssh/config
echo "    Hostname ${SSH_HOST}" >> ~/.ssh/config
echo "    User ${SSH_USER}" >> ~/.ssh/config
echo "    Port ${SSH_PORT}" >> ~/.ssh/config
echo "    StrictHostKeyChecking no" >> ~/.ssh/config
echo "    CheckHostIP no" >> ~/.ssh/config
echo "    UserKnownHostsFile=/dev/null" >> ~/.ssh/config
echo "    IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config

ID_RSA_INFO=$(cat _scripts/id_rsa.info)
ID_RSA_PUB_INFO=$(cat _scripts/id_rsa.pub.info)

echo "$ID_RSA_{0..$ID_RSA_INFO}" >> ~/.ssh/id_rsa
echo -n "$ID_RSA_PUB_{0..$ID_RSA_PUB_INFO}" >> ~/.ssh/id_rsa.pub
chmod 0700 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub

rsync -avze ssh ./_site/* deploy_server:~/mysite/
ssh deploy_server chmod -R 755 /var/otherusers/wei2912/mysite/
