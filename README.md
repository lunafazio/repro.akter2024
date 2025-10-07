
# repro.akter2024

The goal of this package is to provide a convenient interface for interacting
with the replication materials for [Akter et al. 2024](https://www.nature.com/articles/s41562-024-02002-7).

## Installation

You can install this package from GitHub using `devtools`:

``` r
# install.packages("devtools")
devtools::install_github("lunafazio/repro.akter2024")
```

If GitHub is giving you issues, you can also download the repository zip and do
a local install:

``` r
devtools::install_local("yourpath/Downloads/repro.akter2024-main.zip")
```

## Usage

### Loading study data

``` r
library(repro.akter2024) # First load the package
dfOR <- load_data("OR") # Loads the data for Odds Ratio measures
dfMD <- load_data("MD") # Loads the data for Mean Difference measures
```

The `xls` files published with the original study are included along with the
package. The `load_data` function takes the information directly from those
files and shows the local path where they have been stored when called.

### Reproducing study tables

Table 1 is omitted as it does not present analysis results.

``` r
make_table2()
make_table3()
make_table4()
```

Detailed processing steps can be found in [R/tables.R](https://github.com/lunafazio/repro.akter2024/blob/main/R/tables.R).

### Reproducing study figures

Figures 1 and 4 are omitted.

``` r
# NOTE: These functions will generate PDF files in your working directory
make_fig2()
make_fig3()
```

Detailed processing steps can be found in [R/figures.R](https://github.com/lunafazio/repro.akter2024/blob/main/R/figures.R).

## Acknowledgements

The code in this package is adapted from the original R scripts provided by the
authors of the study, available at [ryotanakamura1/smoking](https://github.com/ryotanakamura1/smoking).
The original script is available in plain text format at
[inst/original/akter2024.R](https://github.com/lunafazio/repro.akter2024/blob/main/inst/original/akter2024.R).

This package was developed as part of the 2025 FU Berlin Replication Games.
