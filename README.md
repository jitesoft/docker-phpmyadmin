# Phpmyadmin

Data container for phpmyadmin using arbitrary hosts only as of now.  
Supposed to be running with external nginx/fpm containers.  

Configuration files are stored in the `/config` folder, it's a good idea to persist this folder so that the blowfish secret is not re-generated on each restart. In the example below I use a named volume to persist the `/config` dir.  
The configuration will look for a `config.user.inc.php` file in the `/config` dir and if it finds it, it will load it, that way one can override the default settings with a new configuration.  


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
      - pma-persist:/config

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