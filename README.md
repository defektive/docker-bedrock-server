# Docker Bedrock Server

Do not use this, unless you agree to https://minecraft.net/terms and https://go.microsoft.com/fwlink/?LinkId=521839

This is a helper program to help people get a minecraft server up and running quickly. It will download the latest server, so make sure you agree to the terms above.

## Getting started

### Build

```
bin/build_docker.sh
```

### Configure

Modify files in `data/` to your liking. Add world folders to `data/worlds/`

### Run

```
bin/docker_run.sh
```

## Special Thanks

Much of this was ripped from [BoxOfSnoo/docker-bedrockserver](https://github.com/BoxOfSnoo/docker-bedrockserver) and then modified to my use case.
