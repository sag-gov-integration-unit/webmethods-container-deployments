ARG BIGMEMORY_KIT_URL
ARG BIGMEMORY_KIT_BASEDIR

## terracotta user/group
ARG SAG_HOME=/terracotta
ARG SAG_USER=terracotta
ARG SAG_USERID=1724
ARG SAG_USER_DESC="Software AG Terracotta user"
ARG SAG_GROUP=terracotta
ARG SAG_GROUPID=1724

# 1. define the base image to create this image from
######################################################################################################

FROM redhat/ubi8-minimal as base

ARG SAG_HOME
ARG SAG_USER
ARG SAG_USERID
ARG SAG_USER_DESC
ARG SAG_GROUP
ARG SAG_GROUPID

# add few utilities
RUN true \
    && microdnf install \
         shadow-utils \
         java-11-openjdk-devel \
         tar \
         openssl \
         ca-certificates \
    && microdnf clean all \
    && true

# Create saguser a process owner and group
RUN groupadd -g ${SAG_GROUPID} ${SAG_GROUP} && \
    useradd -s /bin/bash -u ${SAG_USERID} -m -g ${SAG_GROUPID} -d ${SAG_HOME} -c "${SAG_USER_DESC}" ${SAG_USER}

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
    && curl ${BIGMEMORY_KIT_URL} --output bigmemorykit.tar.gz \ 
    && tar xvf bigmemorykit.tar.gz \
    && rm -f bigmemorykit.tar.gz

# 3. Finalize the image
######################################################################################################

FROM base as final

LABEL maintainer="fabien.sanglier@softwareaggov.com"

ARG BIGMEMORY_KIT_BASEDIR
ARG SAG_HOME
ARG SAG_USER
ARG SAG_USERID
ARG SAG_USER_DESC
ARG SAG_GROUP
ARG SAG_GROUPID

# Path to the license file (usually, license mapped from volume mount)
# For backward compatibility, the Terracotta license is expected to be under the Terracotta folder, so no need to change this default here
ENV LICENSE_FILE="${SAG_HOME}/terracotta-license.key"
ENV JAVA_OPTS=""

RUN mkdir -p ${SAG_HOME}/extralibs ${SAG_HOME}/apis
RUN chown -R ${SAG_USER}:${SAG_GROUP} ${SAG_HOME}

# copy files from libs
COPY --from=bigmemory_kit --chown=${SAG_USER}:${SAG_GROUP} $BIGMEMORY_KIT_BASEDIR/apis/ ${SAG_HOME}/apis/
COPY --from=bigmemory_kit --chown=${SAG_USER}:${SAG_GROUP} $BIGMEMORY_KIT_BASEDIR/code-samples/lib/slf4j* ${SAG_HOME}/extralibs/

# copy code
COPY --chown=${SAG_USER}:${SAG_GROUP} ./src/ ${SAG_HOME}/

USER ${SAG_USER}

# This is the current working directory
WORKDIR ${SAG_HOME}

ENV CLASSPATH ".:${SAG_HOME}/apis/ehcache-ee-terracotta-client-all.jar\
:${SAG_HOME}/apis/ehcache/lib/\
:${SAG_HOME}/apis/toolkit/lib/\
:${SAG_HOME}/extralibs/"

ENV TERRACOTTA_SERVER_URL=""

RUN javac ClientDoingInsertionsAndRetrievals.java

ENTRYPOINT [ "sh", "-c", "java -Dcom.tc.productkey.path=$LICENSE_FILE $JAVA_OPTS ClientDoingInsertionsAndRetrievals" ]