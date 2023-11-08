FROM debian

CMD ["/sbin/my_init"]

RUN apt-get update \
  && apt-get -y install curl unzip openssl libc-bin libc6 \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && useradd -ms /bin/bash bedrock \
  && su - bedrock -c "mkdir -p bedrock_server/data/worlds" \
  && chown -R bedrock:bedrock /home/bedrock/bedrock_server/data/worlds

EXPOSE 19132/udp
COPY ./startup.sh /home/bedrock
ENTRYPOINT /home/bedrock/startup.sh
