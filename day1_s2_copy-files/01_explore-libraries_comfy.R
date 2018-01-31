library(tidyverse)
#' Which libraries does R search for packages?

# try .libPaths(), .Library
.libPaths()
.Library
#' Installed packages

## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View() or similar to inspect

## how many packages?
mypackages <- tibble::as.tibble(installed.packages())
View(mypackages)
nrow(mypackages)

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
##   * what proportion need compilation?
##   * how break down re: version of R they were built on
table(mypackages$LibPath)
table(mypackages$Priority)
table(mypackages$LibPath, mypackages$Priority)

## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))
mypackages %>% count(LibPath)
mypackages %>% count(LibPath,Priority)
mypackages %>% count(NeedsCompilation) %>% mutate(prop = n / sum(n))
mypackages %>% count(Version)

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
mypackages %>% 
  filter(Priority %in% c("base","recommended")) %>% 
  arrange(Priority) %>% 
  View()

#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
list.files(.Library)
## study package naming style (all lower case, contains '.', etc

## use `fields` argument to installed.packages() to get more info and use it!
mypackages2 <- tibble::as.tibble(installed.packages(fields = c("Encoding", "Repository","URL"))) %>% 
  mutate(github = stringr::str_detect(URL,"github"))

mypackages2 %>% 
  count(github)

