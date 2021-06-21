FROM nginx:alpine

# nginx conf files
COPY conf/ /etc/nginx/

# create the DIRs for the sites to enable
RUN mkdir -p /etc/nginx/sites-enabled/ && mkdir -p /etc/nginx/sites-tcp/