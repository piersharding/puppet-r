# == Class: r::github_package
#
# Install R github based packages
#
# === Parameters
#
# - The $r_path - path to R
# - The $repo - URL to CRAN mirror
# - The $gitrepo - github account name
# - The $build_vignettes - boolean, build vignettes or not
#
#
# === Examples
#
#  r::github_package { 'dplyr': repo => "http://cran.stat.auckland.ac.nz/", gitrepo => 'hadley' }
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

define r::github_package($r_path = "/usr/bin/R", $repo = "http://cran.rstudio.com", $gitrepo = "hadley", $build_vignettes = false) {

    $r_prefix = "local({r <- getOption('repos'); r['CRAN'] <- '$repo'; options(repos=r)}); library(devtools); "

    exec { "install_r_github_$name":
        command => $build_vignettes ? {
            true => "$r_path -e \"$r_prefix devtools::install_github('$gitrepo/$name',  build_vignettes = TRUE)\"",
            default => "$r_path -e \"$r_prefix devtools::install_github('$gitrepo/$name',  build_vignettes = FALSE)\""
        },
        timeout => 600,
        unless  => "$r_path -q -e '\"$name\" %in% installed.packages()' | grep 'TRUE'",
        require => Class['r']
    }

}
