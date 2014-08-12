<?php
$password=$argv[1];
echo strtoupper(bin2hex(mhash(MHASH_MD4, iconv("UTF-8","UTF-16LE",$password))));

?>
