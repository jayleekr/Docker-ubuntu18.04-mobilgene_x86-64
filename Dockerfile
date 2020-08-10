
FROM ubuntu:18.04

# Dev Tools
RUN apt-get update && apt-get install -y \
  sudo \
  apt-utils \
  xz-utils \
  build-essential \
  curl \
  less \
  wget \
  cmake \
  python \
  python-lxml \
  python3-pip \
  seccomp \
  vim \
  git

RUN pip3 install lxml jinja2 treelib

#install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run
RUN curl -fsSL https://code-server.dev/install.sh | sh

#install clang 6.0
RUN apt-get update && apt-get install -y software-properties-common
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -
RUN add-apt-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-6.0 main" && apt-get update
RUN apt-get update && apt-get install -y clang-6.0 lldb-6.0 lld-6.0

#install network utils
RUN apt-get update && apt-get install -y \
  net-tools \
  iproute2 \
  iputils-ping

#install debug utils
RUN apt-get update && apt-get install -y \
  gdb gdbserver

#install libjansson for wrsomeip
RUN apt-get update && apt-get install -y \
  libjansson-dev

#install doxygen
RUN apt-get update && apt-get install -y \
    doxygen \
    graphviz

#tsync dependencies
RUN apt-get update && apt-get install -y \
    libpcap-dev \
    libsnmp-dev

#cmake gui
RUN apt-get update && apt-get install -y \
    cmake-curses-gui \
    cmake-gui

#install tftp-hpa required by test framework
RUN apt-get install -y tftp-hpa

#install locales
RUN apt-get update && apt-get install -y \
    locales

#create mount points and set owner
RUN mkdir /adar
RUN mkdir /adar/build
RUN mkdir /adar/install
RUN mkdir /adar/projects

#executioin manager fifo directory creation
RUN mkdir -p /usr/run
RUN mkdir -p /usr/run/execution-manager

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD [ "/bin/bash" ]
