
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
  start_row <- rstudioapi::getActiveDocumentContext()$selection[[1]]$range$start[['row']]
  end_row <- rstudioapi::getActiveDocumentContext()$selection[[1]]$range$end[['row']]

  lapply(start_row:end_row, function(current_row) {
    ranges <- rstudioapi::document_range(
      c(current_row, 0),
      c(current_row, Inf)
    )

    rstudioapi::setSelectionRanges(ranges)

    source <- trimws(rstudioapi::selectionGet())

    if (source != "") {
      target <- rstudioapi::selectionSet(paste0("library(", source, ")"))
    }
  })

  ranges <- rstudioapi::document_range(
    c(end_row + 1, Inf),
    c(end_row + 1, Inf)
  )

  rstudioapi::setSelectionRanges(ranges)

}

