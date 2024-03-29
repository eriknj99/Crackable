#Check Dependencies

if [ "$1" = "dep" ]; then
	

	sudo apt update 
	for dep in figlet 
	do
		echo -n Checking for dependency: $dep...
		if ! type "$dep" > /dev/null; then	
			echo not found, installing...
			sudo apt install $dep -y	
			echo done.
		else
			echo Installed!
		fi
	done
fi

if [ "$1" = "clean" ]; then
	for value in level0 level1 level2
	do
		#If the user exists delete them 
		exists="$(grep -c $value /etc/passwd)"
		if [ "$exists" = "1" ]; then
			echo -n "Deleting user: $value..."
			sudo userdel $value -rf 2>/dev/null
			echo "done."
		fi
	done


fi

if [ "$1" = "L0" ]; then
	sudo systemctl start ssh	
	#If the user does not exist creat them.
	exists="$(grep -c '^level0:' /etc/passwd)"
	if [ "$exists" = "0" ]; then
		echo -n "Creating user: level0..."
		sudo useradd level0 -m -s /bin/bash
		echo "clear && figlet AccessGranted! -f slant" >> /home/level0/.bashrc 
		touch /home/level0/.hushlogin
		echo "done."
	fi


	echo -n "Setting level0s password to '123'..."
	#Set the level0s password to 123
	echo level0:123 | chpasswd

fi

if [ "$1" = "L1" ]; then
	
	#If the user does not exist creat them.
	exists="$(grep -c '^level1:' /etc/passwd)"
	if [ "$exists" = "0" ]; then
		echo -n "Creating user: level1..."
		sudo useradd level1 -m -s /bin/bash
		echo "clear && figlet AccessGranted! -f slant" >> /home/level1/.bashrc 
		touch /home/level1/.hushlogin
		echo "done."
	fi
		
	rand="$(shuf -i 100-999 -n1)"
	echo -n "Setting level1s password to a random 3 digit number ..."
	#Set the password to $rand
	echo level1:$rand | chpasswd

	echo "done."
fi

if [ "$1" = "L2" ]; then	
	#If the user does not exist creat them.
	exists="$(grep -c '^level2:' /etc/passwd)"
	if [ "$exists" = "0" ]; then
		echo -n "Creating user: level2..."
		sudo useradd level2 -m -s /bin/bash
		echo "clear && figlet AccessGranted! -f slant" >> /home/level2/.bashrc 
		touch /home/level2/.hushlogin
		echo "done."
	fi
		
	rand="$(shuf -n 1 wordlist.txt)"
	echo -n "Setting level2s password to a random word in the wordlist..."
	#Set the password to $rand
	echo level2:$rand | chpasswd
	echo "done."
fi

if [ "$1" = "C1" ]; then
	echo "hydra -V -l level1 -x 3:3:1 127.0.0.1 ssh"
	hydra -V -l level1 -x 3:3:1 127.0.0.1 ssh
fi

if [ "$1" = "C2" ]; then
	echo "hydra -l level2 -P wordlist.txt 127.0.0.1 ssh"
	hydra -l level2 -P wordlist.txt 127.0.0.1 ssh
fi

if [ "$1" = "help" ] || [ "$1" = "" ]; then
	figlet CRACKABLE -f slant
	
	echo "			-----help-----
	      Usage: sh ./crackable.sh ARGUMENT

	      L0    : Generate user level0, password:123
	      L1    : Generate user level1, password:3 random digits 
	      L2    : Generate user level2, password:randomly selected from wordlist.txt
	      
	      C1    : Auto cracks level1
	      C2    : Auto cracks level2
	      
	      dep   : Install required dependencies if not present
	      clean : Remove users level0, level1, and level2 if present
	"


	echo "CRACKABLE v0.0.1 Erik Olsen 2019"
fi

