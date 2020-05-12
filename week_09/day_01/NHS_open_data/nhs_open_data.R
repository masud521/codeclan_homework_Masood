

library(tidyverse)
library(dplyr)
library(stringr)
library(janitor)

# load required data into R

geography_codes <- read_csv("geography_codes_and_labels_hb2014_01042019.csv")

opendata_nhshb <- read_csv("opendata_inc9418_hb.csv")

# Variable names 

names(opendata_nhshb)

# Left_join here beacsue we need actual data from opendata

opendata_nhs_hb <-
  opendata_nhshb %>%
  left_join(geography_codes, by = "HB")


# clean names of the column

opendata_nhs_hb <- 
  opendata_nhshb %>%
  clean_names()


# Only NHS Borders's incidence of cancer data required so I will filter this information from whole data

opendata_nhs_hb <-
  opendata_nhs_hb %>%
  filter(hb == "S08000016")


# Write  data to csv


write_csv(opendata_nhs_hb, 'opendata_scottishborders.csv')














