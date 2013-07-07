# == Class: puppet::params
#
# A class for managing default parameters for the puppet class
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
class puppet::params {
  ## Generic Settings
  $master       = false
  $use_puppetdb = false

  ## Installation Settings
  $package          = 'puppet'
  $version          = 'installed'
  $master_package   = 'puppetmaster'
  $terminus_package = 'puppetdb-terminus'
  $terminus_version = 'installed'

  ## Configuration Settings
  $server        = 'puppet'
  $environment   = 'production'
  $puppetdb_host = 'puppetdb'
  $puppetdb_port = 8081
  $use_foreman   = false

  ## Service Settings
  $service        = 'puppet'
  $master_service = 'puppetmaster'
}

