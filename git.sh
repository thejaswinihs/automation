#!/bin/bash
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
git push  origin Dev
git tag "Automation-v0.1"
