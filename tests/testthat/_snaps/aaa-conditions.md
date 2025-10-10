# .hrmn_abort() throws the expected error

    Code
      .hrmn_abort("A message.", "a_subclass")
    Condition
      Error:
      ! A message.

# .stop_if_args_unnamed() works

    Code
      .stop_if_args_unnamed(1)
    Condition
      Error:
      ! All arguments must be named.

# .stop_if_args_not_spec() works

    Code
      .stop_if_args_not_spec(a = 1)
    Condition
      Error:
      ! All arguments must be `hrmn_spec` objects.
      x Argument `a` is not a `hrmn_spec` object.

---

    Code
      .stop_if_args_not_spec(a = 1, b = "B")
    Condition
      Error:
      ! All arguments must be `hrmn_spec` objects.
      x Arguments `a` and `b` are not `hrmn_spec` objects.

---

    Code
      .stop_if_args_not_spec(a = 1, b = spec)
    Condition
      Error:
      ! All arguments must be `hrmn_spec` objects.
      x Argument `a` is not a `hrmn_spec` object.

---

    Code
      .stop_if_args_not_spec(1)
    Condition
      Error:
      ! All arguments must be `hrmn_spec` objects.
      x Argument `<unnamed>` is not a `hrmn_spec` object.

