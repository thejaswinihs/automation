
#!/bin/bash
update=`sudo apt update -y >/dev/null 2>&1`
echo $update
package=`sudo apt list apache2 | grep apache2 | grep installed >/dev/null 2>&1`
packageinstall=`sudo apt install apache2 >/dev/null 2>&1`
packagestatus="installed"
servicecheck=`sudo systemctl status apache2 | grep running >/dev/null 2>&1`
servicestart=`sudo systemctl start apache2 | grep running >/dev/null 2>&1`
serviceenablestatus= `sudo systemctl status apache2 | grep enabled >/dev/null 2>&1`
serviceenable=`sudo systemctl enable apache2 | grep enabled >/dev/null 2>&1`
name="Thejaswini"
filepath="/var/www/html/inventory.html"
if [[ $package -ne $packagestatus ]]
then
        echo $packageinstall
        if [ echo $? -eq 0 ]
        then
                echo "package installed"
        else
                echo " pacakge noy installed"
        fi
else
        echo "package already installed"


fi

if [[ $servicecheck -ne  "running" ]]
then
         echo $servicestart
        if [ echo $? -eq 0 ]
        then
                echo "service restarted successfully"
        else
                echo "service not started "
        fi
else
         echo "service running"

fi

if [[ $serviceenablestatus -ne "enabled" ]]
then
	echo $serviceenable
	if  [ echo $? -eq 0 ]
	then
		echo "service installed is enabled"
	else
		echo "service not enabled"

	fi
else 
	echo " service is enabled"
fi

apt install  awscli
if [$? -ne 0];then
	sudo apt install awscli -y
fi
dt=$(date +%Y%m%d%H%M%S)
tar -cvf /tmp/$name-httpd-logs-$dt.tar /var/log/apache2
aws s3 cp /tmp/$name-httpd-logs-$dt.tar  s3://upgrad-thejaswini

echo `git init`
if [ $? -eq 0 ];
then
	echo "git initilized"
	echo " automate to check the service status and upload the logs s3 bucket"> readme.md
fi

git checkout -b Dev
git add .
git commit -m "uploading the file"
git remote add origin https://github.com/thejaswinihs/automation.git
git push --set-upstream origin Dev


#if [ -e $filepath ]; then
#	echo "File exits"
#else
#	echo "LogType	Time Created	Type	Size" >>/var/www/inventory.htmli
#fi	
