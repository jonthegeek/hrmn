# .hrmn_abort() throws the expected error

    Code
      .hrmn_abort("A message.", "a_subclass")
    Condition
      Error:
      ! A message.

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

