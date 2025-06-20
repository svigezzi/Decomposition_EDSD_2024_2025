# Setup -------------------------------------------------------------------

library(here)
wd <- here()
setwd(wd)

load("Day 4/Exercise 3/AburtoBeltranSanchez.RData")

library(tidyverse)
library(DemoDecomp)

source("Day 4/Exercise 3/Functions_D4.R")

# Extract the needed information ------------------------------------------

# first we need the vectors of mortality rates
mx1 <- data %>% 
  filter(year==2005, age>15) %>%
  pull(mx)
mx2 <- data %>% 
  filter(year==2015, age>15) %>% 
  pull(mx)

horiuchi

# Linear integral method --------------------------------------------------

# Let's have a look at the functions
edagger.frommx

# there are also other functions
sd.frommx
rG.frommx

#Now we can perfom the decomposition
results <- horiuchi(func = edagger.frommx, pars1 = mx1, pars2 = mx2, N = 50, age=16:109)
# NB: if you use another function, remember to define the additional arguments

# Have a look at the results
results

# Check the results
#original
(original <- edagger.frommx(mx2, age=16:109) - edagger.frommx(mx1, age=16:109))
#with decomp
(with_decomp <- sum(results))

#error
with_decomp - original

#now graph results
age <- data %>% 
  filter(year==2005, age>15) %>% 
  pull(age)

ggplot()+
  ggtitle(bquote(~'Change in '~ e[15]^"\u2020" ~'2005-2015' )) +
  geom_bar(aes(x = age, y= results), stat = "identity", position = "stack", width=1)


# Stepwise replacement method ---------------------------------------------

results_step <- stepwise_replacement(edagger.frommx,pars1 = mx1, pars2 = mx2, age=16:109)

# Check the results
#original
(original <- edagger.frommx(mx2, age=16:109) - edagger.frommx(mx1, age=16:109))
#with decomp
(with_decomp_step <- sum(results_step))
#error
with_decomp_step - original

#now graph results

ggplot()+
  ggtitle(bquote(~'Change in '~ e[15]^"\u2020" ~'2005-2015' ))+
  geom_bar(aes(x = age, y= results_step), stat = "identity", position = "stack")

# Let's compare with linear integral method
results - results_step


