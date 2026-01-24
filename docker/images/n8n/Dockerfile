ARG NODE_VERSION

FROM delilovic/n8n_base:${NODE_VERSION}-bookworm-slim

ARG N8N_VERSION
ARG N8N_RELEASE_TYPE=dev
ENV NODE_ENV=production
ENV N8N_RELEASE_TYPE=${N8N_RELEASE_TYPE}
ENV NODE_ICU_DATA=/usr/local/lib/node_modules/full-icu
ENV SHELL=/bin/sh

WORKDIR /home/node

COPY docker/images/n8n/docker-entrypoint.sh /

RUN npm install -g n8n@${N8N_VERSION} && \
    mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node && \
    rm -rf /root/.npm /tmp/* || true

EXPOSE 5678/tcp
USER node
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]

LABEL org.opencontainers.image.title="n8n" \
      org.opencontainers.image.description="Workflow Automation Tool" \
      org.opencontainers.image.source="https://github.com/n8n-io/n8n" \
      org.opencontainers.image.url="https://n8n.io" \
      org.opencontainers.image.version=${N8N_VERSION}
