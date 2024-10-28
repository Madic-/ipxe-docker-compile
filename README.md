# iPXE docker compile environment

These docker files will build a docker image where the iPXE boot firmwares will be compiled and downloads latest wimboot binaries.

iPXE is a pxe boot firmware. More about iPXE at [http://ipxe.org](http://ipxe.org/).

First, it downloads the latest iPXE source code into the volume **/compile**, then copies custom iPXE configuration to ./{{ ipxe src }}/src/config/local/ and compiles the source code with **make -j4 everything**. The binaries can be found in volume ./compile/ipxe/src/bin.

An example custom iPXE configuration is provided in the ipxe.local.example folder.

At last it will download latest wimboot binaries to **/compile/wimboot** and extracts it.

An example docker-compose.example.yml is also provided.

## Preparation

Create a copy from docker-compose.example.yml to docker-compose.yml and edit the file to reflect your requirements, e.g. volume locations

```shell
cp docker-compose.example.yml docker-compose.yml
```

Create a folder or copy the example with your custom iPXE configuration to ipxe.local

```shell
mkdir ipxe.local
# or
cp -r ipxe.local.example ipxe.local
```

## Usage

Build docker image and iPXE binaries

```shell
docker compose run --rm --build ipxe
```

Only (re)build iPXE binaries if the docker image is already present

```shell
docker compose run --rm ipxe
```

## Environment Variables

| Name | Default | Description |
| ---- | ------- | ----------- |
| ENV_BUILD | make -j4 everything | Build command. More Information about build targets [here](https://ipxe.org/appnote/buildtargets) |
| ENV_EMBEDD | EMPTY | Path to script within container which should be embedded |
| ENV_DEBUG | EMPTY | List of iPXE DEBUG objects that should be included at build time. See [here](http://ipxe.org/download#debug_builds) for more information |

Alternativ build target can be **make -j4 --makefile=./Makefile bin-i386-pcbios/ipxe.pxe bin-i386-pcbios/undionly.kpxe bin-x86_64-efi/ipxe.efi** to reduce build time

## Storage

This container uses the following paths:

| Internal Container Path | Purpose |
|--------|---------|
|/compile | Location for build.log, latest wimboot and iPXE source code |
|/opt/ipxe.local| Custom iPXE configuration. All files will be copied to ./{{ ipxe src }}/src/config/local/ | 
