test_that("harmonize_df() works with an empty data frame", {
  expect_identical(
    harmonize_df(data.frame()),
    tibble::tibble()
  )
})

test_that("harmonize_df() errors if .spec is not a hrmn_spec_df", {
  expect_error(
    harmonize_df(data.frame(x = c("a", "b")), .spec = list(x = "not a spec")),
    class = "hrmn-error-not_spec"
  )
  expect_error(
    harmonize_df(data.frame(x = c("a", "b")), .spec = specify_fct()),
    class = "hrmn-error-bad_spec"
  )
})

test_that("harmonize_df() errors if spec contains unknown spec class", {
  df <- data.frame(x = "x")
  spec <- specify_df(x = specify_fct(levels = c("a")))
  class(spec$x)[[1]] <- "hrmn_spec_unknown"
  expect_error(
    harmonize_df(df, .spec = spec),
    class = "hrmn-error-unknown_spec"
  )
})

test_that("harmonize_df() errors for missing columns with default .unspecified_columns", {
  spec <- specify_df(
    x = specify_fct(levels = c("a", "b"))
  )
  missing_cols <- data.frame(
    y = factor(c("a", "b", "c", NA))
  )
  expect_error(
    harmonize_df(missing_cols, .spec = spec),
    class = "hrmn-error-col_mismatch"
  )
})

test_that("harmonize_df() errors for extra columns with default .unspecified_columns", {
  spec <- specify_df(
    x = specify_fct(levels = c("a", "b"))
  )
  extra_cols <- data.frame(
    x = factor(c("a", "b", "c", NA)),
    y = 1
  )
  expect_error(
    harmonize_df(extra_cols, .spec = spec),
    class = "hrmn-error-col_mismatch"
  )
})

test_that("harmonize_df() works with a single-column data frame", {
  df <- data.frame(
    x = factor(c("a", "b", "c", NA))
  )
  spec <- specify_df(
    x = specify_fct(levels = c("a", "b"))
  )
  expected <- tibble::tibble(
    x = factor(c("a", "b", NA, NA), levels = c("a", "b"))
  )
  expect_identical(
    harmonize_df(df, .spec = spec),
    expected
  )
})

test_that("harmonize_df() can keep unspecified columns", {
  df <- data.frame(
    x = factor(c("a", "b", "c", NA)),
    y = 1:4
  )
  spec <- specify_df(
    x = specify_fct(levels = c("a", "b"))
  )
  expected <- tibble::tibble(
    x = factor(c("a", "b", NA, NA), levels = c("a", "b")),
    y = 1:4
  )
  expect_identical(
    harmonize_df(df, .spec = spec, .unspecified_columns = "keep"),
    expected
  )
})

test_that("harmonize_df() can drop unspecified columns", {
  df <- data.frame(
    x = factor(c("a", "b", "c", NA)),
    y = 1:4
  )
  spec <- specify_df(
    x = specify_fct(levels = c("a", "b"))
  )
  expected <- tibble::tibble(
    x = factor(c("a", "b", NA, NA), levels = c("a", "b"))
  )
  expect_identical(
    harmonize_df(df, .spec = spec, .unspecified_columns = "drop"),
    expected
  )
})

test_that("harmonize_df() can use custom harmonization calls", {
  df <- data.frame(
    x = factor(c("a", "b", "c", NA)),
    y = 1:4
  )
  spec <- specify_df(
    x = specify_fct(levels = c("A", "B"))
  )
  expected <- tibble::tibble(
    x = factor(c("A", "B", NA, NA), levels = c("A", "B")),
    y = 1:4
  )
  expect_identical(
    harmonize_df(
      df,
      .spec = spec,
      .unspecified_columns = "keep",
      x = harmonize_fct(toupper(x))
    ),
    expected
  )
})
