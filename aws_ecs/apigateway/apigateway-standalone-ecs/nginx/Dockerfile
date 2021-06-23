FROM nginx:alpine

# nginx conf files
COPY conf/ /etc/nginx/

# create the DIRs for the sites to enable
RUN mkdir -p /etc/nginx/sites-enabled/ && mkdir -p /etc/nginx/sites-tcp/

# copy the proxy confg for apigateway
COPY apigateway.conf /etc/nginx/sites-enabled/

HEALTHCHECK --interval=5s --timeout=2s --start-period=10s CMD curl --fail http://localhost/nginx-health || exit 1