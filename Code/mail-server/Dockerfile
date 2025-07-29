FROM ubuntu:24.04

# Avoid waiting for input during interactive installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    postfix \
    dovecot-core \
    dovecot-imapd \
    dovecot-lmtpd \
    rsyslog \
    mailutils \
    procps \
    nano \
    iputils-ping \
    net-tools \
    iproute2 \
    automake \
    autoconf \
    libtool \
    m4 \
    gcc \
    make \
    tcpdump \
    pkg-config \
    libglib2.0-dev \
    libssl-dev \
    software-properties-common gpg-agent \
    cmake \
    meson \
    python3-venv python3-pytest python3-dnslib
    # && apt-get clean \
    # && rm -rf /var/lib/apt/lists/*

# 安装thunderbird
RUN add-apt-repository ppa:mozillateam/ppa
RUN cat <<EOF > /etc/apt/preferences.d/mozilla-ppa
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
RUN apt-get update && apt-get install -y thunderbird

WORKDIR /usr/local/src
COPY mbedtls-2.28.8/ ./mbedtls-2.28.8
RUN chmod -R +x mbedtls-2.28.8
COPY ION-DTN/ ./ION-DTN
RUN chmod -R +x ION-DTN
COPY gmime-3.2.15/ ./gmime-3.2.15
RUN chmod -R +x gmime-3.2.15
COPY c-ares-1.34.4/ ./c-ares-1.34.4
RUN chmod -R +x c-ares-1.34.4
COPY bpmail/ ./bpmail
RUN chmod -R +x bpmail

#安装ION-DTN和加密套件
WORKDIR /usr/local/src/mbedtls-2.28.8
RUN make SHARED=1 && make install

WORKDIR /usr/local/src/ION-DTN
RUN autoreconf -fi \
	&& ./configure --enable-crypto-mbedtls --enable-bpsec-debugging \
    && make \
    && make install \
    && ldconfig

#安装bpmail和其依赖gmime、c-ares
WORKDIR /usr/local/src/gmime-3.2.15
RUN ./configure --prefix=/usr --disable-static && make
RUN make install

WORKDIR /usr/local/src/c-ares-1.34.4
RUN mkdir build \
    && cd build \
    && cmake -D CMAKE_INSTALL_PREFIX=/usr .. \
    && make \
    && make install

WORKDIR /usr/local/src/bpmail
# RUN python3 -m venv venv1 \
#     && source venv1/bin/activate \
#     && pip install dnslib pytest
RUN meson setup build \
    && meson compile -C build \
    && meson install -C build

#安装postfix+dovecot
COPY mail-server.sh /mail-server.sh
RUN chmod +x /mail-server.sh

EXPOSE 25 143

CMD ["/mail-server.sh"]
