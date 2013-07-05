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
class puppet {
  class { 'puppet::install': }
  class { 'puppet::configure': }
  class { 'puppet::service': }

  anchor { 'puppet::begin': } -> Class['puppet::install']
  Class['puppet::service']    -> anchor { 'puppet::end': }
}

