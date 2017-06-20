FROM alpine
MAINTAINER Johannes Tegnér <johannes@jitesoft.com>

ENV VERSION 4.7.1

RUN apk add --no-cache wget \
    && cd /tmp \
    && wget -O pma.tar.gz https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz --no-check-certificate \
    && tar xzf pma.tar.gz \
    && rm -f pma.tar.gz \
    && mv /tmp/phpMyAdmin-${VERSION}-all-languages /phpmyadmin \
    && cd /phpmyadmin \
    && rm -rf setup examples test po composer.json RELESE-DATE-{VERSION} \
    && mkdir /phpmyadmin/config \
    && sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/phpmyadmin/config');@" /phpmyadmin/libraries/vendor_config.php \
    && mkdir /sessions \
    && apk del --no-cache wget

ADD ./includes /etc/phpmyadmin
RUN cp /etc/phpmyadmin/config.inc.php /phpmyadmin/config/config.inc.php
VOLUME [ "/phpmyadmin" ]

CMD [ "/bin/ash", "-C", "/etc/phpmyadmin/init.sh" ]