#!/bin/bash

server=$1


copyFile() {
	file="${1/#\~/$HOME}"
	test -e $file
	if [ $? -eq 0 ] ; then
		# confirm parent directory exists
    	parent_dir=$(dirname $file)
		ssh $server "mkdir -p $parent_dir"

		# copy local file or directory to remote
		scp -r $file $server:$file
	else
		echo "skipped $file because it doesn't exist"
	fi
}



cat ~/.ssh/id_rsa.pub | ssh $server "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
cat ~/.ssh/authorized_keys | ssh $server 'cat >> ~/.ssh/authorized_keys'

copyFile "~/.aws/credentials"
copyFile "~/.bashrc"
copyFile "~/.gitconfig"
copyFile "~/.liquidprompt"
copyFile "~/.m2/settings.xml"
copyFile "~/.screenrc"
copyFile "~/.tmux.conf"
copyFile "~/.vimrc"



