#!/bin/bash
# This command allows you to run docker
docker compose run --rm --build ipxe

# The next line is an example of how to copy the .. file
# to your server.  The name is changed on the server
# so that you can configure your image according to the client.
# (Here the DHCP server would need to set ha_undionly.kpxe as
#  the image)
# scp compile/ipxe/src/bin-x86_64-pcbios/undionly.kpxe root@arg1:/usr/local/tftp/ha_undionly.kpxe
