noGenerate="True" # set to true
# updating repo
cd /var/otherusers/wei2912/linuxtuts.github.com/
touch /var/otherusers/wei2912/temp.txt
/usr/bin/git pull > /var/otherusers/wei2912/temp.txt || exit 1

echo $1
if [ "$1" == "--force" ]
then
	generate="True"
else
	# detect any changes
    changes=$(grep -Fx 'Already up-to-date.' /var/otherusers/wei2912/temp.txt)
	if [ -z "$changes" ]
	then
		echo "Grep result shows that site is not up to date."
		generate="True"
	else
		echo "Grep result shows that site is up to date."
		generate="False"
	fi
	
	if [ "$generate" == "False" ] # if it's not going to generate, try to get the script to generate the site again.
	then
		# checking for binaries
		echo "$(tar c /var/otherusers/wei2912/mysite_files | md5sum)" > /var/otherusers/wei2912/temp_checksum.txt
		if [ "$(sed '$!d' /var/otherusers/wei2912/temp_checksum.txt)" == "$(sed -n '1p' /var/otherusers/wei2912/files_checksum.txt)" ]
		then
			echo "Checksum shows that site is up to date."
		else
			echo "$(sed '$!d' /var/otherusers/wei2912/temp_checksum.txt)" > /var/otherusers/wei2912/files_checksum.txt
			echo "Checksum shows that site is not up to date."
			generate="True"
		fi
	fi
fi

if [ "$generate" == "True" ]
then
	echo "True"
	# copying the files over to mysite folder!
	/var/otherusers/wei2912/.gem/ruby/1.9.1/gems/jekyll-*/bin/jekyll build  /var/otherusers/wei2912/linuxtuts.github.com/_site/ || exit 1
	rm -rf /var/otherusers/wei2912/mysite/*
    cp -r /var/otherusers/wei2912/linuxtuts.github.com/_site/* /var/otherusers/wei2912/mysite/
else
	echo "False"
fi

cp -r /var/otherusers/wei2912/mysite_files/* /var/otherusers/wei2912/mysite

# clean up
rm /var/otherusers/wei2912/temp.txt
cd /var/otherusers/wei2912/
