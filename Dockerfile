FROM python:3.7-slim

# 设置环境变量，避免交互式安装提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的构建工具和依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        pkg-config \
        libpng-dev \
        python3 \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

# 克隆 mozjpeg 源代码
RUN git clone https://github.com/mozilla/mozjpeg.git

# 创建构建目录并构建
WORKDIR /mozjpeg
RUN mkdir build && cd build && \
    cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr/local/mozjpeg .. && \
    make && \
    make install && \
    ln -s /usr/local/mozjpeg/bin/* /usr/local/bin/ && \
    cd ../.. && \
    rm -rf /mozjpeg


# 安装 Python 依赖
RUN pip3 install --no-cache-dir -r requirements.txt
