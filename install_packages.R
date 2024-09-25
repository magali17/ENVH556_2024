# Install all of the packages used in this repository (up to ~30 min run time)

# NOTE: Ubuntu (Linux) dependencies: libxml2, libpng, libfortran, libgdal, cmake
#
# - tidyverse and xml2 need libxml2
# - Hmisc, ggmap, funModeling need libpng
# - lme4, VCA, stars, sf need libgfortran
# - rgdal needs libgdal
# - nloptr (for lme4) needs cmake

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
## consider running this line by line if you have issues

pkg_install(c("plyr", "reshape2", "tictoc", "stars", "sp", "hms"#, "sf"
              ))

# --> ERROR: SF may have issues on the SPH server. You may need to update the dependencies. GDAL, PROJ, GEOS? 
pkg_install(c("sf"))

# --> ERROR: has dependency conflicts & 'can't find gdal'
pkg_install(c("feasts", "tidyverse", "lubridate", "broom", "rgdal", "foreign"))

pkg_install(c("downloader", "knitr", "formatR", "ggrepel", "Hmisc", "EnvStats"))
pkg_install(c("codetools", "egg", "multcomp", "modelr", "car", "lme4", "VCA"))
pkg_install(c("parallel", "NADA", "ggmap", "geoR", "maps", "limma"))
pkg_install(c("slider", "scatterplot3d", "funModeling", "scales", "akima"))
pkg_install(c("MKmisc", "tseries", "xts", "lubridate", "tsibble", "pacman"))

# Update tidyverse, if needed
pkg_install(c("tidyverse"))
#tidyverse::tidyverse_update()


################################################################################
################################################################################
# # you may need to install some of these packages differently if you receive errors
# install.packages("tidyverse")


# having issues w/ 'sf'
## 1. try again
# install.packages("sf")

## 2. sf may expect updated versions of these: GDAL, PROJ, GEOS? 
## need to install dependencies in terminal (with permissions)? e.g.:
## sudo apt update
## sudo apt install libgdal-dev libgeos-dev

#if (!requireNamespace("pacman", quietly = TRUE)){install.packages("pacman")}
 

# ## 3. try installing using a different approach
# # Check if 'remotes' is installed, and install if it's not
# if (!requireNamespace("remotes", quietly = TRUE)){install.packages("remotes")}
# # Install 'sf' from GitHub using 'remotes'
# remotes::install_github("r-spatial/sf")



