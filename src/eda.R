##################################
### Exploratory data analysis ####
##################################
# import clean data and explore it

####################
####################
# preamble    ######
####################
####################

library(tidyverse)
library(readr)
library(ggplot2)
ggplot2::theme_set(theme_classic())



####################
####################
# data import    ###
####################
####################

chs <- readr::read_csv('../data/chs_clean.csv')



####################
####################
# data viz      ###
####################
####################
fontsize <- 16


# forced moves by gender
chs %>% 
  ggplot() +
  geom_bar(aes(x = gender, weight = weight, fill = forced_move), position = "fill") +
  scale_fill_viridis_d(begin = 0.25, end = 0.75, alpha = 0.8) +
  labs(x = "Gender",
       y = "",
       fill = "Forced move?") +
  scale_y_continuous(labels = scales::percent) +
  theme(text = element_text(size = fontsize))



# forced moves within females by income
chs %>% 
  dplyr::filter(gender == "female") %>% 
  ggplot() +
  geom_boxplot(aes(x = forced_move, y = income, weight = weight)) +
  labs(x = "Forced move? (Only females)",
       y = "Income (CAD / year)") +
  scale_y_continuous(breaks = 250000*0:5,
                     labels = scales::dollar) +
  theme(text = element_text(size = fontsize))
