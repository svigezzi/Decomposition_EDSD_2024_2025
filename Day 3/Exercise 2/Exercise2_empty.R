# Setup -------------------------------------------------------------------
library(here)
wd <- here()
setwd(wd)

load("Day 3/Exercise 2/Arriaga_COVID_USA.RData")

library(tidyverse)
library(data.table)

# Compare life expectancies  ----------------------------------------------

data %>% filter(year==2020,age==0,sex==0) %>% pull(ex) %>% unique() - 
  data %>% filter(year==2019,age==0,sex==0) %>% pull(ex) %>% unique()

# Decomposition -----------------------------------------------------------

# Age

data_nocause <- data %>% 
  select(!c(cause,prop)) %>% 
  distinct
  
  