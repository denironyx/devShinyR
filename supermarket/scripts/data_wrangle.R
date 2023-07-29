# METADATA ======================
# Description: Wrangles supermarket data to prepare for dashboard
# Created: 29-07-2023
# Last updated: 

# SUMMARY: create

library(tidyverse)
library(readxl)

# load supermarket sales data 
df_supermarket_raw <- read_csv('data/supermarket_sales - Sheet1.csv')


# wrangle supermarket sales data ------------------------------------------------------------

# data transformation and approximately
df_supermarket_raw %>%
  select_all(tolower) %>% 
  select_all(~str_replace(., " ", "_")) %>% 
  mutate(invoice_id = invoice_id %>% 
           str_replace(.,"-","") %>% 
           str_replace(., "-", "") %>% 
           as.integer())
  mutate(invoice_id = str_replace(str_replace(invoice_id, "-",""), "-", ""))
         