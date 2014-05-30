define r::package($r_path = "/usr/bin/R", $repo = "http://cran.rstudio.com", $dependencies = false) {

  exec { "install_r_package_$name":
    command => $dependencies ? {
      true    => "$r_path -e \"install.packages('$name', repos='$repo', dependencies = TRUE)\"",
      default => "$r_path -e \"install.packages('$name', repos='$repo', dependencies = FALSE)\""
    },
    unless  => "$r_path -q -e '\"$name\" %in% installed.packages()' | grep 'TRUE'",
    require => Class['r']
  }

}

define r::github_package($r_path = "/usr/bin/R", $repo = "http://cran.rstudio.com", $gitrepo = "hadley", $build_vignettes = false) {

    $r_prefix = "local({r <- getOption('repos'); r['CRAN'] <- '$repo'; options(repos=r)}); library(devtools); "

    exec { "install_r_github_$name":
        command => $build_vignettes ? {
            true => "$r_path -e \"$r_prefix devtools::install_github('$gitrepo/$name',  build_vignettes = TRUE)\"",
            default => "$r_path -e \"$r_prefix devtools::install_github('$gitrepo/$name',  build_vignettes = FALSE)\""
        },
        unless  => "$r_path -q -e '\"$name\" %in% installed.packages()' | grep 'TRUE'",
        require => Class['r']
    }

}
