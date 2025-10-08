test_that("specify_fct() returns a hrmn_spec_fct object", {
  expect_s3_class(
    specify_fct(),
    c("hrmn_spec_fct", "hrmn_spec", "list"),
    exact = TRUE
  )
})

test_that("specify_fct() stores the levels", {
  lvls <- c("a", "b", "c")
  spec <- specify_fct(levels = lvls)
  expect_equal(spec$levels, lvls)
})
