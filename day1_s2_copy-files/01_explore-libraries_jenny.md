01\_explore-libraries\_jenny.R
================
rvbguy1000
Wed Jan 31 14:53:50 2018

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

    ## [1] 125

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
    ##   NeedsCompilation     n  prop
    ##              <chr> <int> <dbl>
    ## 1               no    57 0.456
    ## 2              yes    63 0.504
    ## 3             <NA>     5 0.040

``` r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 4 x 3
    ##   Built     n  prop
    ##   <chr> <int> <dbl>
    ## 1 3.4.0    47 0.376
    ## 2 3.4.1    18 0.144
    ## 3 3.4.2    21 0.168
    ## 4 3.4.3    39 0.312

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
    ## [21] "desc"         "devtools"     "dichromat"    "digest"      
    ## [25] "dplyr"        "DT"           "enc"          "evaluate"    
    ## [29] "forcats"      "fs"           "ggplot2"      "gh"          
    ## [33] "git2r"        "glue"         "gridExtra"    "gtable"      
    ## [37] "haven"        "highr"        "hms"          "htmltools"   
    ## [41] "htmlwidgets"  "httpuv"       "httr"         "ini"         
    ## [45] "jsonlite"     "knitr"        "labeling"     "lazyeval"    
    ## [49] "lubridate"    "magrittr"     "markdown"     "memoise"     
    ## [53] "mime"         "mnormt"       "modelr"       "munsell"     
    ## [57] "openssl"      "pkgconfig"    "plogr"        "plyr"        
    ## [61] "praise"       "psych"        "purrr"        "R6"          
    ## [65] "RColorBrewer" "Rcpp"         "readr"        "readxl"      
    ## [69] "rematch"      "rematch2"     "reprex"       "reshape2"    
    ## [73] "rlang"        "rmarkdown"    "rprojroot"    "rstudioapi"  
    ## [77] "rvest"        "scales"       "selectr"      "shiny"       
    ## [81] "sourcetools"  "stringi"      "stringr"      "styler"      
    ## [85] "testthat"     "tibble"       "tidyr"        "tidyselect"  
    ## [89] "tidyverse"    "translations" "usethis"      "viridisLite" 
    ## [93] "whisker"      "withr"        "xml2"         "xtable"      
    ## [97] "yaml"

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
    ##   github     n  prop
    ##    <lgl> <int> <dbl>
    ## 1  FALSE    55  0.44
    ## 2   TRUE    70  0.56

Session Info

``` r
devtools::session_info()
```

    ## Session info -------------------------------------------------------------

    ##  setting  value                       
    ##  version  R version 3.4.3 (2017-11-30)
    ##  system   x86_64, darwin15.6.0        
    ##  ui       X11                         
    ##  language (EN)                        
    ##  collate  en_US.UTF-8                 
    ##  tz       America/Los_Angeles         
    ##  date     2018-01-31

    ## Packages -----------------------------------------------------------------

    ##  package    * version date       source        
    ##  assertthat   0.2.0   2017-04-11 CRAN (R 3.4.0)
    ##  backports    1.1.1   2017-09-25 CRAN (R 3.4.2)
    ##  base       * 3.4.3   2017-12-07 local         
    ##  bindr        0.1     2016-11-13 CRAN (R 3.4.0)
    ##  bindrcpp   * 0.2     2017-06-17 CRAN (R 3.4.0)
    ##  broom        0.4.3   2017-11-20 CRAN (R 3.4.2)
    ##  cellranger   1.1.0   2016-07-27 CRAN (R 3.4.0)
    ##  cli          1.0.0   2017-11-05 CRAN (R 3.4.2)
    ##  colorspace   1.3-2   2016-12-14 CRAN (R 3.4.0)
    ##  compiler     3.4.3   2017-12-07 local         
    ##  crayon       1.3.4   2017-09-16 CRAN (R 3.4.1)
    ##  datasets   * 3.4.3   2017-12-07 local         
    ##  devtools     1.13.4  2017-11-09 CRAN (R 3.4.2)
    ##  digest       0.6.12  2017-01-27 CRAN (R 3.4.0)
    ##  dplyr      * 0.7.4   2017-09-28 CRAN (R 3.4.2)
    ##  evaluate     0.10.1  2017-06-24 CRAN (R 3.4.1)
    ##  forcats    * 0.2.0   2017-01-23 CRAN (R 3.4.0)
    ##  foreign      0.8-69  2017-06-22 CRAN (R 3.4.3)
    ##  fs         * 1.1.0   2018-01-26 CRAN (R 3.4.3)
    ##  ggplot2    * 2.2.1   2016-12-30 CRAN (R 3.4.0)
    ##  glue         1.2.0   2017-10-29 CRAN (R 3.4.2)
    ##  graphics   * 3.4.3   2017-12-07 local         
    ##  grDevices  * 3.4.3   2017-12-07 local         
    ##  grid         3.4.3   2017-12-07 local         
    ##  gtable       0.2.0   2016-02-26 CRAN (R 3.4.0)
    ##  haven        1.1.0   2017-07-09 CRAN (R 3.4.1)
    ##  hms          0.4.0   2017-11-23 CRAN (R 3.4.3)
    ##  htmltools    0.3.6   2017-04-28 CRAN (R 3.4.0)
    ##  httr         1.3.1   2017-08-20 CRAN (R 3.4.1)
    ##  jsonlite     1.5     2017-06-01 CRAN (R 3.4.0)
    ##  knitr        1.17    2017-08-10 CRAN (R 3.4.1)
    ##  lattice      0.20-35 2017-03-25 CRAN (R 3.4.3)
    ##  lazyeval     0.2.1   2017-10-29 CRAN (R 3.4.2)
    ##  lubridate    1.7.1   2017-11-03 CRAN (R 3.4.2)
    ##  magrittr     1.5     2014-11-22 CRAN (R 3.4.0)
    ##  memoise      1.1.0   2017-04-21 CRAN (R 3.4.0)
    ##  methods    * 3.4.3   2017-12-07 local         
    ##  mnormt       1.5-5   2016-10-15 CRAN (R 3.4.0)
    ##  modelr       0.1.1   2017-07-24 CRAN (R 3.4.1)
    ##  munsell      0.4.3   2016-02-13 CRAN (R 3.4.0)
    ##  nlme         3.1-131 2017-02-06 CRAN (R 3.4.3)
    ##  parallel     3.4.3   2017-12-07 local         
    ##  pkgconfig    2.0.1   2017-03-21 CRAN (R 3.4.0)
    ##  plyr         1.8.4   2016-06-08 CRAN (R 3.4.0)
    ##  psych        1.7.8   2017-09-09 CRAN (R 3.4.2)
    ##  purrr      * 0.2.4   2017-10-18 CRAN (R 3.4.2)
    ##  R6           2.2.2   2017-06-17 CRAN (R 3.4.0)
    ##  Rcpp         0.12.14 2017-11-23 CRAN (R 3.4.3)
    ##  readr      * 1.1.1   2017-05-16 CRAN (R 3.4.0)
    ##  readxl       1.0.0   2017-04-18 CRAN (R 3.4.0)
    ##  reshape2     1.4.2   2016-10-22 CRAN (R 3.4.0)
    ##  rlang        0.1.4   2017-11-05 CRAN (R 3.4.2)
    ##  rmarkdown    1.8     2017-11-17 CRAN (R 3.4.2)
    ##  rprojroot    1.2     2017-01-16 CRAN (R 3.4.0)
    ##  rstudioapi   0.7     2017-09-07 CRAN (R 3.4.1)
    ##  rvest        0.3.2   2016-06-17 CRAN (R 3.4.0)
    ##  scales       0.5.0   2017-08-24 CRAN (R 3.4.1)
    ##  stats      * 3.4.3   2017-12-07 local         
    ##  stringi      1.1.6   2017-11-17 CRAN (R 3.4.2)
    ##  stringr    * 1.2.0   2017-02-18 CRAN (R 3.4.0)
    ##  tibble     * 1.3.4   2017-08-22 CRAN (R 3.4.1)
    ##  tidyr      * 0.7.2   2017-10-16 CRAN (R 3.4.2)
    ##  tidyverse  * 1.2.1   2017-11-14 CRAN (R 3.4.2)
    ##  tools        3.4.3   2017-12-07 local         
    ##  utils      * 3.4.3   2017-12-07 local         
    ##  withr        2.1.1   2017-12-19 CRAN (R 3.4.3)
    ##  xml2         1.1.1   2017-01-24 CRAN (R 3.4.0)
    ##  yaml         2.1.15  2017-12-01 CRAN (R 3.4.3)
