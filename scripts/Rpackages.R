# 
# Functions to keep package installs synchronized across multiple computers
#
# I grabbed useful code from a post and created functions
#

save_package_list <- function() {
  packages <- installed.packages()[,"Package"]
  save(packages, file="Rpackages")
}

install_from_package_list <- function() {
  load("Rpackages")
  for (p in setdiff(packages, installed.packages()[,"Package"]))  install.packages(p)
}






