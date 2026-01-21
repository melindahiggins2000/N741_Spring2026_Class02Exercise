# R Script 03 =================================
# by Melinda Higgins
# dated 09/07/2022
# =============================================

# load original abalone dataset
library(readr)
abalone <- read_csv("abalone.csv")

# more dplyr functions ========================
# create a new variable for age
# age = rings + 1.5
# use mutate() function from dplyr
library(dplyr)
abalone <- abalone %>%
  mutate(age = rings + 1.5)
  
# get summary statistics for age
abalone %>%
  summarise(mean_age = mean(age),
            sd_age = sd(age))

# other summary statistics options
abalone %>%
  select(age) %>%
  summary()

# check out Hmisc package, describe()
# notice syntax of package::function()
library(Hmisc)
abalone %>%
  select(age) %>%
  Hmisc::describe()

# also check out psych package, describe()
library(psych)
abalone %>%
  select(age) %>%
  psych::describe()
# this gives an error, psych needs a plain data.frame object

# convert to plain data.frame
data.frame(abalone) %>%
  select(age) %>%
  psych::describe()

# get summary statistics for age BY sex
# add group_by() step - works with dplyr functions
abalone %>%
  group_by(sex) %>%
  summarise(mean_age = mean(age),
            sd_age = sd(age))

# This does not work ...
# does not group by sex ... 
# but see options below ...
abalone %>%
  group_by(sex) %>%
  summary()

# get more statistics at once for a given variable
# see https://statisticsglobe.com/summary-statistics-by-group-in-r
abalone %>%
  group_by(sex) %>%
  summarise(min_age = min(age),
            mean_age = mean(age),
            sd_age = sd(age),
            median_age = median(age),
            max_age = max(age))

# tapply() approach - base R
tapply(X = abalone$age,
       INDEX = abalone$sex,
       FUN = summary)

# purrr package approach - works with tidyverse
library(purrr)

# split is similar to group_by
# the map specifies the function to "apply"
abalone %>%
  split(.$sex) %>%
  map(summary)

# this does work
abalone %>%
  split(.$sex) %>%
  map(psych::describe)

# get summary stats for the 3
# dimensional measurements
# select only sex, height, diameter, length
abalone %>%
  select(sex, height, diameter, length) %>%
  split(.$sex) %>%
  map(psych::describe)

# one more dplyr function, rename() ===========
# suppose we want to rename age
# to ageyr
# list current variable names
names(abalone)

# rename newname = oldname
abalone <- 
  abalone %>%
  rename(ageyr = age)

# list updated variable names
names(abalone)
