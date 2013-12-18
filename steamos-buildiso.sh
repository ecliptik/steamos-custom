#!/bin/sh
#Build an ISO from one directory up

outfile="steamoscustom.iso"

#Remove the ISO first if it was already created
if [ -f ${outfile} ]; then
	rm -fr ${outfile}
fi

#Copy isolinux dir one up
cp -pfr isolinux ..

isodir=`pwd`
	echo "Builingt ISO ${isodir}/${outfile}..."
if genisoimage -o ${outfile} -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -RJ -r ..; then
	echo "Built ISO ${isodir}/${outfile}"
else
	echo "Unable to build ISO ${isodir}/${outfile}"
fi
