#' Harmonize a data frame
#'
#' @param .data (`data.frame`) A data frame to harmonize.
#' @param .spec (`hrmn_spec_df`) A data frame harmonization specification.
#' @param .unspecified_columns (`"error"`, `"drop"`, or `"keep"`) How to handle
#'   columns in `.data` that are not present in `.spec`.
#' @inheritParams rlang::args_dots_empty
#'
#' @returns The input `.data` harmonized to a [tibble::tibble()].
#' @family harmonization functions
#' @examples
#' df <- data.frame(
#'   size = c("Small", "Medium", "S", "M", "Large", "Lrg", "Sm"),
#'   id = 1:7
#' )
#'
#' # This spec will coerce values to NA if they are not "Small", "Medium",
#' # or "Large".
#' spec <- specify_df(
#'   size = specify_fct(levels = c("Small", "Medium", "Large"))
#' )
#'
#' # We can provide harmonization rules to the data before the spec is applied.
#' # Here, we harmonize the input factor to convert "S", "M", "Sm", and "Lrg" to
#' # valid values.
#' harmonize_df(
#'   df,
#'   size = harmonize_fct(
#'     size,
#'     .lookup = c("S" = "Small", "M" = "Medium", "Sm" = "Small", "Lrg" = "Large")
#'   ),
#'   .spec = spec,
#'   .unspecified_columns = "keep"
#' )
#' @export
harmonize_df <- function(
  .data,
  ...,
  .spec = NULL,
  .unspecified_columns = c("error", "drop", "keep")
) {
  .spec <- .to_hrmn_spec(.spec, "df")
  .data <- .harmonize_df_data(
    .data,
    ...,
    .spec = .spec,
    .unspecified_columns = rlang::arg_match(.unspecified_columns)
  )
  return(.harmonize_df_spec(.data, .spec = .spec))
}

#' Harmonize a data frame based on data inputs
#'
#' @inheritParams harmonize_df
#' @inheritParams .shared_params
#' @returns A `data.frame` with custom harmonizations and column name
#'   reconciliation applied.
#' @keywords internal
.harmonize_df_data <- function(
  .data,
  ...,
  .spec,
  .unspecified_columns,
  .call = rlang::caller_env()
) {
  .harmonize_col_names(
    .harmonize_df_dots(.data, ..., .call = .call),
    .spec,
    .unspecified_columns,
    .call = .call
  )
}

#' Harmonize a data frame based on a harmonization specification
#'
#' @inheritParams harmonize_df
#' @inheritParams .shared_params
#' @returns The input `.data` harmonized to a [tibble::tibble()].
#' @keywords internal
.harmonize_df_spec <- function(
  .data,
  .spec,
  .call = rlang::caller_env()
) {
  .data_lst <- rlang::set_names(vector("list", length(.spec)), names(.spec))
  for (col_name in names(.spec)) {
    .data_lst[[col_name]] <- .harmonize_col(
      .data,
      .spec,
      col_name,
      .call = .call
    )
  }
  .data_lst <- c(.data_lst, .data[setdiff(names(.data), names(.spec))])
  return(tibble::as_tibble(.data_lst))
}

#' Harmonize a data frame based on custom harmonization calls
#'
#' @inheritParams harmonize_df
#' @inheritParams .shared_params
#' @returns A `data.frame` with custom harmonizations applied.
#' @keywords internal
.harmonize_df_dots <- function(
  .data,
  ...,
  .call = rlang::caller_env()
) {
  if (!...length()) {
    return(.data)
  }
  dots <- rlang::enquos(..., .named = TRUE)
  for (col_name in names(dots)) {
    .data[[col_name]] <- rlang::eval_tidy(dots[[col_name]], data = .data)
  }
  return(.data)
}

#' Harmonize data frame column names against a specification
#'
#' This will almost definitely migrate to stbl in the future.
#'
#' @inheritParams harmonize_df
#' @inheritParams .shared_params
#' @returns A `data.frame`, possibly with columns removed.
#' @keywords internal
.harmonize_col_names <- function(
  .data,
  .spec,
  .unspecified_columns,
  .call = rlang::caller_env()
) {
  .stop_if_missing_col_names(.data, .spec, .call = .call)
  .harmonize_extra_col_names(.data, .spec, .unspecified_columns, .call = .call)
}

#' Stop if data frame is missing columns from specification
#'
#' @inheritParams harmonize_df
#' @inheritParams .shared_params
#' @returns `NULL` (invisibly)
#' @keywords internal
.stop_if_missing_col_names <- function(
  .data,
  .spec,
  .call = rlang::caller_env()
) {
  missing_from_data <- setdiff(names(.spec), names(.data))
  if (length(missing_from_data)) {
    .hrmn_abort(
      c(
        "The data frame is missing columns required by the specification.",
        i = "Missing columns: {missing_from_data}."
      ),
      "col_mismatch",
      .call = .call,
      message_env = rlang::current_env()
    )
  }
}

#' Harmonize extra data frame column names not in specification
#'
#' @inheritParams harmonize_df
#' @inheritParams .shared_params
#' @returns A `data.frame`, possibly with columns removed.
#' @keywords internal
.harmonize_extra_col_names <- function(
  .data,
  .spec,
  .unspecified_columns,
  .call = rlang::caller_env()
) {
  extra_in_data <- setdiff(names(.data), names(.spec))
  if (length(extra_in_data)) {
    .data <- switch(
      .unspecified_columns,
      error = .hrmn_abort(
        c(
          "The data frame has columns not present in the specification.",
          i = "Extra columns: {extra_in_data}.",
          i = "Set {.arg .unspecified_columns} to {.str drop} to remove extra columns.",
          i = "Set {.arg .unspecified_columns} to {.str keep} to remove extra columns."
        ),
        "col_mismatch",
        .call = .call,
        message_env = rlang::current_env()
      ),
      drop = .data[names(.spec)],
      keep = .data
    )
  }
  return(.data)
}

#' Harmonize a specific column within a data.frame
#'
#' @param .col_name (`length-1 character`) The name of the column to harmonize
#'   within `.data`.
#' @inheritParams harmonize_df
#' @inheritParams .shared_params
#' @inherit harmonize_df return
#' @keywords internal
.harmonize_col <- function(
  .data,
  .spec,
  .col_name,
  .call = rlang::caller_env()
) {
  this_spec <- .spec[[.col_name]]
  if (inherits(this_spec, "hrmn_spec_fct")) {
    return(harmonize_fct(.data[[.col_name]], .spec = this_spec))
  } else {
    .stop_col_has_unknown_spec(.col_name, class(this_spec), .call = .call)
  }
}

#' Stop if a column has an unknown specification class
#'
#' @param .col_name (`length-1 character`) The name of the column.
#' @param class (`character`) The classes of the column specification.
#' @inheritParams .shared_params
#' @keywords internal
.stop_col_has_unknown_spec <- function(
  .col_name,
  class,
  .call = rlang::caller_env()
) {
  .hrmn_abort(
    c(
      "Column specification must be created with a known `specify_*()` function.",
      i = "Column {(.col_name)} has specification type {.cls {class[[1]]}}."
    ),
    "unknown_spec",
    .call = .call,
    message_env = rlang::current_env()
  )
}
