#!/bin/bash

username='mk2@v**ge.com'
packageName='Geolocation'
packageDescription='Test-Geolocation-App' #note that spaces are not well supported in SFDX in windows Git bash
packageId='<packageIdhere>'
packageVersion='1.14'
oAuthClientId='<clientIDhere>'
serverKeyPath='c:/users/mariano.korman/server.key'

echo ">> Connecting with username: $username..."
sfdx force:auth:jwt:grant -u $username -i $oAuthClientId -f $serverKeyPath -s
if [ $? -ne 0 ]; then
    echo ">> Login failure"
    exit 1
else 
    echo ">> Login successful"
fi

# deploy source without metadata API. This is beta, but it seems to work
echo ">> Deploying source code..."
sfdx force:source:deploy -u $username -p force-app/main/default -w 2
if [ $? -ne 0 ]; then
    echo ">> Deploy failure"
    exit 1
else
    echo ">> Deploy successful"
fi

# this will create the package
echo ">> Packaging..."
packageResponse=$(sfdx force:package1:version:create -u $username -n $packageName -d $packageDescription -i $packageId -v $packageVersion -m -w 2 --json 2>&1)
if [ $? -ne 0 ]; then
    errorMessage=$(echo $packageResponse | ./jq -r .message )
    echo ">> Package failure: $errorMessage"
    exit 1
else
    packageVersionId=$(echo $packageResponse | ./jq -r .result.MetadataPackageVersionId)
    packageInstallUrl="https://login.salesforce.com/packaging/installPackage.apexp?p0=$packageVersionId"
    echo ">> Package install URL is: $packageInstallUrl"
fi

#echo ">> Getting package version details..."
#sfdx force:package1:version:display -u $username -i $packageVersionId -w 2 --json

# logout
echo ">> Logging out..."
sfdx force:auth:logout -u $username -p
exit 0