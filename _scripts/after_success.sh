#!/bin/bash
echo "Host deploy_server" >> ~/.ssh/config
echo "    Hostname ${SSH_HOST}" >> ~/.ssh/config
echo "    User ${SSH_USER}" >> ~/.ssh/config
echo "    Port ${SSH_PORT}" >> ~/.ssh/config
echo "    StrictHostKeyChecking no" >> ~/.ssh/config
echo "    CheckHostIP no" >> ~/.ssh/config
echo "    UserKnownHostsFile=/dev/null" >> ~/.ssh/config

echo -n "$id_rsa_{1..5}" >> ~/.ssh/id_rsa
chmod 0700 ~/.ssh/id_rsa
yes '
' | rsync -avz ./_site/* deploy_server:~/mysite/
