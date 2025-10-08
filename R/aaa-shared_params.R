#' Parameters used in multiple functions
#'
#' Reused parameter definitions are gathered here for easier editing.
#'
#' @param call `(environment)` The execution environment to mention as the
#'   source of error messages.
#' @param levels (`character`) The allowed values of the factor.
#' @param message_env (`environment`) The execution environment to use to
#'   evaluate variables in error messages.
#' @param parent A parent condition, as you might create during a
#'   [rlang::try_fetch()]. See [rlang::abort()] for additional information.
#' @param subclass (`character`) Class(es) to assign to the error. Will be
#'   prefixed by "hrmn-error-".
#' @name .shared_params
#' @keywords internal
NULL
