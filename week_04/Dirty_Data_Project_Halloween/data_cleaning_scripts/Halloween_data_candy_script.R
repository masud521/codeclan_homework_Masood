
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


boing_candy_2015 <- read_xlsx("raw_data/boing-boing-candy-2015.xlsx")
boing_candy_2016 <- read_xlsx("raw_data/boing-boing-candy-2016.xlsx")
boing_candy_2017 <- read_xlsx("raw_data/boing-boing-candy-2017.xlsx")

# 1.2 This data is not in tidy form and needs some cleaning before we start analysising.

# start with some cleaning of columns 

boing_candy_2015 <- boing_candy_2015 %>%
  clean_names()
boing_candy_2016 <- boing_candy_2016 %>%
  clean_names()
boing_candy_2017 <- boing_candy_2017 %>%
  clean_names()

# I have also noted some in uppercase and lowercase, so we change all text to lower case for better analysis of the data
# also, change the text to lower case of columns and rows

boing_candy_2015 <- mutate_all(boing_candy_2015, .funs = tolower)
boing_candy_2016 <- mutate_all(boing_candy_2016, .funs = tolower)
boing_candy_2017 <- mutate_all(boing_candy_2017, .funs = tolower)

# Clean candy names


                    



# Reshape the data from wide to long format for all 3 data sets, so that for each candy bar column becomes a row. 
# Name the column candy  and values into rating 

candy_2015_pivot <-

boing_candy_2015 %>%
pivot_longer(butterfinger:york_peppermint_patties, names_to = "candy", values_to = "rating")

candy_2016_pivot <-
  
  boing_candy_2016 %>%
  pivot_longer(x100_grand_bar:york_peppermint_patties, names_to = "candy", values_to = "rating")

candy_2017_pivot <-
  
  boing_candy_2017 %>%
  pivot_longer(q6_100_grand_bar:q6_york_peppermint_patties, names_to = "candy", values_to = "rating")



# Removing columns 

# We have some redundant columns. some of these variables which don't contain any useful data. 

# We can check whether the column contains only one value by using the `unique` function. 


candy_2015_pivot <-
  candy_2015_pivot %>%
  select(-timestamp)

# All these columns have no useful information so we can remove them. 

candy_2015_pivot <-
  candy_2015_pivot %>%
  select(-c(3,4,5))


candy_2016_pivot <-
  candy_2016_pivot %>%
  select(-timestamp)


candy_2016_pivot <-
  candy_2016_pivot %>%
  select(-c(5:22))



candy_2017_pivot <-
  candy_2017_pivot %>%
  select(-internal_id)


candy_2017_pivot <-
  candy_2017_pivot %>%
  select(-c(5:16))



# Renaming some columns in data set to match columns 

candy_2015_pivot <-
  candy_2015_pivot %>%
  rename(age = how_old_are_you, going_out = are_you_going_actually_going_trick_or_treating_yourself)


candy_2016_pivot <-
  candy_2016_pivot %>%
  rename(going_out = are_you_going_actually_going_trick_or_treating_yourself)


candy_2017_pivot <-
  candy_2017_pivot %>%
  rename(going_out = q1_going_out, gender = q2_gender, age = q3_age, country = q4_country)

  

# Make new variables 

# Add new columns to identify the in which year data is collected 

candy_2015_data <-
  candy_2015_pivot%>%
  add_column(year = 2015)

candy_2016_data <-
  candy_2016_pivot %>%
  add_column(year = 2016)

candy_2017_data <-
  candy_2017_pivot %>%
  add_column(year = 2017)


# Clean candy names in candy 2017 data


test1 <-
candy_2017_data %>%
str_replace(candy_2015_data$candy, "\\q6")



# Now we needs count missing values


# # counting missing values

candy_2015_data %>%
  summarise(count = sum(is.na(rating)))

candy_2016_data %>%
  summarise(count = sum(is.na(rating)))

candy_2017_data %>%
  summarise(count = sum(is.na(rating)))


# 1.5

# There are so many missing values so we need deciede whether to keep them of drop them


# There are lots of missing values. I would drop the values because otherwise it will not give any usefull result.


candy_2015_na <-

  candy_2015_data %>%
  drop_na(rating)  


candy_2016_na <-
  
  candy_2016_data %>%
  drop_na() 

candy_2017_na <-
  
  candy_2017_data %>%
  drop_na() 


# Combine data from all 3 data sets

candy_halloween_data <-
bind_rows(candy_2015_data, candy_2016_data, candy_2017_data)

























    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  



