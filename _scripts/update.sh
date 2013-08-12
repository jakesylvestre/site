generate="True"
HOME="/var/otherusers/wei2912"
# updating repo
cd $HOME/site
touch $HOME/temp.txt
/usr/bin/git pull > $HOME/temp.txt

echo $1
if [ "$1" == "--force" ]
then
	generate="True"
else
	# detect any changes
	if [ -z "$(grep 'Already up-to-date.' $HOME/temp.txt)" ]
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
		echo "$(tar c $HOME/mysite_files | md5sum)" > $HOME/temp_checksum.txt
		n_checksum="$(sed '$!d' $HOME/temp_checksum.txt)"
		if [ "$n_checksum" == "$(sed -n '1p' $HOME/files_checksum.txt)" ]
		then
			echo "Checksum shows that site is up to date."
		else
			echo "$n_checksum" > $HOME/files_checksum.txt
			echo "Checksum shows that site is not up to date."
			generate="True"
		fi
	fi
fi

if [ "$generate" == "True" ]
then
	echo "Generating files..."
	# copying the files over to mysite folder!
	cd $HOME/site
	$HOME/.gem/ruby/1.9.1/gems/jekyll-*/bin/jekyll build $HOME/site/_site/ || exit 1
	rm -rf $HOME/mysite/*
    cp -r $HOME/site/_site/* $HOME/mysite/
    chmod -R 744 $HOME/mysite
else
	echo "Not generating files..."
fi

cp -r $HOME/mysite_files/* $HOME/mysite

# clean up
cd $HOME/
