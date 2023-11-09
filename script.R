foo <- function() {
  url <- c(
    "https://hub.docker.com/v2/repositories/jeksterslab/dynr-rocker",
    "https://hub.docker.com/v2/repositories/jeksterslab/dynr-arma-rocker",
    "https://hub.docker.com/v2/repositories/ijapesigan/rocker",
    "https://hub.docker.com/v2/repositories/ijapesigan/docs",
    "https://hub.docker.com/v2/repositories/ijapesigan/rarch",
    "https://hub.docker.com/v2/repositories/ijapesigan/r2u",
    "https://hub.docker.com/v2/repositories/ijapesigan/r2u-r-project"
  )
  fn <- c(
    "count_dynr.rds",
    "count_dynr_arma.rds",
    "count_rocker.rds",
    "count_docs.rds",
    "count_rarch.rds",
    "count_r2u.rds",
    "count_r2u_r_project.rds"
  )
  install.packages(
    "jsonlite",
    repos = c(CRAN = "http://cran.rstudio.com")
  )
  for (i in seq_along(url)) {
    if (file.exists(fn[i])) {
      count <- readRDS(fn[i])
    } else {
      count <- 0
    }
    docker_hub <- jsonlite::fromJSON(url[i])
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
      saveRDS(count_update, file = fn[i])
    }
  }
}
foo()
