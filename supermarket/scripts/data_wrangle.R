# METADATA ======================
# Description: Wrangles supermarket data to prepare for dashboard
# Created: 29-07-2023
# Last updated: 

# SUMMARY: create

library(tidyverse)
library(readxl)

# load supermarket sales data 
df_supermarket <- read_csv('data/supermarket_sales - Sheet1.csv')

df_supermarket <- read_xlsx('data/supermarket_sales - Sheet1.csv', sheet = 'supermarket_sales - Sheet1')



head(df_supermarket)
