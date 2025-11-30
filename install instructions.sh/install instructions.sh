#ON THE RASPBERRY PI

$ sudo apt-get install distcc

$ nano ~/.profile 

#insert as last line, CTRL+O to save, CTRL+X to exit
export MAKEFLAGS="-j 64 CC=distcc arm-linux-gcc CXX=distcc arm-linux-g++"

$ source ~/.profile

$ cd
$ nano .distcc/hosts
#put in your Mac's IP Address, CTRL+O to save, CTRL+X to exit
#for example my file contains only
192.168.200.25

#ON THE MAC

$ nano ~/.profile 

#if file exists the important thing is to insert 
# /usr/local/arm-linux/bin: right after PATH=
#this is mine
export PATH=/usr/local/arm-linux/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

$ source ~/.profile

#further steps will require Homebrew
$ ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

#this will download the install script below
$ curl -O https://gist.github.com/jvcleave/7149545/raw/c2274f09b734fba2a9ecfeeea45dbab84d53704c/install.sh
$ chmod +x install.sh
$ ./install.sh


#this will start the distcc server
#verbose will print messages that you can look at in the Mac Console (printed to system.log)
#my ip block is 192.168.200.0, change below to match yours 

$ distccd --daemon --allow 192.168.200.0/23 --no-detach --verbose


