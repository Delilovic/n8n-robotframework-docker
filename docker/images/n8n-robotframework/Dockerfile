ARG N8N_VERSION

FROM delilovic/n8n:${N8N_VERSION}-bookworm-slim

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip curl && \
    pip3 install --no-cache-dir --break-system-packages \
        robotframework==7.4.1 \
        robotframework-browser==19.12.3 \
        robotframework-jsonlibrary==0.5 && \
    npx playwright install-deps && \
    rfbrowser init

# Install Node.js packages
RUN npm install -g \
        weaviate-client@3.8.1 \
        @mozilla/readability@0.6.0 \
        @postlight/parser@2.2.3

USER node
