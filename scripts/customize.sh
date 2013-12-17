#!/bin/bash
#Customize SteamOSInstaller

localzip="${vartmp}/${steamoszip}"
deps="apt-utils genisoimage"

#Install apt dependencies
if apt-get -y -qq install ${deps}; then
	:
else
	echo "Error installing dependencies: ${deps}"
fi

if [ ! -d "${vartmp}" ]; then
	echo "Temporary directory ${vartmp} doesn't exist!"
fi

grubpooldir="pool/main/g/grub2/"
#Remove the grub UEFI packages
for efideb in `ls pool/main/g/grub2/grub-efi*`; do
	echo "Removing ${efideb}"
	rm -fr "${efideb}"
done

grubnewdeb="debs"
for deb in `ls ${grubnewdeb}/*.deb`; do
	echo "Copying ${grubnewdeb}/${deb} into ${grubpooldir}"
	cp ${deb} ${grubpooldir}
done

#Rebuild cdrom archive
archivefile="steam-archive.conf"
dists="alchemist testing"
echo "Generating Packages"
apt-ftparchive generate ${archivefile}

for dist in ${dists}; do
	echo "Generating release for ${dist}..."
	if apt-ftparchive -c steam-archive.conf release dists/${dist} > dists/${dist}/Release; then
		:
	else
		echo "Error generating repo for ${dist}"
	fi
done

#Build our ISO
scripts/buildiso.sh
