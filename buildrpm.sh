#!/bin/bash

while getopts v:r: option
do
case "${option}"
in
v) VERSION=${OPTARG};;
r) RELEASE=${OPTARG};;
esac
done

APP='RouteUpdate'
PROJECT='eos-sdk-route-update'
DUT='192.168.20.1'
mkdir -p rpmbuild/SOURCES
mkdir -p rpmbuild/RPM
tar -cvf rpmbuild/SOURCES/RouteMon-${VERSION}-${RELEASE}.tar source/*

cd /workspaces/${PROJECT}/rpmbuild/SPECS

rpmbuild -ba ${name}.spec

cd /workspaces/${PROJECT}

rm manifest.txt

echo "format: 1" >> manifest.txt
echo "primaryRPM: ${APP}-${VERSION}-${RELEASE}.noarch.rpm" >> manifest.txt
echo -n "${APP}-${VERSION}-${RELEASE}.noarch.rpm: " >> manifest.txt
echo $(sha1sum rpmbuild/RPM/noarch/${APP}-${VERSION}-${RELEASE}.noarch.rpm | awk '{print $1}') >> manifest.txt

scp -i ~/.ssh/builder /workspaces/${PROJECT}/rpmbuild/RPM/noarch/${APP}-${VERSION}-${RELEASE}.noarch.rpm builder@${DUT}:/mnt/flash/ext-eos/
scp -i ~/.ssh/builder manifest.txt builder@${DUT}:/mnt/flash/ext-eos/

ssh -i ~/.ssh/builder builder@${DUT} bash swix create /mnt/flash/ext-eos/swix/${APP}-${VERSION}-${RELEASE}.swix /mnt/flash/ext-eos/${APP}-${VERSION}-${RELEASE}.noarch.rpm

scp -i ~/.ssh/builder builder@${DUT}:/mnt/flash/ext-eos/swix/${APP}-${VERSION}-${RELEASE}.swix /workspaces/${PROJECT}/extension/
