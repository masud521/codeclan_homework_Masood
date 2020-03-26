
#  Task 4 - Halloween Candy Data

# The data is in files boing-boing-candy-2015.xlxs, 
# boing-boing-candy-2016.xlxs and boing-boing-candy-2017.xlxs

# 1.4.1 Some cleaning hints
# need to combine these three datasets together.

library(tidyverse)
library(janitor)
library(readxl)
library(here)

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


# also change text to lower case of columns and rows

boing_candy_2015 <- mutate_all(boing_candy_2015, .funs = tolower)
boing_candy_2016 <- mutate_all(boing_candy_2016, .funs = tolower)
boing_candy_2017 <- mutate_all(boing_candy_2017, .funs = tolower)




# Reshape the data from wide to long format for all 3 data sets, so that for each candy bar column becomes a row. 
# Name the column code  and values into quantity

candy_2015_pivot <-

boing_candy_2015 %>%
pivot_longer(butterfinger:york_peppermint_patties, names_to = "candy", values_to = "rating")

candy_2016_pivot <-
  
  boing_candy_2016 %>%
  pivot_longer(x100_grand_bar:york_peppermint_patties, names_to = "candy", values_to = "rating")

candy_2017_pivot <-
  
  boing_candy_2017 %>%
  pivot_longer(q6_100_grand_bar:q6_york_peppermint_patties, names_to = "candy", values_to = "rating")



# Removing useless columns 

# We have some redundant columns. some of these variables which don't contain any useful data. 

# We can check whether the column contains only one value by using the `unique` function. 

unique(candy_2015_pivot$are_you_going_actually_going_trick_or_treating_yourself)
unique(candy_2015_pivot$please_leave_any_remarks_or_comments_regarding_your_choices)

candy_2015_pivot <-
  candy_2015_pivot %>%
  select(-are_you_going_actually_going_trick_or_treating_yourself,-please_leave_any_remarks_or_comments_regarding_your_choices, -please_list_any_items_not_included_above_that_give_you_despair)

# All these columns have no useful information.  
candy_2015_pivot <-
  candy_2015_pivot %>%
  select(-c(3:28))


candy_2016_pivot <-
  candy_2016_pivot %>%
  select(-c(2,3,8:23))

candy_2016_pivot <-
  candy_2016_pivot %>%
  select(-please_list_any_items_not_included_above_that_give_you_joy)



candy_2017_pivot <-
  candy_2017_pivot %>%
  select(-c(2:16))

candy_2017_pivot <-
  candy_2017_pivot %>%
  select(-click_coordinates_x_y)


# Now we needs count missing values


# # counting missing values

candy_2015_pivot %>%
  summarise(count = sum(is.na(rating)))

candy_2016_pivot %>%
  summarise(count = sum(is.na(rating)))

candy_2016_pivot %>%
  summarise(count = sum(is.na(rating)))


# 1.5

# There are so many missing values so we need deciede whether to keep them of drop them


# There are lots of missing values. I would drop the values because otherwise it will not give any usefull result.


candy_2015_pivot_na <-
  
  candy_2015_pivot %>%
  drop_na()  

candy_2016_pivot_na <-
  
  candy_2016_pivot %>%
  drop_na() 

candy_2017_pivot_na <-
  
  candy_2017_pivot %>%
  drop_na() 







