ARG BUILDER_IMAGE

# 1. define the base image to create this image from
######################################################################################################

FROM openjdk:8-jdk-alpine as base

# 2. Define the builder, where we'll execute Product Installation and patching
######################################################################################################

FROM $BUILDER_IMAGE as builder

# 3. Finalize the image
######################################################################################################

FROM base as final

LABEL maintainer="fabien.sanglier@softwareaggov.com"

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

# copy files from builder
COPY --from=builder --chown=terracotta:terracotta $SAG_HOME/Terracotta/apis/ /terracotta/apis/
COPY --from=builder --chown=terracotta:terracotta $SAG_HOME/Terracotta/code-samples/ /terracotta/code-samples/

# copy code
COPY --chown=terracotta:terracotta ./src/ /terracotta/

USER terracotta

# This is the current working directory
WORKDIR /terracotta/

ENV CLASSPATH ".:/terracotta/apis/ehcache-ee-terracotta-client-all.jar\
:/terracotta/apis/ehcache/lib/\
:/terracotta/apis/toolkit/lib/\
:/terracotta/code-samples/lib/slf4j-jdk14-1.7.25.jar"

ENV TERRACOTTA_SERVER_URL=""

RUN javac ClientDoingInsertionsAndRetrievals.java

ENTRYPOINT [ "sh", "-c", "java -Dcom.tc.productkey.path=$LICENSE_FILE $JAVA_OPTS ClientDoingInsertionsAndRetrievals" ]