#' Data frame specification
#'
#' Create an object that specifies the desired format for a data frame.
#' This specification object does not contain any data itself, only the rules
#' for harmonization.
#'
#' @param ... (`hrmn_spec`) Column specifications, given as named arguments.
#'
#' @returns A `hrmn_spec_df` object that acts as a specification.
#' @family specification functions
#' @examples
#' specify_df(
#'   response = specify_fct(levels = c("Yes", "No", "Maybe")),
#'   outcome = specify_fct(levels = c("Positive", "Negative"))
#' )
#' @export
specify_df <- function(...) {
  .stop_if_args_unnamed(...)
  .stop_if_args_not_spec(...)
  structure(list(...), class = c("hrmn_spec_df", "hrmn_spec", "list"))
}
