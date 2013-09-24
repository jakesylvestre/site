#!/bin/bash
echo "Host deploy_server" >> ~/.ssh/config || exit 1
echo "    Hostname ${SSH_HOST}" >> ~/.ssh/config || exit 1
echo "    User ${SSH_USER}" >> ~/.ssh/config || exit 1
echo "    Port ${SSH_PORT}" >> ~/.ssh/config || exit 1
echo "    StrictHostKeyChecking no" >> ~/.ssh/config || exit 1
echo "    CheckHostIP no" >> ~/.ssh/config || exit 1
echo "    UserKnownHostsFile=/dev/null" >> ~/.ssh/config || exit 1
echo "    IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config || exit 1

gpg --passphrase ${ENCRYPT_PASS} --output ~/.ssh/id_rsa --decrypt ./_scripts/travis_rsa.gpg || exit 1
gpg --passphrase ${ENCRYPT_PASS} --output ~/.ssh/id_rsa.pub --decrypt ./_scripts/travis_rsa.pub.gpg || exit 1
chmod 0700 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub || exit 1

rsync -avze ssh ./_site/* deploy_server:~/mysite/ || exit 1
ssh deploy_server chmod -R 755 /var/otherusers/wei2912/mysite/ || exit 1
