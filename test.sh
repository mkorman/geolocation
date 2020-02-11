#!/bin/bash

username='mk2@v***ge.com'
oAuthClientId='<client ID>'
serverKeyPath='c:/users/mariano.korman/server.key'

echo ">> Connecting with username: $username"
sfdx force:auth:jwt:grant -u $username -i $oAuthClientId -f $serverKeyPath -s
# this will convert to the metadata API format
sfdx force:source:convert --outputdir deploy
# this will test everything in the org
echo ">> Testing..."
sfdx force:mdapi:deploy -u $username -c -l RunLocalTests -d deploy -w 1 
# Remove temporary deploy folder
rm "deploy" --force --recursive
