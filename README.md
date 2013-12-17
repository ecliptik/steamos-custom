steamos-custom
=======

Builds a customized SteamOS Installer ISO

Features:
* Removes grub-efi requirements and replaces them with Debian Wheezy grub-pc
* Enables DHCP networking during install
* Enables root account
* Choice of GTK or text install methods

Known Bugs:
* Installer will fail on base-install, clicking continue a few times and contining the install will complete successfully

Todo:
* Enable LVM storage options, drop in code is commented out, but steamos installer kernel lacks LVM modules
* Rebuild grub-pc packages to clean up dependencies to avoid installer failures

Requirements:
* Debian or Ubuntu Linux
* sudo permissions 

Instructions:
 1. Download SteamOSInstaller.zip from http://repo.steampowered.com/download/SteamOSInstaller.zip
 2. Unzip SteamOSInstaller.zip into steamos directory
 3. Download https://github.com/ecliptik/steamos-custom/archive/master.zip into steamos directory
 4. Unzip master.zip into steamos directory and go into steamos-custom-master directory
 5. Run script with sudo: sudo steamos-customize.sh
 6. When script finishes the iso steamoscustom.iso will be created
 7. Boot system with steamoscustom.iso
 8. Enter steamos for a GUI install, or steamos-text for a text based install
