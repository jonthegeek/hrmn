
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hrmn

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/hrmn)](https://CRAN.R-project.org/package=hrmn)
[![Codecov test
coverage](https://codecov.io/gh/jonthegeek/hrmn/graph/badge.svg)](https://app.codecov.io/gh/jonthegeek/hrmn)
[![R-CMD-check](https://github.com/jonthegeek/hrmn/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jonthegeek/hrmn/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

A common early step during data analysis is data harmonization:
converting disparate datasets into a unified, consistent format, with
consistent column names, classes, and values. The goal of hrmn is to
make this process as easy as it can be.

hrmn provides a declarative, schema-first framework for defining a
target data structure and then mapping various source data frames to
that structure. By separating the definition of the target state from
the transformation logic, hrmn makes the data intake process more
robust, readable, and maintainable. It builds upon the validation and
stabilization principles of the [{stbl}](https://stbl.api2r.org)
package, extending them to handle more complex data-cleaning tasks like
value lookups and case conversions.

## Installation

You can install the development version of hrmn from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("jonthegeek/hrmn")
```

## Usage

The hrmn workflow is organized around two core function families:
**`specify_*()`** and **`harmonize_*()`**. The `specify_*()` family
(e.g., `specify_df()`, `specify_fct()`) is used to create a
“specification” object. This object acts as a formal contract,
declaratively defining the exact column names, data types, and
constraints (such as allowed factor levels or value ranges) of the
target object.

Once a specification is defined, the **`harmonize_*()`** family (e.g.,
`harmonize_df()`, `harmonize_fct()`) is used to transform the source
data. These functions take a messy input data frame and the target
specification, along with a set of mapping rules that describe how to
convert the source columns into their target forms. This process ensures
that the final output not only has the correct structure but that its
values have been cleaned and validated, with clear errors for any data
that cannot be conformed to the specification.

## Code of Conduct

Please note that the hrmn project is released with a [Contributor Code
of Conduct](https://jonthegeek.github.io/hrmn/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
