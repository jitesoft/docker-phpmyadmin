# Phpmyadmin

Data container for phpmyadmin using arbitrary hosts only as of now.  
Supposed to be running with external nginx/fpm containers.  
  
Example docker-compose:

```yaml
version: '2'

services:

  nginxdata:
    image: busybox
    volumes:
      - "./nginx:/etc/nginx/conf.d:ro"

  phpmyadmin:
    image: jitesoft/phpmyadmin:latest

  nginx:
    image: nginx
    ports:
      - "80:80"
    volumes_from:
      - phpmyadmin
      - nginxdata

  fpm:
    image: jite/php-fpm:7.1
    volumes_from:
      - phpmyadmin
    working_dir: /phpmyadmin
```