ARG NODE_VERSION

FROM node:${NODE_VERSION}-bookworm-slim

# Install all dependencies in a single layer to minimize image size
RUN echo "deb http://deb.debian.org/debian bookworm contrib" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    # Install fonts (accept EULA for Microsoft fonts)
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    apt-get install -y --no-install-recommends \
        fontconfig \
        ttf-mscorefonts-installer && \
    fc-cache -f && \
    find /usr/share/fonts/truetype/msttcorefonts/ -type l -exec unlink {} \; 2>/dev/null || true && \
    # Install OS dependencies
    apt-get install -y --no-install-recommends \
        git \
        openssh-client \
        openssl \
        graphicsmagick \
        tini \
        tzdata \
        ca-certificates \
        wget && \
    # Install full-icu
    npm install -g full-icu@1.5.0 && \
    # Cleanup
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /root/.npm /root/.cache/node /opt/yarn*

WORKDIR /home/node
ENV NODE_ICU_DATA=/usr/local/lib/node_modules/full-icu
EXPOSE 5678/tcp
