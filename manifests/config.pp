class seafile::config {
  
  user { "${seafile::params::seaf_db_user}":
    ensure => present,
    gid    => $seafile::params::seaf_db_group,
  }
  
  group { "${seafile::params::seaf_db_group}":
    ensure => present,
  }
  
  file { "${seafile::params::install_dir}/ccnet.conf":
    ensure  => present,
    replace => true, # TODO - Review Consequences of replace
    owner   => $seafile::params::seaf_db_user,
    group   => $seafile::params::seaf_db_group,
    mode    => '0644', # TODO - Review permissions.
    content => template("seafile/ccnet.conf.erb"),
  }
  file { "${seafile::params::install_dir}/seafdav.conf":
    ensure  => present,
    replace => false,
    owner   => $seafile::params::seaf_db_user,
    group   => $seafile::params::seaf_db_group,
    mode    => '0644',
    content => template("seafile/seafdav.conf.erb"),
  }
  notify{"Install dir is: ${seafile::params::install_dir}": }
  file { "${seafile::params::install_dir}/seahub_settings.py":
    ensure  => present,
    replace => false,
    owner   => $seafile::params::seaf_db_user,
    group   => $seafile::params::seaf_db_group,
    mode    => '0644',
    content => template("seafile/seahub_settings.py.erb"),
  }
  
  mysql::db { $seafile::params::seafile_db:
    user     => $seafile::params::seaf_db_user,
    password => $seafile::params::seaf_db_pass,
    host     => $seafile::params::sql_host,
    grant    => ['all'],
  }
  mysql::db { $seafile::params::seahub_db:
    user     => $seafile::params::seaf_db_user,
    password => $seafile::params::seaf_db_pass,
    host     => $seafile::params::sql_host,
    grant    => ['all'],
  }
  mysql::db { $seafile::params::ccnet_db:
    user     => $seafile::params::seaf_db_user,
    password => $seafile::params::seaf_db_pass,
    host     => $seafile::params::sql_host,
    grant    => ['all'],
  }
  
  # Will likely replace with nginx module configs.
  #if $seafile::params::webserver == 'nginx' {
  #  file { "/etc/nginx/conf.d/seafile.conf":
  #    ensure  => present,
  #    replace => false,
  #    owner   => 'seaf',
  #    group   => 'seaf',
  #    mode    => '0644',
  #    content => template("seafile/seafile.conf.erb"),
  #  }
  #}
}

# TODO - Creat user seafile, or other specified user.

