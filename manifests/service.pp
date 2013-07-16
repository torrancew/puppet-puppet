# == Class: puppet::service
#
# A class to manage the puppet service
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
class puppet::service(
  $master         = $puppet::params::master,
  $service        = $puppet::params::service,
  $master_service = $puppet::params::master_service,
) inherits puppet::params {
  Class['puppet::install']   ~> Class['puppet::service']
  Class['puppet::configure'] ~> Class['puppet::service']

  validate_bool( $master )
  validate_string( $service )
  validate_string( $master_service )

  service {
    'puppet':
      name   => $service,
      ensure => running,
      enable => true;
  }

  if $master {
    service {
      'puppetmaster':
        name   => $master_service,
        ensure => running,
        enable => true;
    }
  }
}

