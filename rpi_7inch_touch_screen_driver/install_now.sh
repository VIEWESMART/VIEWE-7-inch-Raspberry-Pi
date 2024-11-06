#Set up the script to run the interpreter
#!/bin/bash

#Appends the second parameter string to the end of the first parameter file
Data_Insertion()
{
	if grep -w -q ^$2 $1
	then
	    echo "It already exists and does not need to be added"
	else
	    echo $2 >> $1
	fi
}


#Driver Start Settings
echo "Driver Start Settings"

#Jump to the driver package directory
cd ./Driver_binary

#Move driver file
sudo cp panel-raspberrypi-dsi.ko /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/panel/
sudo cp vc4-kms-dsi-raspberrypi.dtbo /boot/firmware/overlays


sudo cp touch_gt911.dtbo /boot/firmware/overlays


#Jump to the driver installation directory
cd /lib/modules/$(uname -r)

#Install driver
sudo depmod


cd /lib/modules/$(uname -r)/kernel/drivers/gpu/drm/panel
sudo modprobe panel-raspberrypi-dsi
#Jump to the config configuration directory
cd /boot/firmware

#set config 
Data_Insertion config.txt  "ignore_lcd=1"
Data_Insertion config.txt  "dtoverlay=vc4-kms-v3d"
Data_Insertion config.txt  "dtparam=i2c_vc=on"
Data_Insertion config.txt  "dtparam=i2c_arm=on"
Data_Insertion config.txt  "dtoverlay=vc4-kms-dsi-raspberrypi"
Data_Insertion config.txt  "dtoverlay=touch_gt911"


#Driver end Settings
echo "Driver end Settings"


