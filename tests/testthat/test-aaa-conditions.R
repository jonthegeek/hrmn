test_that(".hrmn_abort() throws the expected error", {
  expect_error(
    .hrmn_abort("A message.", "a_subclass"),
    class = "hrmn-error-a_subclass"
  )
  expect_error(
    .hrmn_abort("A message.", "a_subclass"),
    class = "hrmn-error"
  )
  expect_error(
    .hrmn_abort("A message.", "a_subclass"),
    class = "hrmn-condition"
  )
  expect_snapshot(
    .hrmn_abort("A message.", "a_subclass"),
    error = TRUE
  )
})

test_that(".hrmn_abort() uses parent when provided", {
  parent_cnd <- rlang::catch_cnd(cli::cli_abort("parent message"))
  expect_snapshot(
    .hrmn_abort("child message", "child_class", parent = parent_cnd),
    error = TRUE
  )
})

test_that(".hrmn_abort() passes dots to cli_abort()", {
  expect_error(
    .hrmn_abort("A message.", "a_subclass", .internal = TRUE),
    class = "hrmn-error-a_subclass"
  )
  expect_snapshot(
    .hrmn_abort("A message.", "a_subclass", .internal = TRUE),
    error = TRUE
  )
})

test_that(".hrmn_abort() uses message_env when provided", {
  var <- "a locally defined var"
  msg_env <- new.env()
  msg_env$var <- "a custom environment"
  expect_snapshot(
    .hrmn_abort(
      "This message comes from {var}.",
      "subclass",
      message_env = msg_env
    ),
    error = TRUE
  )
})

test_that(".compile_error_class() works", {
  expect_equal(
    .compile_error_class("hrmn", "error", "my_subclass"),
    "hrmn-error-my_subclass"
  )
  expect_equal(
    .compile_error_class("hrmn", "error"),
    "hrmn-error"
  )
  expect_equal(
    .compile_error_class("hrmn", "condition"),
    "hrmn-condition"
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
