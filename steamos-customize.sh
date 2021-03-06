#!/bin/bash
#Customize SteamOSInstaller

#Check we are root first
id=`id -u`
if [ ${id} -ne 0 ]; then
	echo "You must run this script as root or with sudo"
	exit 1
fi

#Check if dists/alchemist in the parent directory before running
steamosfile="../dists/alchemist"

if [ ! -d ${steamosfile} ]; then
	echo "File ${steamosfile} doesn't exist!"
	echo "Did you clone steamos-custom into the SteamOSInstaller directory?"
	exit 1
fi

#Install apt dependencies
deps="apt-utils genisoimage"
if apt-get -y -qq install ${deps} >/dev/null 2>&1; then
	:
else
	echo "Error installing dependencies: ${deps}"
fi

grubpooldir="../pool/main/g/grub2"
for deb in `ls ${grubpooldir} | egrep -e "*.[u.]deb"`; do
	if [ -f ${grubpooldir}/${deb} ]; then
		echo "Removing file ${grubpooldir}/${deb}"
		rm -fr "${grubpooldir}/${deb}"
	fi
done

grubnewdeb="debs"
for deb in `ls ${grubnewdeb} | egrep -e "*.[u.]deb"`; do
	deb=`basename ${deb}`
	if [ ! -f ${grubpooldir}/${deb} ]; then
		echo "Copying ${grubnewdeb}/${deb} into ${grubpooldir}"
		cp ${grubnewdeb}/${deb} ${grubpooldir}
	fi
done

#Rebuild cdrom archive
archivefile="steamos-archive.conf"
dists="alchemist testing"
echo "Generating Packages"
apt-ftparchive generate ${archivefile}

for dist in ${dists}; do
	echo "Generating release for ${dist}..."
	if apt-ftparchive -c ${archivefile} release ../dists/${dist} > ../dists/${dist}/Release; then
		:
	else
		echo "Error generating repo for ${dist}"
	fi
done

#Build our ISO
./steamos-buildiso.sh
