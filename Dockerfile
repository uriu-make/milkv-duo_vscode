FROM ubuntu:20.04

ARG USERNAME="user"
ARG REMOTE_USER="root"
ARG REMOTE_HOST="milkv-duo.local"
ARG PROJECT_DIR="/root"
ARG GDBSERVER_PORT="50000"

RUN useradd -m ${USERNAME}
RUN usermod -aG sudo ${USERNAME}
RUN usermod --shell /bin/bash ${USERNAME}

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    sudo \
    wget \
    bash-completion \
    gnupg2 \
    gdb \
    gdb-multiarch \
    rsync \
    make \
    cmake \
    git \
    nano \
    locales \
    avahi-utils \
    iputils-ping \
    cmake \
    x11-apps \
    libgl1-mesa-dev \
    xorg-dev

RUN mkdir -p /etc/sudoers.d/
RUN echo "${USERNAME} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USERNAME}
RUN chmod 440 /etc/sudoers.d/${USERNAME}
RUN touch /var/lib/sudo/lectured/${USERNAME}

ENV DISPLAY=:0
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
RUN mkdir -p /work/

ARG TOOLCHAIN_DIR=/work/duo-sdk/riscv64-linux-musl-x86_64

ENV TOOLCHAIN_PREFIX=${TOOLCHAIN_DIR}/bin/riscv64-unknown-linux-musl-
ENV SYSROOT=${MILKV_DUO_SDK}/rootfs
ENV CC=${TOOLCHAIN_PREFIX}gcc    
ENV CFLAGS="-mcpu=c906fdv -march=rv64imafdcv0p7xthead -mcmodel=medany -mabi=lp64d"
ENV LDFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64"
ENV REMOTE_USER=${REMOTE_USER}
ENV REMOTE_HOST=${REMOTE_HOST}
ENV PROJECT_DIR=${PROJECT_DIR}
ENV GDBSERVER_PORT=${GDBSERVER_PORT}

USER ${USERNAME}