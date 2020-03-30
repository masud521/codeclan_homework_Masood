
#  Task 4 - Halloween Candy Data

# The data is in files boing-boing-candy-2015.xlxs, 
# boing-boing-candy-2016.xlxs and boing-boing-candy-2017.xlxs

# 1.4.1 Some cleaning hints
# need to combine these three datasets together.

library(tidyverse)
library(janitor)
library(readxl)
library(dplyr)
library(stringr)

# Task 4 Halloween Candy data
# Load data from first csv file 


candies_2015 <- read_xlsx("raw_data/boing-boing-candy-2015.xlsx")
candies_2016 <- read_xlsx("raw_data/boing-boing-candy-2016.xlsx")
candies_2017 <- read_xlsx("raw_data/boing-boing-candy-2017.xlsx")


# 1.2 This data is not in tidy form and needs some cleaning before we start analysising.

# start with some cleaning of columns 

candies_2015 <- candies_2015 %>%
  clean_names()
candies_2016 <- candies_2016 %>%
  clean_names()
candies_2017 <- candies_2017 %>%
  clean_names()

#remove q6 from columns names of candies data 2017 so they can match with data 2015 and 2016()

names(candies_2017) <- str_remove(names(candies_2017), "q[0-9]+_")



# I have also noted some in uppercase and lowercase, so we change all text to lower case for better analysis of the data
# also, change the text to lower case of columns and rows

candies_2015 <- mutate_all(candies_2015, .funs = tolower)
candies_2016 <- mutate_all(candies_2016, .funs = tolower)
candies_2017 <- mutate_all(candies_2017, .funs = tolower)


# Renaming column in data set 2017 to match columns in 2016 and 2015

 candies_2017 <-
   candies_2017 %>%
   rename(x100_grand_bar = `100_grand_bar`)

# Reshape the data from wide to long format for all 3 data sets, so that for each candy bar column becomes a row. 
# Name the column candy  and values into rating 

pivot_candies_2015 <-

candies_2015 %>%
pivot_longer(butterfinger:york_peppermint_patties, names_to = "candy", values_to = "rating")

pivot_candies_2016 <-
  
  candies_2016 %>%
  pivot_longer(x100_grand_bar:york_peppermint_patties, names_to = "candy", values_to = "rating")


pivot_candies_2017 <-
  
  candies_2017 %>%
  pivot_longer(x100_grand_bar:york_peppermint_patties, names_to = "candy", values_to = "rating")



# Removing columns 

# We have some redundant columns. some of these variables which don't contain any useful data. 


pivot_candies_2015 <-
  pivot_candies_2015 %>%
  select(-please_leave_any_remarks_or_comments_regarding_your_choices)

# All these columns have no useful information so we can remove them. 

pivot_candies_2015 <-
  pivot_candies_2015 %>%
  select(-c(4:30))


pivot_candies_2016 <-
  pivot_candies_2016 %>%
  select(-timestamp)


pivot_candies_2016 <-
  pivot_candies_2016 %>%
  select(-c(5:22))



pivot_candies_2017 <-
  pivot_candies_2017 %>%
  select(-internal_id)


pivot_candies_2017 <-
  pivot_candies_2017 %>%
  select(-c(5:16))



# Renaming some columns in data set to match columns 

pivot_candies_2015 <-
  pivot_candies_2015 %>%
  rename(age = how_old_are_you, going_out = are_you_going_actually_going_trick_or_treating_yourself)


pivot_candies_2016 <-
  pivot_candies_2016 %>%
  rename(gender = your_gender, age = how_old_are_you, country = which_country_do_you_live_in)


# Make new variables 

# Add new columns to identify the in which year data is collected 

candies_2015_data <-
  pivot_candies_2015 %>%
  add_column(country = NA, gender = NA, year = 2015)

candies_2016_data <-
  pivot_candies_2016 %>%
  add_column(year = 2016)

candies_2017_data <-
  pivot_candies_2017 %>%
  add_column(year = 2017)



# Now we needs count missing values


# counting missing values

candies_2015_data %>%
  summarise(count = sum(is.na(rating)))

candies_2016_data %>%
  summarise(count = sum(is.na(rating)))

candies_2017_data %>%
  summarise(count = sum(is.na(rating)))


# Missing values

# There are so many missing values so we need deciede whether to keep them of drop them


# There are lots of missing values but I can drop them off later while analysing


# Combine data from all 3 data sets

candies_halloween_data <-
bind_rows(candies_2015_data, candies_2016_data, candies_2017_data)


# now we have a combined data set from 2015, 2016, 2017. 
# I have notice some discrepancies in country columns which needs to address before we proceed

# first create a vector with mispellings

misspellings <- c("united states of america", "alaska", "united states", "ussa", "usa!", "us", "u.s.a.", "usa (i think but it's an election year so who can really tell)","the best one - usa", "america", "merica", "usa! usa!", "usa", "america")

# replace misspellings with usa

halloween_candies <-
candies_halloween_data %>%
mutate(country = if_else(country == "united kingdom", "uk", country))

# mutate(country = if_else(country %in% misspellings, country, "usa"))


filter(halloween_candies, country == 'united kingdom')




























    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  



