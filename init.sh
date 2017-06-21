#!/bin/sh
ORIG="/etc/phpmyadmin/config.php"
NEW="/config/config.inc.php"
BLOWFISH=""

if [ -e $NEW ]; then
  BLOWFISH=$(grep 'blowfish_secret' ${NEW})
  rm $NEW
fi

if [[ -z "$BLOWFISH" ]]; then
  echo "Blowfish key does not exists in the config."
  BLOWFISH="\$cfg['blowfish_secret'] = array_key_exists('blowfish_secret', \$cfg) ? \$cfg['blowfish_secret'] : '$(tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></;.,[]=-' < /dev/urandom | fold -w 32 | head -n 1)';";
fi

cat $ORIG > $NEW
echo $BLOWFISH >> $NEW
echo "Configuration updated and saved."
