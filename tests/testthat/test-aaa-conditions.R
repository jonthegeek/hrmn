test_that(".hrmn_abort() throws the expected error", {
  stbl::expect_pkg_error_classes(
    .hrmn_abort("A message.", "a_subclass"),
    "hrmn",
    "a_subclass"
  )
  expect_snapshot(
    .hrmn_abort("A message.", "a_subclass"),
    error = TRUE
  )
})

test_that(".check_args_named() works", {
  expect_no_error(.check_args_named())
  expect_no_error(.check_args_named(a = 1))
  expect_no_error(.check_args_named(a = 1, b = 2))

  expect_error(.check_args_named(1), class = "hrmn-error-args_unnamed")
  expect_error(.check_args_named(a = 1, 2), class = "hrmn-error-args_unnamed")
  expect_error(.check_args_named(1, 2), class = "hrmn-error-args_unnamed")
  expect_snapshot(.check_args_named(1), error = TRUE)
})

test_that(".check_args_spec() works", {
  expect_no_error(.check_args_spec())
  spec <- structure(list(), class = "hrmn_spec")
  expect_no_error(.check_args_spec(a = spec))
  expect_no_error(.check_args_spec(a = spec, b = spec))

  expect_error(.check_args_spec(a = 1), class = "hrmn-error-args_not_spec")
  expect_error(
    .check_args_spec(a = spec, b = "B"),
    class = "hrmn-error-args_not_spec"
  )
  expect_error(
    .check_args_spec(a = 1, b = 2),
    class = "hrmn-error-args_not_spec"
  )
  expect_snapshot(.check_args_spec(a = 1), error = TRUE)
  expect_snapshot(.check_args_spec(a = 1, b = "B"), error = TRUE)
  expect_snapshot(.check_args_spec(a = 1, b = spec), error = TRUE)
  expect_snapshot(.check_args_spec(1), error = TRUE)
})
