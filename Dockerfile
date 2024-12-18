# 使用 Python 3.7 的精简版作为基础镜像
FROM python:3.7-slim

# 设置环境变量，避免交互式安装提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的构建工具和依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        autoconf \
        automake \
        libtool \
        nasm \
        wget \
        git && \
    rm -rf /var/lib/apt/lists/*

# 克隆并安装 mozjpeg
RUN git clone https://github.com/mozilla/mozjpeg.git && \
    cd mozjpeg && \
    autoreconf -fiv && \
    ./configure --prefix=/usr/local/mozjpeg && \
    make && \
    make install && \
    ln -s /usr/local/mozjpeg/bin/* /usr/local/bin/ && \
    cd .. && \
    rm -rf mozjpeg
