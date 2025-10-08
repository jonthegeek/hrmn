test_that("specify_df() returns a hrmn_spec_df object", {
  expect_s3_class(
    specify_df(),
    c("hrmn_spec_df", "hrmn_spec", "list"),
    exact = TRUE
  )
})

test_that("specify_df() captures a single column specification", {
  spec <- specify_fct(levels = c("a", "b"))
  expected <- structure(
    list(col1 = spec),
    class = c("hrmn_spec_df", "hrmn_spec", "list")
  )
  expect_identical(specify_df(col1 = spec), expected)
})

test_that("specify_df() errors if dots are unnamed", {
  expect_error(
    specify_df(specify_fct(levels = c("a", "b"))),
    class = "hrmn-error-args_unnamed"
  )
})

test_that("specify_df() errors if arguments are not hrmn_spec objects", {
  expect_error(
    specify_df(col1 = "not a spec"),
    class = "hrmn-error-args_not_spec"
  )
  expect_error(
    specify_df(
      col1 = specify_fct(levels = c("a", "b")),
      col2 = 123
    ),
    class = "hrmn-error-args_not_spec"
  )
  expect_snapshot(
    specify_df(col2 = 123),
    error = TRUE
  )
})
