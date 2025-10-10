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

test_that(".stop_if_args_unnamed() works", {
  expect_no_error(.stop_if_args_unnamed())
  expect_no_error(.stop_if_args_unnamed(a = 1))
  expect_no_error(.stop_if_args_unnamed(a = 1, b = 2))

  expect_error(.stop_if_args_unnamed(1), class = "hrmn-error-args_unnamed")
  expect_error(
    .stop_if_args_unnamed(a = 1, 2),
    class = "hrmn-error-args_unnamed"
  )
  expect_error(.stop_if_args_unnamed(1, 2), class = "hrmn-error-args_unnamed")
  expect_snapshot(.stop_if_args_unnamed(1), error = TRUE)
})

test_that(".stop_if_args_not_spec() works", {
  expect_no_error(.stop_if_args_not_spec())
  spec <- structure(list(), class = "hrmn_spec")
  expect_no_error(.stop_if_args_not_spec(a = spec))
  expect_no_error(.stop_if_args_not_spec(a = spec, b = spec))

  expect_error(.stop_if_args_not_spec(a = 1), class = "hrmn-error-not_spec")
  expect_error(
    .stop_if_args_not_spec(a = spec, b = "B"),
    class = "hrmn-error-not_spec"
  )
  expect_error(
    .stop_if_args_not_spec(a = 1, b = 2),
    class = "hrmn-error-not_spec"
  )
  expect_snapshot(.stop_if_args_not_spec(a = 1), error = TRUE)
  expect_snapshot(.stop_if_args_not_spec(a = 1, b = "B"), error = TRUE)
  expect_snapshot(.stop_if_args_not_spec(a = 1, b = spec), error = TRUE)
  expect_snapshot(.stop_if_args_not_spec(1), error = TRUE)
})
