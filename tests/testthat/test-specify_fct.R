test_that("specify_fct() returns an object with the correct class", {
  spec <- specify_fct()
  expect_s3_class(
    spec,
    c("hrmn::hrmn_fct", "factor", "S7_object"),
    exact = TRUE
  )
})

test_that("specify_fct() stores the levels", {
  lvls <- c("a", "b", "c")
  spec <- specify_fct(levels = lvls)
  expect_equal(spec@levels, lvls)
})
