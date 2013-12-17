#!/bin/bash
#Customize SteamOSInstaller.zip

steamoszip="SteamOSInstaller.zip"
steamosurl="http://repo.steampowered.com/download/${steamoszip}"
vartmp="/var/tmp"
localzip="${vartmp}/${steamoszip}"

if [ ! -d "${vartmp}" ]; then
	echo "Temporary directory ${vartmp} doesn't exist!"
fi

#See if zip is already downloaded, if so skip it
if [ -f ${localzip} ]; then
	echo "Existing ${localzip} found skipping dowload"
else
	#Download zip file
	echo "Downloading ${steamosurl} to ${vartmp}..."
	if wget -P /var/tmp -q ${steamosurl}; then
		echo "Downloaded ${steamosurl} to ${vartmp}"
	else
		echo "Error downloading ${steamosurl}"
	fi
fi

#Extract the zip
if unzip ${localzip}; then
	:
else
	echo "Error extacting ${localzip}"
fi

grubpooldir="pool/main/g/grub2/"
#Remove the grub UEFI packages
for efideb in `ls pool/main/g/grub2/grub-efi*`; do
	echo "Removing ${efideb}"
	rm -fr "${efideb}"
done

grubnewdeb="debs"
for deb in `ls ${grubnewdeb}`; do
	echo "Copying ${deb} into ${grubpooldir}"
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
