generate="True"
HOME="/var/otherusers/wei2912"
# updating repo
cd $HOME/site
touch $HOME/temp.txt
/usr/bin/git pull > $HOME/temp.txt
git submodule update --init

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
fi

if [ "$generate" == "True" ]
then
	echo "Generating files..."
	
	# building the files
	cd $HOME/site
	$HOME/.gem/ruby/1.9.1/gems/jekyll-*/bin/jekyll build $HOME/site/_site/ || exit 1
	
	# shift the contents of the binaries folder
	mv $HOME/site/binaries/* $HOME/site/_site
	
	# copying the files over to mysite folder
	rm -rf $HOME/mysite/*
    cp -r $HOME/site/_site/* $HOME/mysite/
    chmod -R 755 $HOME/mysite/
else
	echo "Not generating files..."
fi

# clean up
cd $HOME/
