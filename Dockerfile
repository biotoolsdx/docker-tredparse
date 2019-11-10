FROM ubuntu:16.04
MAINTAINER Chen Yuelong <yuelong.chen.btr@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ARG tredparse_version=v0.7.5
ARG samtools_version=1.9



RUN apt-get update
RUN apt-get install -y gcc git build-essential python-dev libxml2-dev libxslt-dev libncurses-dev \
                        libcurl4-openssl-dev zlib1g-dev vcftools python-pip libblas-dev liblapack-dev \
                        libatlas-base-dev gfortran wget libbz2-dev liblzma-dev
RUN pip install --upgrade pip
RUN pip install boto3 awscli pyfaidx pyliftover pyvcf cython pandas scipy==1.2.2 && \
    cd /tmp/ && \
    wget https://github.com/samtools/samtools/releases/download/$samtools_version/samtools-$samtools_version.tar.bz2 && \
    tar -jxvf samtools-$samtools_version.tar.bz2 && \
    cd samtools-$samtools_version && \
    ./configure && make && make install && \
    pip install pysam==0.9.1 &&  pip install git+https://github.com/humanlongevity/tredparse.git@$tredparse_version


RUN apt-get clean && \
    apt-get remove --yes --purge wget git && \
    rm -rf /tmp/*


CMD bash




