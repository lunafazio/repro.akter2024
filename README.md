
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
library(repro.akter2024)
dfOR <- load_data("OR") # Loads the data for Odds Ratio measures
dfMD <- load_data("MD") # Loads the data for Mean Difference measures
```

### Reproducing study tables

Table 1 is omitted as it does not present analysis results.

``` r
make_table2()
make_table3()
make_table4()
```