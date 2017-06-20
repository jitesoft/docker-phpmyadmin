<?php

require('/etc/phpmyadmin/config.secret.inc.php');

$cfg['AllowArbitraryServer'] = true;

/* Include User Defined Settings Hook */
if (file_exists('/etc/phpmyadmin/config.user.inc.php')) {
    include('/etc/phpmyadmin/config.user.inc.php');
}