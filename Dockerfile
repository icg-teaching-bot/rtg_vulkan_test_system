FROM nvidia/cudagl:11.4.1-devel
LABEL maintainer "Thomas Neff <thomas.neff@icg.tugraz.at>"

RUN apt-get update && apt-get install --yes --no-install-recommends software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc-8 g++-8 \
    cmake \
    ninja-build \
    xorg-dev \
    libgl1-mesa-dev \
    xvfb \
    imagemagick \
    ghostscript \
    python3-numpy \
    x11-utils \
    xdotool \
    ffmpeg \
    wget \
    unzip \
    wmctrl \
    libglm-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
  
VULKAN_SDK_VERSION='1.2.182.0'
ENV VULKAN_SDK_VERSION=$VULKAN_SDK_VERSION
RUN echo "downloading Vulkan SDK $VULKAN_SDK_VERSION" \
    && wget -q --show-progress --progress=bar:force:noscroll https://sdk.lunarg.com/sdk/download/$VULKAN_SDK_VERSION/linux/vulkansdk-linux-x86_64-$VULKAN_SDK_VERSION.tar.gz?Human=true -O /tmp/vulkansdk-linux-x86_64-$VULKAN_SDK_VERSION.tar.gz \
    && echo "installing Vulkan SDK $VULKAN_SDK_VERSION" \
    && mkdir -p /opt/vulkan \
    && tar -xf /tmp/vulkansdk-linux-x86_64-$VULKAN_SDK_VERSION.tar.gz -C /opt/vulkan \
    && rm /tmp/vulkansdk-linux-x86_64-$VULKAN_SDK_VERSION.tar.gz

ENV DISPLAY=:0
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
