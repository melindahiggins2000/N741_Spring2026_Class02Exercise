# R Script 01 =================================
# by Melinda Higgins
# dated 09/07/2022
# =============================================

# load the readr package ======================
# and use read_csv() to read in the abalone dataset
# and assign it to an object called abalone
library(readr)
abalone <- read_csv("abalone.csv")

# Explore data ================================
# using functions from base R
str(abalone)   # structure
dim(abalone)   # dimensions
head(abalone)  # top 6 rows
tail(abalone)  # bottom 6 rows

# data wrangling using dplyr package ==========
library(dplyr)

# try out the glimpse() function ==============
# from the dplyr() package
# very similar to str() but works well
# with "tidyverse" objects (using readr package)
glimpse(abalone)

# class() function ============================
# check out the type of object for abalone
# notice that this is not just a data.frame
# abalone is a spec_tbl_df, tbl_df = "tibble" data frame
# this is an enhanced "tidyverse" data frame
class(abalone)

# we can make a simple data.frame =============
abalone.df <- data.frame(abalone)
class(abalone.df)

# compare str() and glimpse() =================
str(abalone)
str(abalone.df)
glimpse(abalone)
glimpse(abalone.df)

# learn more about dplyr ======================
# see https://dplyr.tidyverse.org/
# notice that functions are verbs

# select variables - subset columns ===========
# select(.data, ...) 
# state data object, then list variables
select(abalone, sex, length, rings)

# save this 3 variable subset
a1 <- select(abalone, sex, length, rings)

# let's arrange (aka. sort) a1 by number of rings
# from smallest to largest - ascending
# arrange(.data, ...)
arrange(a1, rings, length)

# what do you notice? [smallest mostly infants]

# YOUR TURN ===================================
# see help(arrange, package = "dplyr")
# how do we sort descending?

arrange(a1, desc(rings))


arrange(a1, desc(rings))

# the pipe operator %>% =======================
# Think of the %>% as "and then" or "next do this"
# step by step programming
# data %>% 
#   function() %>% 
#   function() ...
# let's redo what we did above
# take the dataset abalone out
# and "pipe it" - send it to
# the select() function
# add any arguments to the select() function
abalone %>% 
  select(sex, length, rings)

# use the abalone dataset, and then
# select 3 variables: sex, length and rings, and then
# arrange this subset ascending by number of rings
abalone %>% 
  select(sex, length, rings) %>%
  arrange(rings)

# filter() - pull out only certain rows
# let's look at the youngest abalones
# with rings < 3
a1 %>%
  filter(rings < 3)

# pull out rows from a1 for abalones with
# length <= 0.2
a1 %>%
  filter(length <= 2 & sex == "M")

# and count how many have length <= 0.2
# hint: add dim() base R function 
# or nrow()
a1 %>%
  filter(length <= 0.2) %>%
  dim()

a1 %>%
  filter(length <= 0.2) %>%
  nrow()

# see the row id's of these abalones
# along with sex and length
# arrange by length
# and use print(n = Inf) to see all rows
abalone %>%
  #select(id, sex, rings) %>%
  filter(length <= 0.2) %>%
  select(id, sex, rings) %>%
  arrange(rings) %>%
  print(n = Inf)

# another option, slice_head() from dplyr
# see https://dplyr.tidyverse.org/reference/index.html
# display top 10 rows
abalone %>%
  filter(length <= 0.2) %>%
  select(id, sex, length) %>%
  arrange(length) %>%
  slice_head(n = 10)


# how many of the abalones
# with length <= 0.2 are infants?
# option 01 - use two filter steps
# NOTICE the use of == for "equal to"
abalone %>%
  filter(length <= 0.2) %>%
  filter(sex == "I") %>%
  nrow()

# option 02 - get table of sex frequencies
# for this subset with length <= 0.2
abalone %>%
  filter(length <= 0.2) %>%
  select(sex) %>%
  table()

# YOUR TURN ===================================
# how many abalones have
# height = 0 ?
# and what are their id's
abalone %>%
  filter(height == 0) %>%
  select(id)

# base R
# abalone[rows, cols]
abalone[abalone$height == 0, ]


abalone %>%
  filter(height == 0) %>%
  nrow()

abalone %>%
  filter(height == 0) %>%
  select(id, height)



# YOUR TURN ===================================
# how many abalones have
# diameter > length
# and what are the id's



abalone %>%
  filter(diameter > length) %>%
  select(id, diameter, length)



# YOUR TURN ===================================
# how many abalones have
# height > length



abalone %>%
  filter(height > length) %>%
  select(id, height, length)


# YOUR TURN - HOMEWORK 3
# you'll further explore the dataset
# to see if any abalones
# have weight measurements > wholeWeight
# look for any abalones with:
# shuckedWeight > wholeWeight
# visceraWeight > wholeWeight
# shellWeight > wholeWeight



abalone %>%
  filter(shuckedWeight > wholeWeight) %>%
  select(id, shuckedWeight, wholeWeight)
abalone %>%
  filter(visceraWeight > wholeWeight) %>%
  select(id, visceraWeight, wholeWeight)
abalone %>%
  filter(shellWeight > wholeWeight) %>%
  select(id, shellWeight, wholeWeight)
