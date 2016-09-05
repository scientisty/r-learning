# Spencer Mathews
# derived from https://gist.github.com/lgatto/4493747

getDependencies <- function(p,
                            rep = c("BioCsoft", "BioCann", "BioCexp", "BioCextra", "CRAN"),
                            biocVersion = "2.12",
                            depLevels = c("Depends", "Imports", "Suggests"),
                            filter = TRUE) {
  rep <- match.arg(rep)
  if (rep == "CRAN") {
    rep <- getOption("repos")["CRAN"]
  } else {
    biocMirror <- getOption("BioC_mirror", "http://bioconductor.org")
    biocPaths <- switch(rep,         
                        BioCsoft = "bioc",
                        BioCann = "data/annotation", 
                        BioCexp = "data/experiment",
                        BioCextra = "extra")   
    rep <- paste(biocMirror,
                 "packages",
                 biocVersion,
                 biocPaths, 
                 sep = "/")    
  }
  pDetails <- available.packages(contrib.url(rep))[p, ]
  depLevels <- match.arg(depLevels, several.ok = TRUE)
  deps <- sapply(depLevels,
                 function(.depLevel)
                   tools:::package.dependencies(pDetails, depLevel = .depLevel)[[1]][, 1])
  deps <- unlist(deps)
  i <- match("R", deps)
  if (length(i) > 0)
    deps <- deps[-i]
  if (filter) {
    installedP <- installed.packages()[,"Package"]
    deps <- deps[!deps %in% installedP]
  }
  return(deps)
}