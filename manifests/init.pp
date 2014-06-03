# == Class: r
#
# Run update nad upgrade once only.
#
# === Parameters
#
#  None.
#
#
# === Examples
#
#  class { r:
#  }
#
#
# === Authors
#
# Piers Harding <piers@ompka.net>
#
# === Copyright
#
# Copyright 2014 Piers Harding.
#
#
class r {

    package { 'r-base': ensure => installed }

}

