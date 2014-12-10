# http://www.kodkast.com/blogs/puppet/how-to-deploy-tarball
define tarball($pkg_tgz, $module_name, $install_dir) {

    # create the install directory
    file { "$install_dir":
        ensure  => directory,
    }

    # download the tgz file
    file { "$pkg_tgz":
        path    => "/tmp/$pkg_tgz",
        source  => "puppet:///modules/$module_name/$pkg_tgz",
        notify  => Exec["untar $pkg_tgz"],
    }

    # untar the tarball at the desired location
    exec { "untar $pkg_tgz":
        command => "/bin/rm -rf $install_dir/*; /bin/tar xzvf /tmp/$pkg_tgz -C $install_dir/",
        refreshonly => true,
        require => File["/tmp/$pkg_tgz", "$install_dir"],
    }
}


class seafile::install {
# TODO - Find package solution for CentOS 7.

#  package { "python-setuptools":
#    ensure => "installed"
#  }

#  package { "python-imaging":
#    ensure => "installed"
#  }

#  package { "python-simplejson":
#    ensure => "installed"
#  }

  #exec { "install_python_deps":
  #  command => "sudo yum -y install sqlite python-simplejson python-setuptools python-imaging",
  #  refreshonly => true
#} ->

  # TODO - Move to top scope
  $seafile_symlink = "${seafile::params::install_dir}/${seafile::params::foldername}"

  file { "${seafile::params::install_dir}":
    ensure => "directory",
    owner  => "root",
    group  => "wheel",
    mode   => "0755",
  } ->

  # TODO - Find better method than a bash script to handle tarball.
  file { "${seafile::params::install_dir}/seafile_extract.sh":
    ensure  => file,
    replace => true,
    owner   => "root",
    mode    => "0755",
    content => template( "seafile/seafile_extract.sh.erb" )
  } ->
  
  exec { 'extract_seafile':
    require  => [
      File['/opt/seafile/seafile_extract.sh'],
    ],
    # TODO - Fix to run from path.
    command   => 'seafile_extract.sh',
    path    => [$seafile::params::install_dir, "/usr/bin"],
    }
  
  # Symlink for seafile server installation folder
  # TODO Fix requirement for fully qualified name in file.
  file { '/opt/seafile/seafile-server-latest':
   ensure => 'link',
   target => $seafile_symlink,
  }

  #tarball { "$pkg_name":
  #  module_name => "foo",
  #  install_dir => "$location",
  #  pkg_tgz     => "pkg_name"
  #}
} 

