FROM ubuntu:xenial
MAINTAINER David H. Spencer <dspencer@wustl.edu>

LABEL \
  description="BSMap image"

RUN apt-get update -y && apt-get install -y \
    wget \
    unzip \
    bzip2 \
    tar \
    g++ \
    gcc \
    zlib1g-dev \
    make
    
##############
#HTSlib 1.3.2#
##############
ENV HTSLIB_INSTALL_DIR=/opt/htslib

WORKDIR /tmp
RUN wget https://github.com/samtools/htslib/releases/download/1.3.2/htslib-1.3.2.tar.bz2 && \
    tar --bzip2 -xvf htslib-1.3.2.tar.bz2

WORKDIR /tmp/htslib-1.3.2
RUN ./configure  --enable-plugins --prefix=$HTSLIB_INSTALL_DIR && \
    make && \
    make install && \
    cp $HTSLIB_INSTALL_DIR/lib/libhts.so* /usr/lib/


###############
# bsmap
###############

ENV PLATYPUS_DIR=/opt/bsmap
RUN mkdir /opt/bsmap

WORKDIR /opt/bsmap
RUN wget http://lilab.research.bcm.edu/dldcc-web/lilab/yxi/bsmap/bsmap-2.90.tgz && \
    tar -zxvf bsmap-2.90.tgz

WORKDIR /opt/bsmap/bsmap-2.90/
RUN make && make install
