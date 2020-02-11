#!/bin/bash

username='mk2@v***ge.com'
oAuthClientId='<clientIdhere>'
serverKeyPath='c:/users/mariano.korman/server.key'

echo ">> Connecting with username: $username"
sfdx force:auth:jwt:grant -u $username -i $oAuthClientId -f $serverKeyPath -s
# this will convert to the metadata API format
sfdx force:source:convert --outputdir deploy
# this will deploy the files to the org
sfdx force:mdapi:deploy -u $username -l RunLocalTests -d deploy -w 1 
# Remove temporary deploy folder
rm "deploy" --force --recursive
