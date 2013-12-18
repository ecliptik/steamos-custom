steamos-custom
=======

Builds a customized SteamOS Installer ISO

Features:
* Removes grub-efi requirements and replaces them with Debian Wheezy grub-pc
* Enables DHCP networking during install
* Enables root account
* Choice of GTK or text install methods

Known Bugs:
* Installer will fail on base-install
 * Workaround: click continue a few times, choose "Install the base system", and choose yes to complete install

Todo:
* Enable LVM storage options, drop in code is commented out, but steamos installer kernel lacks LVM modules
* Rebuild grub-pc packages to clean up dependencies to avoid installer failures

Requirements:
* Debian or Ubuntu Linux
* sudo permissions 

Instructions:
 1. Download SteamOSInstaller.zip from http://repo.steampowered.com/download/SteamOSInstaller.zip
 2. Unzip SteamOSInstaller.zip into steamos directory
 3. Download https://github.com/ecliptik/steamos-custom/archive/master.zip
 4. Unzip master.zip into steamos directory and go into steamos-custom-master directory
 5. Run script with sudo: sudo ./steamos-customize.sh
 6. Script creates iso named steamoscustom.iso
 7. Boot system with steamoscustom.iso
 8. System will auto boot into SteamOS GUI installer
