# hrmn design principles

*This is an experiment in making key package design principles explicit, versus only implicit in the code. The goal is to make maintenance easier, when spread out over time and across people. This idea was copied from [usethis](https://github.com/r-lib/usethis/blob/main/principles.md).*

*These principles are a work in progress.*

## Function Naming Conventions

Internal helper functions follow specific naming patterns to make their purpose
clear at a glance.

-`.*()`: Internal helper functions that are not exported. `.`-prefixed versions of the families below might exist.
- `harmonize_*()`: Functions that take a data object (like a vector or data frame) and (usually) a harmonization specification, apply the harmonization, and return the modified data object. These functions form the core logic of the package.
- `specify_*()`: Functions that create and return a harmonization specification object, which defines the target structure and constraints for data harmonization. These functions are used to set up the harmonization process.
- `.stop_if_*()`: Functions that conditionally throw an error based on some unmet criteria. If the condition is not met, they should return `invisible(NULL)` (generally "automatically" via `if ()`. Generally used for input validation.
- `.stop_*()` (not `_if_`): Functions that unconditionally throw a specific, named error. These are used to abstract the call to `.hrmn_abort()` for common error conditions.
- `.to_*()`: Functions that attempt to coerce an object to a specific class, e.g., `.to_hrmn_spec()`.
