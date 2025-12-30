FROM ghcr.io/bordeux/cstrike-server:latest

LABEL org.opencontainers.image.description="Counter Strike 1.6 for Bencownia.com"
LABEL org.opencontainers.image.source=https://github.com/bordeux/cstrike-bencownia

USER root
RUN mkdir -p /storage/data && chown -R steam:steam /storage

USER steam
COPY ./entrypoint.sh.d /usr/bin/entrypoint.sh.d
ENV AMXMODX_AUTOCOMPILE=1
ENV HLTV_ENABLE=1
COPY --chown=steam:steam ./cstrike ${CSTRIKE_PATH}

