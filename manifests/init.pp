# == Class: consul_do
#
# Installs consul_do
#
# === Parameters
#
# Document parameters here.
#
# [*version*]
#   Installs a specific version of consul_do
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'consul_do':
#    version => '123343sdfgfasd123'
#  }
#
# === Authors
#
# Ed Lim <limed@mozilla.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class consul_do (
    $version
) {

    if !($version) {
        fail('Parameter version is required')
    }

    $url = "https://raw.githubusercontent.com/zeroXten/consul-do/${version}/consul-do"

    notice ("Grabbing from ${url}")

    wget::fetch { "download consul-do ${version}":
        source      => $url,
        destination => "/usr/local/bin/consul-do-${version}",
        user        => 'root',
        verbose     => true,
        redownload  => true, # The file already exists, we replace it
    }

    file { "/usr/local/bin/consul-do-${version}":
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0755',
        require => Wget::Fetch["download consul-do ${version}"],
    }

    file { '/usr/local/bin/consul-do':
        ensure  => 'link',
        target  => "/usr/local/bin/consul-do-${version}",
        require => File["/usr/local/bin/consul-do-${version}"],
    }

}
