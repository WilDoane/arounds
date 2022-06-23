
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

library_it <- function() {
  current_row <- rstudioapi::getActiveDocumentContext()$selection[[1]]$range$start[[1]]

  ranges <- rstudioapi::document_range(
    c(current_row, 0),
    c(current_row, Inf)
  )

  rstudioapi::setSelectionRanges(ranges)

  source <- trimws(rstudioapi::selectionGet())

  target <- rstudioapi::selectionSet(paste0("library(", source, ")"))

  ranges <- rstudioapi::document_range(
    c(current_row + 1, Inf),
    c(current_row + 1, Inf)
  )

  rstudioapi::setSelectionRanges(ranges)

}

