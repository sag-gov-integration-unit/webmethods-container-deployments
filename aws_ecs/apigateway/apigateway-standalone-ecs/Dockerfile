ARG BASE_IMAGE
FROM $BASE_IMAGE as base

# copy license file
COPY licenseKey.xml ${SAG_HOME}/IntegrationServer/instances/default/config/licenseKey.xml

HEALTHCHECK --interval=30s --start-period=600s CMD /bin/bash healthcheck.sh || exit 1