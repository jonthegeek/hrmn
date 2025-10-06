#' Factor specification
#'
#' Create an object that specifies the desired levels for a factor variable.
#' This specification object does not contain any data itself, only the rules
#' for harmonization.
#'
#' @inheritParams .shared_params
#'
#' @returns A `hrmn_fct_spec` object that acts as a specification.
#' @export
#'
#' @examples
#' specify_fct(levels = c("a", "b", "c"))
specify_fct <- function(levels = character()) {
  structure(
    list(levels = stbl::to_chr(levels)),
    class = c("hrmn_fct_spec", "hrmn_spec", "list")
  )
}
