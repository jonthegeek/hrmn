# Developer note: `specify_fct()` is designed to create a data-less
# "specification" object. It defines the target state (the levels) for a factor
# but doesn't hold any actual factor data itself. This is why the constructor
# internally provides `integer()` as the data component to `S7::new_object()`.
#
# In the future, we might use the `hrmn_fct` class to represent actual,
# harmonized factor data. In that scenario, we would likely create a separate
# `class_hrmn_fct` object and have `specify_fct()` be a wrapper function that
# calls the constructor with the empty data. For now, since we don't need the
# full factor-like class, we are directly defining the `hrmn_fct` class in
# `specify_fct()`

#' Specify a factor harmonization
#'
#' Create a `hrmn_fct` object that specifies the desired levels for a factor
#' variable. This 'specification' object does not contain any data itself, only
#' the rules for harmonization.
#'
#' @param levels (`character`) The allowed values of the factor.
#' @returns A factor specification, an S7 object of class `hrmn::hrmn_fct`.
#' @export
specify_fct <- S7::new_class(
  "hrmn_fct",
  parent = S7::class_factor,
  properties = list(
    levels = S7::class_character
  ),
  constructor = function(levels = character()) {
    S7::new_object(
      integer(),
      levels = levels
    )
  }
)
