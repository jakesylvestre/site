#!/bin/bash
echo "Host deploy_server" >> ~/.ssh/config
echo "    Hostname ${SSH_HOST}" >> ~/.ssh/config
echo "    User ${SSH_USER}" >> ~/.ssh/config
echo "    Port ${SSH_PORT}" >> ~/.ssh/config
echo "    StrictHostKeyChecking no" >> ~/.ssh/config
echo "    CheckHostIP no" >> ~/.ssh/config
echo "    UserKnownHostsFile=/dev/null" >> ~/.ssh/config
echo "    IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config

gpg --passphrase ${ENCRYPT_PASS} --output ~/.ssh/id_rsa --decrypt ./_scripts/travis_rsa.gpg
gpg --passphrase ${ENCRYPT_PASS} --output ~/.ssh/id_rsa.pub --decrypt ./_scripts/travis_rsa.pub.gpg
chmod 0700 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub

rsync -avze ssh ./_site/* deploy_server:~/mysite/
ssh deploy_server chmod -R 755 /var/otherusers/wei2912/mysite/
