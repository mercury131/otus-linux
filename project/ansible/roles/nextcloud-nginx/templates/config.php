<?php
$CONFIG = array (
  'instanceid' => 'oc4tjj473ta3s',
  'passwordsalt' => 'AqrQQvWv3FjiQk20jIY1DFJZpelHCL',
  'secret' => 'nXhQIMdyXO43W7zfJfRdX/L75H55TXtLyz3AWRw7TBywG0sx',
  'trusted_domains' =>
  array (
    0 => 'example.com',
  ),
  'datadirectory' => '/var/www/nextcloud/data',
  'dbtype' => '{{ dbtype }}',
  'dbhost' => '{{ dbhost }}',
  'dbname' => '{{ dbname }}',
  'dbuser' => '{{ dbuser }}',
  'dbpassword' => '{{ dbpassword }}',
  'version' => '18.0.3.0',
  'overwrite.cli.url' => 'http://{{ server_name }}/index.php',
  'installed' => false,
  'log_type' => 'owncloud',
  'logfile' => '/var/log/nextcloud.log',
  'loglevel' => '3',
  'logdateformat' => 'F d, Y H:i:s',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
);