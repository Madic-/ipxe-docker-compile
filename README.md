# ipxe-docker-compile

These docker files will build a docker image where the iPXE boot firmwares will be compiled and downloads latest wimboot binaries.

iPXE is a pxe boot firmware. More about iPXE at [http://ipxe.org](http://ipxe.org/).

First, it downloads the latest iPXE source code into the volume /compile, then copies custom iPXE configuration to ./{{ ipxe src }}/src/config/local/ and compiles the source code with **make all**.

An example custom iPXE configuration is provided in the ipxe.local.example folder.

At last it will download latest wimboot binaries to /compile/wimboot and extracts it.

An example docker-compose.example.yml is also provided.

## Volumes
This docker environment requires two volumes.

| Volume | Purpose |
|--------|---------|
|/compile | Location for build.log, latest wimboot and iPXE source code |
|/opt/ipxe.local| Custom iPXE configuration. All files will be copied to ./{{ ipxe src }}/src/config/local/ | 

## Usage

Build docker image and iPXE binaries

    docker-compose up -d --build

Only (re)build iPXE binaries if docker images already present

    docker-compose up -d
