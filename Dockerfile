FROM debian:bullseye
MAINTAINER Michael Neese <madic@geekbundle.org>

ENV HOME /root

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential git liblzma-dev mkisofs unzip wget coreutils isolinux

COPY ./build.sh /bin/build.sh

RUN chmod +x /bin/build.sh

VOLUME /compile /opt/ipxe.local

CMD ["/bin/build.sh"]
