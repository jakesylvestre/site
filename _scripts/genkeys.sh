#!/bin/bash

IFS=$'\r\n'

cp ~/.ssh/travis_rsa ./id_rsa
fold -w 100 ~/.ssh/travis_rsa.pub > ./id_rsa.pub

array=($(cat ./id_rsa))

for i in "${!array[@]}"
do
	echo $i
	travis encrypt ID_RSA_${i}="${array[i]}"
done

array=($(cat ./id_rsa.pub))

for i in "${!array[@]}"
do
	echo $i
	travis encrypt ID_RSA_PUB_${i}="${array[i]}"
done

cat ./id_rsa | wc -l > _scripts/id_rsa.info
cat ./id_rsa.pub | wc -l > _scripts/id_rsa.pub.info
rm ./id_rsa ./id_rsa.pub
