steamos-custom
=======

Builds a customized SteamOS Installer ISO

Features:
* Removes grub-efi requirements and replaces them with Debian Wheezy grub-pc
* Enables DHCP networkin during install
* Enables root account
* Choice of GTK or text install methods

Known Bugs:
* Installer will fail on base-install, clicking continue a few times and contining the install will complete successfully

Todo:
* Enable LVM storage options, drop in code is commented out, but steamos installer kernel lacks LVM modules
