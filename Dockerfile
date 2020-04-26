FROM nginx
RUN apt-get update && \
 apt-get install -y \
 nano \
 && rm -rf /var/lib/apt/lists/*
COPY html /usr/share/nginx/html
COPY conf /etc/nginx
COPY certs /etc/letsencrypt/live/cctv.hosted-servers.uk/