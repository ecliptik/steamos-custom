#!/bin/sh
#Build an ISO one directory up out of the current directory

mkisofs -o ../steamoscustom.iso -b isolinux/isolinux.bin \
        -no-emul-boot -boot-load-size 4 \
        -boot-info-table -r .
