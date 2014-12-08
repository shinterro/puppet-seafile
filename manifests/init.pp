# == Class: seafile
#
# A Puppet Module for Seafile
#
# Requires mysql, python2.7, nginx

class seafile (
  $releasever      = $::seafile::params::releasever,
  $source          = $::seafile::params::source,
  $url             = $::seafile::params::url,
  $filename        = $::seafile::params::filename,
  $webserver       = $::seafile::params::webserver,
  $servername      = $::seafile::params::servername,
  $server_ip       = $::seafile::params::server_ip,
  $config_seafile  = $::seafile::params::config_seafile,
  $ssl             = $::seafile::params::ssl,
  $dbtype          = $::seafile::params::dbtype,
  $admin_email     = $::seafile::params::admin_email,
  $admin_password  = $::seafile::params::admin_password,
  $ccnet_port      = $::seafile::params::ccnet_port,
  $seafile_port    = $::seafile::params::seafile_port,
  $httpserver_port = $::seafile::params::httpserver_port,
  $install_dir     = $::seafile::params::install_dir,
  $sql_host        = $::seafile::params::sql_host,
  $sql_db          = $::seafile::params::sql_db,
  $sql_user        = $::seafile::params::sql_user,
  $sql_password    = $::seafile::params::sql_password,
  $sql_port        = $::seafile::params::sql_port,
  $seafile_domain  = $::seafile::params::seafile_domain,
  $ccnet_db        = $::seafile::params::ccnet_db,
  $seafile_db      = $::seafile::params::seafile_db,
  $seahub_db       = $::seafile::params::seahub_db,
  $seaf_db_user    = $::seafile::params::seaf_db_user,
  $seaf_db_pass    = $::seafile::params::seaf_db_pass,

  # Media content location
  $seafile_data_dir = $::seafile::params::seafile_data_dir

) inherits seafile::params {
  
  #validate_bool($nginx)
  
  class { 'seafile::install': } ->
  class { 'seafile::config': } ->
  Class['seafile']
}

  # TODO - Make sure version changes are idempotent
  # TODO - Offer option to use existing database (possibly)
        
