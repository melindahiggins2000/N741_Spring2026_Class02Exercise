# R Script 02 =================================
# by Melinda Higgins
# dated 09/07/2022
# =============================================

# load original abalone dataset
library(readr)
abalone <- read_csv("abalone.csv")

# visualize these issues
# look at histogram of height
library(ggplot2)
ggplot(abalone, aes(height)) +
  geom_histogram()

# make prettier ===============================
# see R Graphics Cookbook by Winston Chang
# https://r-graphics.org/
# OR
# http://www.cookbook-r.com/Graphs/Plotting_distributions_(ggplot2)/
# Histogram overlaid with kernel density curve
# Histogram with density instead of count on y-axis
#   using y=..density..
# Overlay with transparent density plot
#   with alpha=0.2 for transparency
#   and fill = color via 6 character hex code
ggplot(abalone, aes(height)) + 
  geom_histogram(aes(y=..density..), 
                 binwidth=.02,
                 colour="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666")  

# get HEX CODES for colors at
# https://www.color-hex.com/color/ff6666


# also look at highest heights
# sort ascending and look at bottom rows
library(dplyr)
abalone %>%
  select(id, length, height) %>%
  arrange(height) %>%
  tail()

# notice that id 1418 has height = 0.515
# and id 2052 has height = 1.13
# which are both quite a bit larger than the next
# largest abalones with height = 0.25

# we already noted that id 2052 is probably a typo
# since height 1.13 is > length of 0.455
# but id 1418 measurements are probably ok
# it is just a large abalone

# look at 2D plots to visualize associations
# look at length and height
ggplot(abalone, aes(length, height)) +
  geom_point()

# add a blue y = x diagonal reference line
# any points above the line indicate
# abalones with height > length (i.e. incorrect)
ggplot(abalone, aes(length, height)) +
  geom_point() +
  geom_abline(intercept = 0,
              slope = 1,
              color = "blue")

# add colors for the 3 sex groups
# to see that the incorrect height is a F, female
# and the other large abalone is a M, male
ggplot(abalone, aes(length, height)) +
  geom_point(aes(color = sex)) +
  geom_abline(intercept = 0,
              slope = 1,
              color = "blue")

# YOUR TURN ===================================
# make a plot showing any outliers
# where diameter > length
# add reference line and
# add colors for sex



ggplot(abalone, aes(length, diameter)) +
  geom_point(aes(color = sex)) +
  geom_abline(intercept = 0,
              slope = 1,
              color = "blue")

# Given the work so far
# let's create a dataset with the 
# dimensional measures are cleaned up
# - remove abalones with height == 0 [2 abalones]
#   keep height > 0
# - remove abalones diameter > length [1 abalone]
#   keep diameter <= length
# - remove abalones height > length [1 abalone]
#   keep height <= length
library(dplyr)
abalone_dim_cleaned <- abalone %>%
  filter(height > 0) %>%
  filter(diameter <= length) %>%
  filter(height <= length) 

# this dataset has 4 abalones removed
# 4177 - 4 = 4173
abalone_dim_cleaned %>%
  nrow()

# saving your work ============================
# suppose you want to SAVE this cleaned dataset
# use save() function to save 
# one or more objects in a .RData formatted file
save(abalone_dim_cleaned,
     file = "abalone_dim_cleaned.RData")

# to test that this worked
# remove this object and load it back
rm(abalone_dim_cleaned)

# now load it back
load( "abalone_dim_cleaned.RData")
