#!/bin/bash

if [ -n "$SHELL_DEBUG" ]; then
	set -x
fi

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

## Exit if command fails on non-zero status code and exit on empty variable
set -eu
## Change script return code to the last command to exit with a non-zero status
set -o pipefail

DIR_IPXE=/compile/ipxe
DIR_WIMBOOT=/compile/wimboot
DIR_LOGS=/compile/logs

if [ ! -d "$DIR_WIMBOOT" ]; then mkdir -p "$DIR_WIMBOOT"; fi
if [ ! -d "$DIR_LOGS" ]; then mkdir -p "$DIR_LOGS"; fi

# Write log to file
exec &> >(tee "$DIR_LOGS/build-$(date +%Y-%m-%d\ %H:%M:%S.%3N).log")

# Download and compile ipxe
if [ -d $DIR_IPXE/.git ]; then
	echo "$(date) Updating ipxe repository..."
	cd $DIR_IPXE || exit
	git pull
	echo
else
	echo "$(date) Cloning ipxe repository..."
	timeout 5 git clone https://github.com/ipxe/ipxe.git $DIR_IPXE
	echo
fi
if [ -n "$(ls -A /opt/ipxe.local)" ]; then
	echo "$(date) Copying custom configuration..."
	echo
	cp /opt/ipxe.local/* $DIR_IPXE/src/config/local/
fi
cd $DIR_IPXE/src || exit
echo "$(date) Building ipxe..."
# Don't quote. Bash doesn't execute the command when quoted
$CMD_BUILD $CMD_EMBEDD $CMD_DEBUG

echo

echo "$(date) Downloading and extracting latest wimboot..."
cd $DIR_WIMBOOT || exit
if [ -f ./wimboot-latest.zip ]; then
	rm -rf ./wimboot-latest.zip
fi
wget http://git.ipxe.org/releases/wimboot/wimboot-latest.zip
unzip -o wimboot-latest.zip

end=$(($(date +%s) - $start))
runtime=$(date -u -d @${end} +"%T")

echo
echo "$(date) ****** BUILD FINISHED ******"
echo "$(date) Build runtime: $runtime"
