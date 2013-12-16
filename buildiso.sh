#!/bin/sh
#Build an ISO one directory up out of the current directory

outfile="../steamoscustom.iso"

#Remove the ISO first if it was already created
if [ -f ${outfile} ]; then
	rm -fr ${outfile}
fi

mkisofs -o ${outfile} -b isolinux/isolinux.bin \
        -no-emul-boot -boot-load-size 4 \
        -boot-info-table -r .
