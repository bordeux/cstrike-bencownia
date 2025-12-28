FROM ghcr.io/bordeux/cstrike-server:latest
ENV AMXMODX_AUTOCOMPILE=0
COPY ./cstrike ${CSTRIKE_BASE_PATH}
RUN ${HELPERS_PATH}/amxmodx-compile.sh ${CSTRIKE_BASE_PATH}/addons/amxmodx
