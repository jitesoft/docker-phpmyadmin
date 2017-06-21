<?php
$cfg['AllowArbitraryServer'] = true;

/* Include User Defined Settings Hook */
if (file_exists('/config/config.user.inc.php')) {
    include('/config/config.user.inc.php');
}

