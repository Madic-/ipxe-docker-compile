#!/bin/bash

start=$(date +%s)

if [ -z "$ENV_BUILD" ]; then
    CMD_BUILD="make -j4 everything"
else
    CMD_BUILD="$ENV_BUILD"
fi

if [ -z "$ENV_EMBEDD" ]; then
    CMD_EMBEDD=
else
    CMD_EMBEDD="EMBED=$ENV_EMBEDD"
fi

if [ -z "$ENV_DEBUG" ]; then
    CMD_DEBUG=""
else
    CMD_DEBUG="DEBUG=$ENV_DEBUG"
fi

DIR_IPXE=/compile/ipxe
DIR_WIMBOOT=/compile/wimboot
DIR_LOGS=/compile/logs

if [ ! -d "$DIR_WIMBOOT" ]; then mkdir -p "$DIR_WIMBOOT"; fi
if [ ! -d "$DIR_LOGS" ]; then mkdir -p "$DIR_LOGS"; fi

# Write log to file
exec &>$DIR_LOGS/build.log

# Download and compile ipxe
if [ -d $DIR_IPXE/.git ]; then
	echo "Updating ipxe repository..."
	cd $DIR_IPXE || exit
	git pull
	echo
else
	echo "Cloning ipxe repository..."
	git clone git://git.ipxe.org/ipxe.git $DIR_IPXE
	echo
fi
if [ -n "$(ls -A /opt/ipxe.local)" ]; then echo "Copying custom configuration..."; echo; cp /opt/ipxe.local/* $DIR_IPXE/src/config/local/; fi
cd $DIR_IPXE/src || exit
echo "Building ipxe..."
$CMD_BUILD $CMD_EMBEDD $CMD_DEBUG

echo

# Download and extract latest wimboot
echo "Downloading and extracting latest wimboot..."
cd $DIR_WIMBOOT || exit
rm -rf ./wimboot-latest.zip
wget http://git.ipxe.org/releases/wimboot/wimboot-latest.zip
unzip -o wimboot-latest.zip

end=$(($(date +%s) - $start))
runtime=$(date -u -d @${end} +"%T")

echo
echo "****** BUILD FINISHED ******"
echo "Build runtime: $runtime"
