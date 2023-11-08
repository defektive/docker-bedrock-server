#!/bin/bash

if [ -z "$CURL_USER_AGENT" ]; then
  echo "[!] setting default user agent"
  CURL_USER_AGENT='Mozilla/5.0 (Garbage; Win64 x86_64) AppleWebKit/537.36 (KHTML, like Pizza)'
fi

if [ -z "$BEDROCK_LANDING_URL" ]; then
  echo "[!] setting default landing URL"
  BEDROCK_LANDING_URL='https://www.minecraft.net/en-us/download/server/bedrock'
fi

if [ -z "$BEDROCK_DOWNLOAD_ZIP" ]; then
  echo "[!] getting bedrock zip url from landing page"
  BEDROCK_DOWNLOAD_ZIP=`curl -A "$CURL_USER_AGENT" -s "$BEDROCK_LANDING_URL" | grep -oP 'https://minecraft.azureedge.net/bin-linux/([^"]+)'`
fi

echo CURL_USER_AGENT $CURL_USER_AGENT
echo BEDROCK_LANDING_URL $BEDROCK_LANDING_URL
echo BEDROCK_DOWNLOAD_ZIP $BEDROCK_DOWNLOAD_ZIP

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
  chmod +x ./bedrock_server
  LD_LIBRARY_PATH=. ./bedrock_server
  # ./bedrock_server
else
  echo "Server software not downloaded or unpacked!"
fi
