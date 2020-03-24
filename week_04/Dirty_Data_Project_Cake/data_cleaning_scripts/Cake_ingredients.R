


library(tidyverse)
library(dplyr)
library(stringr)
library(janitor)
library(here)


#Task 2 - Cake ingredients

# Load data from first csv file  


cake_ingredient_code <- read_csv("raw_data/cake_ingredient_code.csv")


# Variable names

names(cake_ingredient_code)




# 1.2 This data is not in tidy form and needs some cleaning before we start analysising.

# 1.3

# Data is in wide format and needs to be long format



# Reshape the data from wide to long format, so that for each code column becomes a row. Name the column code  and values into quantity

cake_ingredients <-
  cake_ingredients_1961 %>%
  pivot_longer(-Cake, names_to = "code", values_to = "quantity")



# 1.4 now we needs count missing values


# # counting missing values

cake_ingredients %>%
  summarise(count = sum(is.na(quantity)))


# 1.5

# There are so many missing values so we need deciede whether to keep them of drop them


# There are lots of missing values. I would drop the values because otherwise, I will be imputing more missing values than I have.


cake_ingredients <-
  
  cake_ingredients %>%
  drop_na()



# Left_join here beacsue we need actual ingredients from data set2

cake_ingredients_clean <-
  
  cake_ingredients %>%
  left_join(cake_ingredient_code, by = "code")


# Write clean data to csv
write_csv(cake_ingredients_clean, 'clean_data/cake_ingredients_clean.csv')











