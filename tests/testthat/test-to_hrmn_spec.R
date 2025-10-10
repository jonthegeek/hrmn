test_that(".to_hrmn_spec errors if object is not NULL or hrmn_spec", {
  expect_error(
    .to_hrmn_spec("a"),
    class = "hrmn-error-not_spec"
  )
})

test_that(".to_hrmn_spec returns NULL if input is NULL", {
  expect_null(.to_hrmn_spec(NULL))
})

test_that(".to_hrmn_spec returns NULL input has length 0", {
  spec <- structure(list(), class = "hrmn_spec")
  expect_identical(.to_hrmn_spec(spec), NULL)
})

test_that(".to_hrmn_spec returns input if it is a hrmn_spec", {
  spec <- structure(list(a = 1), class = "hrmn_spec")
  expect_identical(.to_hrmn_spec(spec), spec)
})

test_that(".to_hrmn_spec checks spec subclass if .subclass is provided", {
  spec_fct <- structure(
    list(1),
    class = c("hrmn_spec_fct", "hrmn_spec", "list")
  )
  spec_df <- structure(list(1), class = c("hrmn_spec_df", "hrmn_spec", "list"))

  expect_identical(.to_hrmn_spec(spec_fct, .subclass = "fct"), spec_fct)
  expect_identical(.to_hrmn_spec(spec_df, .subclass = "df"), spec_df)

  expect_error(
    .to_hrmn_spec(spec_fct, .subclass = "df"),
    class = "hrmn-error-bad_spec"
  )
  expect_error(
    .to_hrmn_spec(spec_df, .subclass = "fct"),
    class = "hrmn-error-bad_spec"
  )
})
