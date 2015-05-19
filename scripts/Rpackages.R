# 
# Functions to keep package installs synchronized across multiple computers
#
# I grabbed useful code from a post and created functions
#
# Assumptions:
#   The object where the package list is stored is called "packages"
#   The canonical file name to save/read is "Rpackages.Rdata"
#


# Backup and Restore -----------------------------

save_package_list <- function(save_name = "Rpackages.Rdata", save_file=TRUE) {
  # Save package list as object called "packages" in an RData file
  #
  packages <- installed.packages()[,"Package"]
  cat(length(packages), "packages are installed\n")
  if(save_file)  save(packages, file=save_name)
  return(packages)
}

install_from_package_list <- function(file_name = "Rpackages.Rdata") {
  # Install packages from "packages" object which are not currently installed
  #
  load(file_name, verbose=TRUE)
  stopifnot("packages")
  for (p in setdiff(packages, installed.packages()[,"Package"]))  install.packages(p)
}


# Package Tools ----------------------------------

compare_packages <- function(file_name) {
  # Compare packages in file to those installed
  #
  load(file_name)
  file_packages <- packages

  installed_packages <- installed.packages()[,"Package"]
  
  old_packages <- setdiff(installed_packages, file_packages)
  cat("\nInstalled packages not in file:\n-------------------------------\n", old_packages)
  new_packages <- setdiff(file_packages, installed_packages)
  cat("\n\nPackages in file that are not installed:\n----------------------------------------\n", new_packages, "\n\n")
  return(new_packages)
}


merge_package_lists <- function(file_name_A, file_name_B='Rpackages.Rdata', save_file=TRUE) {
  # Add packages from first list into second list
  #
  # There may be a clever way to do this by specifying the environment to load into...
  #
  load(file_name_A)
  packages_A <- packages
  load(file_name_B)
  packages_B <- packages
  
  new_packages <- setdiff(packages_A, packages_B)
  cat("\n\nPackages to be merged:\n----------------------------------------\n", new_packages, "\n\n")
  combined_packages <- c(packages_B, new_packages)
  combined_packages <- sort(combined_packages)
  
  packages = combined_packages
  if(save_file) save(packages, file=file_name_B)
  return(combined_packages)
}

