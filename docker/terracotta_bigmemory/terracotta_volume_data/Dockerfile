ARG REG_BIGMEMORY
ARG REPO_BIGMEMORY
ARG TAG_BIGMEMORY

FROM ${REG_BIGMEMORY}${REPO_BIGMEMORY}:${TAG_BIGMEMORY}

USER root

RUN mkdir -p /data /index /backup \
  && chown -R sagadmin:sagadmin /data /index /backup

VOLUME /data
VOLUME /index
VOLUME /backup

USER sagadmin