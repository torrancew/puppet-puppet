# == Class: puppet
#
# The puppet module
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
class puppet(
  $master       = $puppet::params::master,
  $use_puppetdb = $puppet::params::use_puppetdb
) inherits puppet::params {
  class {
    'puppet::install':
      master       => $master,
      use_puppetdb => $use_puppetdb;

    'puppet::configure':
      master       => $master,
      use_puppetdb => $use_puppetdb;

    'puppet::service':
      master => $master;
  }

  anchor { 'puppet::begin': } -> Class['puppet::install']
  Class['puppet::service']    -> anchor { 'puppet::end': }
}

