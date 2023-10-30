foo <- function(arma = FALSE) {
  if (arma) {
    url <- "https://hub.docker.com/v2/repositories/jeksterslab/dynr-arma-rocker"
    fn <- "count_dynr_arma.rds"
  } else {
    url <- "https://hub.docker.com/v2/repositories/jeksterslab/dynr-rocker"
    fn <- "count_dynr.rds"
  }
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
      remove.packages("dynr")
    }
    saveRDS(count_update, file = fn)
  }
}
