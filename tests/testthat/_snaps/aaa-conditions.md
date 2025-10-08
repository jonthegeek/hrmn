# .hrmn_abort() throws the expected error

    Code
      .hrmn_abort("A message.", "a_subclass")
    Condition
      Error:
      ! A message.

# .hrmn_abort() uses parent when provided

    Code
      .hrmn_abort("child message", "child_class", parent = parent_cnd)
    Condition
      Error:
      ! child message
      Caused by error:
      ! parent message

# .hrmn_abort() passes dots to cli_abort()

    Code
      .hrmn_abort("A message.", "a_subclass", .internal = TRUE)
    Condition
      Error:
      ! A message.
      i This is an internal error that was detected in the hrmn package.
        Please report it at <https://github.com/jonthegeek/hrmn/issues> with a reprex (<https://tidyverse.org/help/>) and the full backtrace.

# .hrmn_abort() uses message_env when provided

    Code
      .hrmn_abort("This message comes from {var}.", "subclass", message_env = msg_env)
    Condition
      Error:
      ! This message comes from a custom environment.

# .check_args_named() works

    Code
      .check_args_named(1)
    Condition
      Error:
      ! All arguments must be named.

# .check_args_spec() works

    Code
      .check_args_spec(a = 1)
    Condition
      Error:
      ! All arguments must be `hrmn_spec` objects.
      x Argument `a` is not a `hrmn_spec` object.

---

    Code
      .check_args_spec(a = 1, b = "B")
    Condition
      Error:
      ! All arguments must be `hrmn_spec` objects.
      x Arguments `a` and `b` are not `hrmn_spec` objects.

---

    Code
      .check_args_spec(a = 1, b = spec)
    Condition
      Error:
      ! All arguments must be `hrmn_spec` objects.
      x Argument `a` is not a `hrmn_spec` object.

---

    Code
      .check_args_spec(1)
    Condition
      Error:
      ! All arguments must be `hrmn_spec` objects.
      x Argument `<unnamed>` is not a `hrmn_spec` object.

