#!/bin/sh
CONFIG_DIR="/phpmyadmin/config/"
SECRET_CNF="config.secret.inc.php"

if [ ! -f ${CONFIG_DIR}${SECRET_CNF} ] ; then
  echo "First start, generating new blowfish secret."
  cat > ${CONFIG_DIR}${SECRET_CNF} <<EOT
<?php
\$cfg['blowfish_secret'] = '$(tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-' < /dev/urandom | fold -w 32 | head -n 1)';
EOT
fi
