# 
# Functions to keep package installs synchronized across multiple computers
#
# I grabbed useful code from a post and created functions
#


save_package_list <- function(file_name = "Rpackages.Rdata") {
  packages <- installed.packages()[,"Package"]
  save(packages, file=file_name)
  return(packages)
}

install_from_package_list <- function(file_name = "Rpackages.Rdata") {
  load(file_name)
  for (p in setdiff(packages, installed.packages()[,"Package"]))  install.packages(p)
}

