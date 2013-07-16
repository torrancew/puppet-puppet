# == Class: puppet::install
#
# A class for installing puppet
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
class puppet::install(
  $master           = $puppet::params::master,
  $package          = $puppet::params::package,
  $version          = $puppet::params::version,
  $use_puppetdb     = $puppet::params::use_puppetdb,
  $master_package   = $puppet::params::master_package,
  $terminus_package = $puppet::params::terminus_package,
  $terminus_version = $puppet::params::terminus_version,
) inherits puppet::params {
  validate_bool( $master )
  validate_bool( $use_puppetdb )

  validate_string( $package )
  validate_string( $version )
  validate_string( $master_package )
  validate_string( $terminus_package )
  validate_string( $terminus_version )

  package {
    'puppet-common':
      name   => "${package}-common",
      ensure => $version;

    'puppet':
      name    => $package,
      ensure  => $version,
      require => Package['puppet-common']
  }

  if $master {
    package {
      'puppetmaster':
        name   => $master_package,
        ensure => $version;

      'puppetdb-terminus':
        name    => $terminus_package,
        ensure  => $terminus_version,
        require => Package['puppetmaster'];
    }
  }
}

