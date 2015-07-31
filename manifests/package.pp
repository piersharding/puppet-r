# == Class: r::package
#
# Install R CRAN based packages
#
# === Parameters
#
# - The $r_path - path to R
# - The $repo - URL to CRAN mirror
# - The $dependencies - boolean, install depenencies or not
#
#
# === Examples
#
#  r::package { 'devtools': repo => "http://cran.stat.auckland.ac.nz/", dependencies => true }
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
define r::package($r_path = "/usr/bin/R", $repo = "http://cran.rstudio.com", $dependencies = false) {

  exec { "install_r_package_$name":
    command => $dependencies ? {
      true    => "$r_path -e \"install.packages('$name', repos='$repo', dependencies = TRUE)\"",
      default => "$r_path -e \"install.packages('$name', repos='$repo', dependencies = FALSE)\""
    },
    timeout => 600,
    unless  => "$r_path -q -e '\"$name\" %in% installed.packages()' | grep 'TRUE'",
    require => Class['r']
  }

}
