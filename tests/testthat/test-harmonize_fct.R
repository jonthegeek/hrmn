test_that("harmonize_fct() with empty vector returns an empty factor with no levels", {
  expect_identical(
    {
      harmonize_fct(factor())
    },
    factor()
  )
})

test_that("harmonize_fct() with character vector and no spec returns a factor", {
  expect_identical(
    {
      harmonize_fct(c("a", "b", "c"))
    },
    factor(c("a", "b", "c"))
  )
})

test_that("harmonize_fct() drops unspecified levels", {
  expect_identical(
    {
      harmonize_fct(factor(c("a", "b")), .spec = specify_fct(levels = "a"))
    },
    factor(c("a", NA), levels = "a")
  )
})


test_that("harmonize_fct() errors if .spec is not named", {
  expect_error(
    {
      harmonize_fct(factor(c("a", "b")), specify_fct(levels = "a"))
    },
    class = "rlib_error_dots_nonempty"
  )
})

test_that("The first `harmonize_fct()` argument is `.data`", {
  expect_equal(
    rlang::fn_fmls_names(harmonize_fct)[1],
    ".data"
  )
})

test_that("harmonize_fct() preserves existing NAs", {
  expect_equal(
    {
      harmonize_fct(factor(c("a", "b", NA)), .spec = specify_fct(levels = "a"))
    },
    factor(c("a", NA, NA), levels = "a")
  )
})

test_that("harmonize_fct() works with character vectors", {
  expect_equal(
    {
      harmonize_fct(c("a", "b"), .spec = specify_fct(levels = "a"))
    },
    factor(c("a", NA), levels = "a")
  )
})

test_that("harmonize_fct() works with an empty spec", {
  expect_equal(
    {
      harmonize_fct(
        factor(c("a", "b")),
        .spec = specify_fct(levels = character())
      )
    },
    factor(c(NA, NA), levels = character())
  )
})

test_that("harmonize_fct() uses .lookup table", {
  expect_equal(
    {
      harmonize_fct(
        c("x", "y", "z"),
        .spec = specify_fct(levels = c("a", "b")),
        .lookup = c(x = "a", y = "a", z = "b")
      )
    },
    factor(c("a", "a", "b"), levels = c("a", "b"))
  )
})

test_that("harmonize_fct() .lookup values not in levels become NA", {
  expect_equal(
    {
      harmonize_fct(
        "x",
        .spec = specify_fct(levels = "a"),
        .lookup = c(x = "b")
      )
    },
    factor(NA_character_, levels = "a")
  )
})
