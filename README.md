# Crackable
A script for generating easaly crackable local users on Kali linux.

# Usage
  
        sh ./crackable.sh <ARG1>
	      l0    : Generate user level0, password:123
	      l1    : Generate user level1, password:3 random digits 
	      l2    : Generate user level2, password:randomly selected from wordlist.txt
	      
	      c1    : Auto cracks level1
	      c1    : Auto cracks level2
	      
	      dep   : Install required dependencies if not present
	      clean : Remove users level0, level1, and level2 if present


# Note 
This script was written for kali linux, it is not guarenteed to work on other distros.
If passwords are not being set properly try running the script as root. 
