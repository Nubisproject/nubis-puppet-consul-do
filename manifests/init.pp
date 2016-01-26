# == Class: consul_do
#
# Installs consul_do
#
# === Parameters
#
# version - specify the version of consul_do
#
# [*version*]
#   Installs a specific version of consul_do
#
# === Variables
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
