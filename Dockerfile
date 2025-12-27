FROM ghcr.io/bordeux/cstrike-server:latest as base

COPY ./cstrike ${HLDS_PATH}/cstrike_base