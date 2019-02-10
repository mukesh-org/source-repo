# base this image on the PHP image that comes with Apache https://hub.docker.com/_/php/
FROM php:7.0-apache

RUN apt-get update \
  && apt-get install -y curl \
  && docker-php-ext-install \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives

# take the contents of the local html/ folder, and copy to /var/www/html/ inside the container
# this is the expected web root of the default website for this server, so put your index.php here
COPY html/ /var/www/html/

# take the contents of the local script/ folder, and copy to /tmp/ inside the container
# we can run one-time scripts, downloads, and other initial processes from /tmp/
COPY script/ /tmp/
