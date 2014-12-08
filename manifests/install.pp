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
  package { "python-setuptools":
    ensure => "installed"
  }

  package { "python-imaging":
    ensure => "installed"
  }

  package { "python-simplejson":
    ensure => "installed"
  }

  #exec { "install_python_deps":
  #  command => "sudo yum -y install sqlite python-simplejson python-setuptools python-imaging",
  #  refreshonly => true
#} ->

  # TODO - Find better method than a bash script for this.
  file { "seafile_extract.sh":
        ensure  => file,
        mode    => '0755',
        owner   => 'seafile',
        content => template( "seafile/seafile_extract.sh.erb" )
    }

  #$location = "/opt/seafile"
  #$pkg_name = "seafile"

  #tarball { "$pkg_name":
  #  module_name => "foo",
  #  install_dir => "$location",
  #  pkg_tgz     => "pkg_name"
  #}
} 

