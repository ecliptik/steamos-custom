#!/bin/bash
#Customize SteamOSInstaller

deps="apt-utils genisoimage"

#Install apt dependencies
if apt-get -y -qq install ${deps} >/dev/null 2>&1; then
	:
else
	echo "Error installing dependencies: ${deps}"
fi

grubpooldir="../pool/main/g/grub2/"
#Remove the grub UEFI packages
for efideb in `ls ${grubpooldir}/grub-efi*`; do
	if [ -f ${efideb} ]; then
		echo "Removing ${efideb}"
		rm -fr "${efideb}"
	fi
done

grubnewdeb="debs"
for deb in `ls ${grubnewdeb}/*.deb`; do
	deb=`basename ${deb}`
	if [ ! -f ${grubpooldir}/${deb} ]; then
		echo "Copying ${grubnewdeb}/${deb} into ${grubpooldir}"
		cp ${deb} ${grubpooldir}
	fi
done

#Rebuild cdrom archive
archivefile="steam-archive.conf"
dists="alchemist testing"
echo "Generating Packages"
apt-ftparchive generate ${archivefile}

for dist in ${dists}; do
	echo "Generating release for ${dist}..."
	if apt-ftparchive -c steam-archive.conf release ../dists/${dist} > ../dists/${dist}/Release; then
		:
	else
		echo "Error generating repo for ${dist}"
	fi
done

#Copy isolinux dir one up
cp -pfr isolinux ..

#Build our ISO
./buildiso.sh