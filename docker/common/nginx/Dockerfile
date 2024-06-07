FROM nginx:1.25-alpine

# remove default site
RUN rm /etc/nginx/conf.d/default.conf

# nginx conf files
COPY conf/*.conf /etc/nginx/conf.d/