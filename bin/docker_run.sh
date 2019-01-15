#! /bin/bash
set -e

docker run \
-d \
-it \
--name mc_server \
-p 19132:19132/udp \
-v `pwd`/data/downloads:/home/bedrock/downloads \
-v `pwd`/data/worlds:/home/bedrock/bedrock_server/worlds \
-v `pwd`/data/server.properties:/home/bedrock/bedrock_server/server.properties \
-v `pwd`/data/permissions.json:/home/bedrock/bedrock_server/permissions.json \
-v `pwd`/data/whitelist.json:/home/bedrock/bedrock_server/whitelist.json \
defektive/bedrock-server
