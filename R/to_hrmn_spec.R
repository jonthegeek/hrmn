#' Validate a harmonization specification
#'
#' @param .spec (`NULL` or `hrmn_spec`) An object to validate as a harmonization
#'   specification object.
#' @param .subclass (`NULL` or `length-1 character`) If provided, check that
#'   `.spec` inherits the given subclass. For example, to confirm that `.spec`
#'   has class `"hrmn_spec_fct`, use `.subclass = "fct"`.
#' @returns The validated `.spec` object, or an informative error.
#' @keywords internal
.to_hrmn_spec <- function(
  .spec,
  .subclass = NULL,
  .call = rlang::caller_env()
) {
  if (!length(.spec)) {
    return(NULL)
  }
  if (inherits(.spec, "hrmn_spec")) {
    return(.confirm_spec_subclass(.spec, .subclass, .call = .call))
  }
  .hrmn_abort(
    "{.arg .spec} must be `NULL` or a `hrmn_spec` object.",
    "not_spec",
    .call = .call
  )
}

#' Confirm that a spec has a given spec subclass
#'
#' @inheritParams .to_hrmn_spec
#' @inherit .to_hrmn_spec return
#' @keywords internal
.confirm_spec_subclass <- function(
  .spec,
  .subclass = NULL,
  .call = rlang::caller_env()
) {
  if (is.null(.subclass)) {
    return(.spec)
  }
  subclass <- paste0("hrmn_spec_", .subclass)
  if (!inherits(.spec, subclass)) {
    .hrmn_abort(
      c(
        "{.arg .spec} must be a {.cls {subclass}} object.",
        "x" = "{.arg .spec} is a {.cls {class(.spec)[1]}} object."
      ),
      "bad_spec",
      .call = .call,
      message_env = rlang::current_env()
    )
  }
  return(.spec)
}
