#' Harmonize a factor
#'
#' @param .data (`character` or coercible to `character`) A vector to harmonize
#'   to the specified factor.
#' @inheritParams .shared_params
#' @inheritParams rlang::args_dots_empty
#' @param .spec (`hrmn_fct_spec`) A harmonization specification from
#'   [specify_fct()].
#' @param .lookup (named `character`) A vector of replacement values. The names
#'   are the values in `.data` and the values are the target values.
#'
#' @returns A harmonized [factor()].
#' @family harmonization functions
#' @examples
#' # Without a spec, harmonize_fct() acts like [base::factor()].
#' harmonize_fct(c("a", "b", "c"))
#'
#' # Basic harmonization, dropping levels not in the spec
#' spec <- specify_fct(levels = c("a", "b"))
#' harmonize_fct(c("a", "b", "c"), .spec = spec)
#'
#' # Using a lookup table to recode values
#' spec2 <- specify_fct(levels = c("fruit", "citrus"))
#' lookup <- c(apple = "fruit", banana = "fruit", orange = "citrus")
#' harmonize_fct(
#'   c("apple", "banana", "orange"),
#'   .spec = spec2,
#'   .lookup = lookup
#' )
#' @export
harmonize_fct <- function(.data, ..., .spec = NULL, .lookup = NULL) {
  rlang::check_dots_empty()
  .data <- stbl::to_chr(.data)
  .spec <- .spec %||% specify_fct()
  .data <- .apply_fct_lookup(.data, .lookup = .lookup)
  return(factor(.data, levels = .spec$levels))
}

#' Apply a lookup table to a character vector
#'
#' @inheritParams harmonize_fct
#' @returns A character vector with values replaced according to the lookup
#'   table.
#' @keywords internal
.apply_fct_lookup <- function(.data, .lookup = NULL) {
  .lookup <- stbl::to_chr(.lookup)
  matches <- .data %fin% names(.lookup)
  .data[matches] <- .lookup[.data[matches]]
  return(.data)
}
