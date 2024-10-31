# Install all of the packages used in this repository (up to ~30 min run time)
# Last Updated: 2024-09-25 by Brian High for Ubuntu 22.04.3 LTS (64-bit)

# NOTE: Ubuntu (Linux) dependencies: libxml2, libpng-dev, libfortran, libgdal, 
#.      cmake, libfontconfig1-dev, libharfbuzz-dev and libfribidi-dev
#
# - tidyverse and xml2 need libxml2
# - Hmisc, ggmap, funModeling need libpng-dev
# - lme4, VCA, stars, sf need libgfortran
# - rgdal needs libgdal                    # Note: rgdal was retired Oct. 2023
# - nloptr (for lme4) needs cmake
# - systemfonts needs libfontconfig1-dev 
# - textshaping needs libharfbuzz-dev & libfribidi-dev
#
# On Ubuntu 22.04, these shell commands were used to install these dependencies:
#
# sudo apt update
# sudo apt install r-base r-base-dev git
# sudo apt install libxml2 libpng-dev cmake libfontconfig1-dev libharfbuzz-dev \
#   libfribidi-dev libcurl4-openssl-dev libgdal-dev libgfortran5 libcairo2-dev \
#   libudunits2-dev gdal-bin

# Clear workspace of all objects and unload all extra (non-base) packages.
rm(list = ls(all = TRUE))
if (!is.null(sessionInfo()$otherPkgs)) {
  res <- suppressWarnings(
    lapply(paste('package:', names(sessionInfo()$otherPkgs), sep=""),
           detach, character.only=TRUE, unload=TRUE, force=TRUE))
}

# Force use of personal R library folder, creating as needed
lib_dir <- Sys.getenv("R_LIBS_USER")
if (!dir.exists(lib_dir)) dir.create(lib_dir, recursive = TRUE)
.libPaths(lib_dir, include.site = FALSE)

# Set repository URL
r <- getOption("repos")
r["CRAN"] <- "https://cloud.r-project.org"
options(repos = r)

# Install "pak" package, if missing, and attach
if (!requireNamespace("pak", quietly = TRUE)) install.packages("pak")
library(pak)

# Install LaTeX environment (for rendering PDFs from RMarkdown, etc.)
pdflatex_ver <- try(system("pdflatex -v", intern = T, wait = T), silent = T)
pdflatex_ver <- grep("^pdfTeX", pdflatex_ver, value = T)
if (!(exists("pdflatex_ver") & length(pdflatex_ver) > 0)) {
  pkg_install("tinytex")
  if (!dir.exists(tinytex::tinytex_root(error = F))) tinytex::install_tinytex()
}

# Install other packages
## if you receive errors for 'sf', you may need to remove and reinstall sf: remove.packages("sf")
## insall the prior sf package version; the current one has bugs/installation issues on SPH and/or Plasmid servers
pkg_install("url::https://cran.r-project.org/src/contrib/Archive/sf/sf_1.0-16.tar.gz")

# R versions < 4.4 do not support the most recent version of Matrix (1.7-1), 
# which requires 4.4 or higher, so install an older version (e.g., on Plasmid)
if (getRversion() < '4.4') {
  pkg_install("url::https://cran.r-project.org/src/contrib/Archive/Matrix/Matrix_1.6-5.tar.gz")
}

pkg_install(c("plyr", "reshape2", "tictoc", "stars", "sp", 
              #"sf", # current version receives errors on some servers
              "hms"))

pkg_install(c("feasts", "tidyverse", "lubridate", "broom"))
pkg_install(c("downloader", "knitr", "formatR", "ggrepel", "Hmisc", "EnvStats"))
pkg_install(c("codetools", "egg", "multcomp", "modelr", "car", "lme4", "VCA"))
pkg_install(c("parallel", "NADA", "ggmap", "geoR", "maps", "limma"))

# pak::pkg_install() won't install foreign, slider and scales, so use base-r:
if (!requireNamespace("foreign", quietly = TRUE)) install.packages("foreign")
if (!requireNamespace("slider", quietly = TRUE)) install.packages("slider")
if (!requireNamespace("scales", quietly = TRUE)) install.packages("scales")

# For funModeling, install these dependencies first
pkg_install(c("ROCR", "pander", "lazyeval", "moments", "entropy"))

# Install rgdal from the archives because it was removed from CRAN
# See: https://cran.r-project.org/web/packages/rgdal/index.html
options("rgdal_show_exportToProj4_warnings" = "none")
if (!requireNamespace("rgdal", quietly = TRUE)) install.packages(
  'https://cran.r-project.org/src/contrib/Archive/rgdal/rgdal_1.6-7.tar.gz', 
  repos = NULL)

# Install funModeling from the archives because it was removed from CRAN
# See: https://cran.r-project.org/web/packages/funModeling/index.html
if (!requireNamespace("funModeling", quietly = TRUE)) install.packages(
  "https://cran.r-project.org/src/contrib/Archive/funModeling/funModeling_1.9.4.tar.gz", 
  repos = NULL)

pkg_install(c("scatterplot3d", "akima"))
pkg_install(c("MKmisc", "tseries", "xts", "lubridate", "tsibble", "pacman"))

# Update tidyverse, if needed
tidyverse::tidyverse_update()
