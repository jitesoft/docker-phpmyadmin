FROM alpine
MAINTAINER Johannes Tegnér <johannes@jitesoft.com>

ENV VERSION 4.7.1

COPY ./config.inc.php /etc/phpmyadmin/
COPY ./secret.sh /secret.sh 

RUN chmod +x /secret.sh \
    && apk add --no-cache wget \
    && cd /tmp \
    && wget -O pma.tar.gz https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz --no-check-certificate \
    && tar xzf pma.tar.gz \
    && rm -f pma.tar.gz \
    && mv /tmp/phpMyAdmin-${VERSION}-all-languages /phpmyadmin \
    && cd /phpmyadmin \
    && rm -rf setup examples test po composer.json RELESE-DATE-{VERSION} \
    && sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /phpmyadmin/libraries/vendor_config.php \
    && mkdir /sessions \
    && touch /etc/phpmyadmin/config.secret.inc.php

VOLUME /phpmyadmin
VOLUME /etc/phpmyadmin

ENTRYPOINT [ "/secret.sh" ]
CMD ["/bin/sh"]