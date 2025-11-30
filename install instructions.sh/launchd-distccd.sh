#!/bin/sh
export PATH=/usr/local/arm-linux/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

/usr/local/bin/distccd --daemon --allow 192.168.200.0/23 --no-detach --verbose


#this file is for launchd so you can run at startup (on the Mac)
#I placed this in /Users/YOUR_USER_NAME/Scripts/launchd-distccd.sh