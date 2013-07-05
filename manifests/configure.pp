# == Class: puppet::configure
#
# A class for configuring puppet
#
# === Parameters:
#
# None
#
# === Variables:
#
# None
#
# === Examples:
#
# None
#
# === Authors:
#
# * Tray Torrance
#
# === Copyright:
#
# Copyright 2013, Tray Torrance
# unless otherwise noted.
#
class puppet::configure(
  $server        = $puppet::params::server,
  $environment   = $puppet::params::environment,
  $master        = $puppet::params::master,
  $use_puppetdb  = $puppet::params::use_puppetdb,
  $puppetdb_host = $puppet::params::puppetdb_host,
  $puppetdb_port = $puppet::params::puppetdb_port,
) inherits puppet::params {
  Class['puppet::install'] -> Class['puppet::configure']

  validate_bool( $master )
  validate_bool( $use_puppetdb )
  validate_string( $environment )
  validate_string( $puppetdb_host )

  file {
    '/etc/puppet':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => 0755;

    '/etc/default/puppet':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => 0644,
      source => 'puppet:///modules/puppet/puppet.default';

    '/etc/puppet/puppet.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      content => template('puppet/puppet.conf.erb'),
      require => File['/etc/puppet'];
  }

  if $master {
    if $use_puppetdb {
      file {
        '/etc/puppet/puppetdb.conf':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => 0644,
          content => template('puppet/puppetdb.conf.erb'),
          require => File['/etc/puppet'];

        '/etc/puppet/routes.yaml':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => 0644,
          source  => 'puppet:///modules/puppet/routes.yaml',
          require => File['/etc/puppet'];
      }
    }
  }
}

