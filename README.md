steamos
=======

Installation configuration of SteamOS with various tweaks

Currently does not install LVM due to lack of kernel modules in Steam debian-installer

Replaced grub-efi with grub-pc from the wheezy repo.

Re-build the media archive by running within the steamos-custom main directory:

sudo apt-ftparchive generate steam-archive.conf 
sudo apt-ftparchive -c steam-archive.conf release dists/alchemist > dists/alchemist/Release
sudo apt-ftparchive -c steam-archive.conf release dists/testing > dists/testing/Release
