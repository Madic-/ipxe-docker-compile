# iPXE docker compile environment

These docker files will build a docker image where the iPXE boot firmwares will be compiled and downloads latest wimboot binaries.

iPXE is a pxe boot firmware. More about iPXE at [http://ipxe.org](http://ipxe.org/).

First, it downloads the latest iPXE source code into the volume /compile, then copies custom iPXE configuration to ./{{ ipxe src }}/src/config/local/ and compiles the source code with **make everything**. The binaries can be found in volume ./compile/ipxe/src/bin.

An example custom iPXE configuration is provided in the ipxe.local.example folder.

At last it will download latest wimboot binaries to /compile/wimboot and extracts it.

An example docker-compose.example.yml is also provided.

## Volumes

This docker environment requires two volumes.

| Volume | Purpose |
|--------|---------|
|/compile | Location for build.log, latest wimboot and iPXE source code |
|/opt/ipxe.local| Custom iPXE configuration. All files will be copied to ./{{ ipxe src }}/src/config/local/ | 

## Environment Variables

| Name | Default | Description |
| ---- | ------- | ----------- |
| ENV_BUILD | make -j4 everything | Build command. More Information about build targets [here](https://ipxe.org/appnote/buildtargets) |
| ENV_EMBEDD | EMPTY | Path to script within container which should be embedded |
| ENV_DEBUG | EMPTY | List of iPXE DEBUG objects that should be included at build time. See [here](http://ipxe.org/download#debug_builds) for more information |

## Usage

Create a copy from docker-compose.example.yml to docker-compose.yml and edit the file to reflect your requirements, e.g. volume locations.

Create a folder with your custom iPXE configuration, e.g. with name ipxe.local.

Build docker image and iPXE binaries

    docker-compose up -d --build

Only (re)build iPXE binaries if the docker image is already present

    docker-compose up -d
