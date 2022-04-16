
#' Spins .R files to .Rmd to allow successful rendering with officedown::rdocx_document
#'
#' @export

prerender <- function() {
  rstudioapi::documentSave()

  path <- knitr::spin(rstudioapi::documentPath(), knit = FALSE)

  docx_path <- rmarkdown::render(path)

  system(paste("open", docx_path))

  unlink(path)
}
