#!/bin/bash


BEDROCK_DOWNLOAD_ZIP=`curl -s https://minecraft.net/en-us/download/server/bedrock/ | grep -oP 'https://minecraft.azureedge.net/bin-linux/([^"]+)'`

echo using $BEDROCK_DOWNLOAD_ZIP

ZIPFILE=$(basename $BEDROCK_DOWNLOAD_ZIP)

if [ ! -f /home/bedrock/downloads/$ZIPFILE ]; then
   cd /home/bedrock/downloads
   echo "Downloading file"
   # Download and if successful, unzip (don't allow overwrites)
   curl --fail -O $BEDROCK_DOWNLOAD_ZIP
fi

cd /home/bedrock/bedrock_server
unzip -n ../downloads/$ZIPFILE

if [ -f "bedrock_server" ]; then
   for d in /home/bedrock/bedrock_server/worlds/*/resource_packs/*/ ; do
      echo "Symlinking resource pack $d"
      cd resource_packs
      ln -s "$d"
      cd -
   done
   for d in /home/bedrock/bedrock_server/worlds/*/behavior_packs/*/ ; do
      echo "Symlinking behaviour pack $d"
      cd behavior_packs
      ln -s "$d"
      cd -
   done
   echo "Executing server"
   LD_LIBRARY_PATH=. ./bedrock_server
else
   echo "Server software not downloaded or unpacked!"
fi
