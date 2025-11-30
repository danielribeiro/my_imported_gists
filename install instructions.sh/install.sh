#!/bin/bash

PKG=~/Desktop/arm-linux-gnueabihf.pkg
 
if [ -f $PKG ];
then
   echo "$PKG exists"
else
   echo "$PKG does not exist"
   cd ~/Desktop
   curl -O http://www.jvcref.com/files/PI/arm-linux-gnueabihf.pkg
fi

brew install distcc
sudo installer -pkg $PKG -target /
cd /usr/local/arm-linux/bin


for file in `ls`; do
        if [[ "$file" == "link" ]] || [[ "$file" = arm-cortex_a8-linux-gnueabi-* ]]; then
                #echo $file
                #echo ${file#arm-cortex_a8-linux-gnueabi-}
                continue
        fi
        ln -s $file ${file#arm-cortex_a8-linux-gnueabi-}
done
for file in `ls`; do
        if [[ "$file" = arm-linux-* ]]; then
                #echo $file
                #echo ${file#arm-linux-}
            	sudo mv $file ${file#arm-linux-}
                continue
        fi
       
done