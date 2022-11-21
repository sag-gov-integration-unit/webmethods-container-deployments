ARG BIGMEMORY_KIT_URL
ARG BIGMEMORY_KIT_BASEDIR

# 1. define the base image to create this image from
######################################################################################################

FROM openjdk:8-jdk-alpine as base

# 2. Define the builder, where we'll execute Product Installation and patching
######################################################################################################

FROM redhat/ubi8-minimal as bigmemory_kit

ARG BIGMEMORY_KIT_URL

RUN true \
    && microdnf install \
         tar \
         gzip \
    && microdnf clean all \
    && true

## jdbc drivers - should put in S3 for better consistency 
RUN mkdir -p /libs && cd /libs \
    && curl $BIGMEMORY_KIT_URL --output bigmemorykit.tar.gz \ 
    && tar xvf bigmemorykit.tar.gz \
    && rm -f bigmemorykit.tar.gz

# 3. Finalize the image
######################################################################################################

FROM base as final

LABEL maintainer="fabien.sanglier@softwareaggov.com"

ARG BIGMEMORY_KIT_BASEDIR
ARG SAG_HOME=/opt/softwareag
ENV SAG_HOME ${SAG_HOME}

# add few utilities, upgrade tar
RUN apk --update add tar openssl ca-certificates bash

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/

# Path to the license file (usually, license mapped from volume mount)
# For backward compatibility, the Terracotta license is expected to be under the Terracotta folder, so no need to change this default here
ENV LICENSE_FILE="/terracotta/terracotta-license.key"
ENV JAVA_OPTS=""

# adding the user terracotta, to not run the server as root
RUN addgroup -S terracotta && adduser -h /terracotta -s /bin/bash -G terracotta -S -D terracotta
RUN chown -R terracotta:terracotta /terracotta
RUN mkdir -p /terracotta/extralibs /terracotta/apis

# copy files from libs
COPY --from=bigmemory_kit --chown=terracotta:terracotta $BIGMEMORY_KIT_BASEDIR/apis/ /terracotta/apis/
COPY --from=bigmemory_kit --chown=terracotta:terracotta $BIGMEMORY_KIT_BASEDIR/code-samples/lib/slf4j* /terracotta/extralibs/

# copy code
COPY --chown=terracotta:terracotta ./src/ /terracotta/

USER terracotta

# This is the current working directory
WORKDIR /terracotta/

ENV CLASSPATH ".:/terracotta/apis/ehcache-ee-terracotta-client-all.jar\
:/terracotta/apis/ehcache/lib/\
:/terracotta/apis/toolkit/lib/\
:/terracotta/extralibs/"

ENV TERRACOTTA_SERVER_URL=""

RUN javac ClientDoingInsertionsAndRetrievals.java

ENTRYPOINT [ "sh", "-c", "java -Dcom.tc.productkey.path=$LICENSE_FILE $JAVA_OPTS ClientDoingInsertionsAndRetrievals" ]