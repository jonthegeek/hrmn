#' @importFrom rlang caller_arg
#' @export
rlang::caller_arg

#' @importFrom rlang caller_env
#' @export
rlang::caller_env

#' Signal an error with standards applied
#'
#' A wrapper around [cli::cli_abort()] to throw classed errors.
#'
#' @param message (`character`) The message for the new error. Messages will be
#'   formatted with [cli::cli_bullets()].
#' @param ... Additional parameters passed to [cli::cli_abort()] and on to
#'   [rlang::abort()].
#' @inheritParams .shared_params
#' @keywords internal
.hrmn_abort <- function(
  message,
  subclass,
  call = caller_env(),
  message_env = call,
  parent = NULL,
  ...
) {
  cli::cli_abort(
    message,
    class = c(
      .compile_error_class("hrmn", "error", subclass),
      .compile_error_class("hrmn", "error"),
      .compile_error_class("hrmn", "condition")
    ),
    call = call,
    .envir = message_env,
    parent = parent,
    ...
  )
}

#' Compile an error class
#'
#' @param ... `(character)` Components of the class name.
#' @returns A length-1 character vector.
#' @keywords internal
.compile_error_class <- function(...) {
  paste(..., sep = "-")
}

#' Check that all specified args are named
#'
#' @param ... Arguments to check.
#' @inheritParams .shared_params
#' @returns `NULL`, invisibly.
#' @keywords internal
.check_args_named <- function(..., call = rlang::caller_env()) {
  if (...length() && (is.null(...names()) || !all(nzchar(...names())))) {
    .hrmn_abort(
      "All arguments must be named.",
      "args_unnamed",
      call = call
    )
  }
  invisible(NULL)
}

#' Check that all args are hrmn_spec objects
#'
#' @param ... Arguments to check.
#' @inheritParams .shared_params
#' @returns `NULL`, invisibly.
#' @keywords internal
.check_args_spec <- function(..., call = rlang::caller_env()) {
  dots <- list(...)
  is_spec <- vapply(dots, inherits, logical(1), "hrmn_spec")
  if (length(dots) && !all(is_spec)) {
    bad_args <- rlang::names2(is_spec)[!is_spec]
    bad_args[bad_args == ""] <- "<unnamed>"
    .hrmn_abort(
      c(
        "All arguments must be `hrmn_spec` objects.",
        "x" = "Argument{?s} {.arg {bad_args}} {?is/are} not {?a / }`hrmn_spec` object{?s}."
      ),
      subclass = "args_not_spec",
      call = call,
      message_env = rlang::current_env()
    )
  }
  invisible(NULL)
}
