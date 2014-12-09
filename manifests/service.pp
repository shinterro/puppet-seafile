# TODO - Add fastcgi
class seafile::service {
  exec { "seafile_sh":
    command => "seafile.sh start",
    path    => $seafile::params::install_dir/seafile-server-latest,
  }
  exec { "seahub_sh":
    command => "seahub.sh start",
    path    => $seafile::params::install_dir/seafile-server-latest,
  }
}