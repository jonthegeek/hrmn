test_that("specify_fct() returns an object with the correct class", {
  expect_s3_class(
    specify_fct(),
    c("hrmn_fct_spec", "hrmn_spec", "list"),
    exact = TRUE
  )
})

test_that("specify_fct() stores the levels", {
  lvls <- c("a", "b", "c")
  spec <- specify_fct(levels = lvls)
  expect_equal(spec$levels, lvls)
})
