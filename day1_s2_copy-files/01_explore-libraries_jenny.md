01\_explore-libraries\_jenny.R
================
rvbguy1000
Wed Jan 31 14:32:48 2018

``` r
library(fs)
library(tidyverse)
```

    ## ── Attaching packages ───────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.3.4     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.7.2     ✔ stringr 1.2.0
    ## ✔ readr   1.1.1     ✔ forcats 0.2.0

    ## ── Conflicts ──────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

Installed packages

``` r
ipt <- installed.packages() %>%
  as_tibble()

## how many packages?
nrow(ipt)
```

    ## [1] 123

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ipt %>%
  count(LibPath, Priority)
```

    ## # A tibble: 3 x 3
    ##                                                          LibPath
    ##                                                            <chr>
    ## 1 /Library/Frameworks/R.framework/Versions/3.4/Resources/library
    ## 2 /Library/Frameworks/R.framework/Versions/3.4/Resources/library
    ## 3 /Library/Frameworks/R.framework/Versions/3.4/Resources/library
    ## # ... with 2 more variables: Priority <chr>, n <int>

``` r
##   * what proportion need compilation?
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n       prop
    ##              <chr> <int>      <dbl>
    ## 1               no    56 0.45528455
    ## 2              yes    62 0.50406504
    ## 3             <NA>     5 0.04065041

``` r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 4 x 3
    ##   Built     n      prop
    ##   <chr> <int>     <dbl>
    ## 1 3.4.0    46 0.3739837
    ## 2 3.4.1    18 0.1463415
    ## 3 3.4.2    20 0.1626016
    ## 4 3.4.3    39 0.3170732

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ipt %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
```

    ##  [1] "arsenal"      "assertthat"   "backports"    "base64enc"   
    ##  [5] "BH"           "bindr"        "bindrcpp"     "bitops"      
    ##  [9] "broom"        "callr"        "caTools"      "cellranger"  
    ## [13] "cli"          "clipr"        "clisymbols"   "colorspace"  
    ## [17] "crayon"       "curl"         "DBI"          "dbplyr"      
    ## [21] "desc"         "dichromat"    "digest"       "dplyr"       
    ## [25] "DT"           "enc"          "evaluate"     "forcats"     
    ## [29] "fs"           "ggplot2"      "gh"           "git2r"       
    ## [33] "glue"         "gridExtra"    "gtable"       "haven"       
    ## [37] "highr"        "hms"          "htmltools"    "htmlwidgets" 
    ## [41] "httpuv"       "httr"         "ini"          "jsonlite"    
    ## [45] "knitr"        "labeling"     "lazyeval"     "lubridate"   
    ## [49] "magrittr"     "markdown"     "mime"         "mnormt"      
    ## [53] "modelr"       "munsell"      "openssl"      "pkgconfig"   
    ## [57] "plogr"        "plyr"         "praise"       "psych"       
    ## [61] "purrr"        "R6"           "RColorBrewer" "Rcpp"        
    ## [65] "readr"        "readxl"       "rematch"      "rematch2"    
    ## [69] "reprex"       "reshape2"     "rlang"        "rmarkdown"   
    ## [73] "rprojroot"    "rstudioapi"   "rvest"        "scales"      
    ## [77] "selectr"      "shiny"        "sourcetools"  "stringi"     
    ## [81] "stringr"      "styler"       "testthat"     "tibble"      
    ## [85] "tidyr"        "tidyselect"   "tidyverse"    "translations"
    ## [89] "usethis"      "viridisLite"  "whisker"      "withr"       
    ## [93] "xml2"         "xtable"       "yaml"

``` r
## study package naming style (all lower case, contains '.', etc

## use `fields` argument to installed.packages() to get more info and use it!
ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n      prop
    ##    <lgl> <int>     <dbl>
    ## 1  FALSE    55 0.4471545
    ## 2   TRUE    68 0.5528455
