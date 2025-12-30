FROM ghcr.io/bordeux/cstrike-server:latest

LABEL org.opencontainers.image.description="Counter Strike 1.6 for Bencownia.com"
LABEL org.opencontainers.image.source=https://github.com/bordeux/cstrike-bencownia

USER root
RUN mkdir -p /storage/data && chown -R steam:steam /storage
USER steam

COPY ./entrypoint.sh.d /usr/bin/entrypoint.sh.d
RUN mv ${CSTRIKE_BASE_PATH} ${CSTRIKE_PATH} && touch ${CSTRIKE_PATH}/.installed

ENV AMXMODX_AUTOCOMPILE=0
ENV HLTV_ENABLE=1
COPY --chown=steam:steam ./cstrike ${CSTRIKE_PATH}

RUN ${HELPERS_PATH}/amxmodx-compile.sh ${CSTRIKE_PATH}/addons/amxmodx
