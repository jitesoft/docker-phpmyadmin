# Phpmyadmin

Data container for phpmyadmin using arbitrary hosts only as of now.  
Supposed to be running with external nginx/fpm containers.  
I would recommend persisting the `/phpmyadmin` folder with a data volume (as in example below), or the container will re-generate the blowfish secret on each restart (if that is a issue for you).

Example docker-compose file:

```yaml
version: '2'

services:

  nginxdata:
    image: busybox
    volumes:
      - "./nginx:/etc/nginx/conf.d:ro"

  pmadata:
    image: jitesoft/phpmyadmin:latest
    volumes:
      - pma-persist:/phpmyadmin

  nginx:
    image: nginx
    ports:
      - "80:80"
    volumes_from:
      - pmadata
      - nginxdata

  fpm:
    image: jite/php-fpm:7.1
    volumes_from:
      - pmadata
    working_dir: /phpmyadmin

volumes:
  pma-persist:
    driver: local
```