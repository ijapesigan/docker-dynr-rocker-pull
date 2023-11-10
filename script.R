foo <- function(image) {
  if (image == "jeksterslab-dynr-rocker") {
    url <- "https://hub.docker.com/v2/repositories/jeksterslab/dynr-rocker"
  }
  if (image == "jeksterslab-dynr-arma-rocker") {
    url <- "https://hub.docker.com/v2/repositories/jeksterslab/dynr-arma-rocker"
  }
  if (image == "ijapesigan-rocker") {
    url <- "https://hub.docker.com/v2/repositories/ijapesigan/rocker"
  }
  if (image == "ijapesigan-docs") {
    url <- "https://hub.docker.com/v2/repositories/ijapesigan/docs"
  }
  if (image == "ijapesigan-rarch") {
    url <- "https://hub.docker.com/v2/repositories/ijapesigan/rarch"
  }
  if (image == "ijapesigan-r2u") {
    url <- "https://hub.docker.com/v2/repositories/ijapesigan/r2u"
  }
  fn <- paste0(image, ".Rds")
  install.packages(
    "jsonlite",
    repos = c(CRAN = "http://cran.rstudio.com")
  )
  if (file.exists(fn)) {
    count <- readRDS(fn)
  } else {
    count <- 0
  }
  docker_hub <- jsonlite::fromJSON(url)
  count_new <- docker_hub$pull_count
  count_update <- count_new - count
  if (count_update > 0) {
    for (i in 1:count_update) {
      install.packages(
        "dynr",
        repos = c(CRAN = "http://cran.rstudio.com")
      )
      remove.packages(
        "dynr"
      )
    }
    saveRDS(count_update, file = fn)
  }
}
