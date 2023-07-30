# METADATA ======================
# Description: Wrangles supermarket data to prepare for dashboard
# Created: 29-07-2023
# Last updated: 

# SUMMARY: create

library(tidyverse)
library(readxl)
library(lubridate)
library(sf)
library(tmaptools)

# load supermarket sales data 
df_supermarket_raw <- read_csv('data/supermarket_sales - Sheet1.csv')

# wrangle supermarket sales data ------------------------------------------------------------

# data transformation and approximately
df_supermarket <- df_supermarket_raw %>%
  select_all(tolower) %>% 
  select_all(~str_replace(., " ", "_")) %>% 
  select_all(~str_replace(., " ", "_")) %>% 
  mutate(invoice_id = invoice_id %>% 
           str_replace(.,"-","") %>% 
           str_replace(., "-", "") %>% 
           as.integer(),
         branch = as.factor(city), 
         gender = as.factor(gender),
         customer_type = as.factor(customer_type),
         payment = as.factor(payment),
         date = mdy(date))

df_supermarket %>% head() %>% View()

# To do: 
# Drop gross_margin_percentage
# Add a location column to the data

# add a location region

nominatim_loc_geo <- geocode_OSM(df_supermarket$city, details = FALSE, as.data.frame = TRUE)
         