#!/usr/bin/env bash

echo "NodeJS will be installed if not present"
echo "Sudo password will be required"

USES_APT=$(which apt | grep -w "apt" | wc -l)
USES_RPM=$(which rpm | grep -w "rpm" | wc -l)

if [ $USES_APT -eq 1 ]; then 
	curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh
	chmod 500 nsolid_setup_deb.sh
	./nsolid_setup_deb.sh 20
	sudo apt-get install nodejs -y

elif [ $USES_RPM -eq 1]; then
	curl -SLO https://rpm.nodesource.com/nsolid_setup_rpm.sh
	chmod 500 nsolid_setup_rpm.sh
	./nsolid_setup_rpm.sh 20
	sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1

echo "Done"
echo ""
