##################################
###      Data generation      ####
##################################
# import, wrangle, and save data

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
# data wrangling ###
####################
####################

# full data set
chs_full <- readr::read_tsv("../data/CHS_2018_EN.tab")

# subset rows of interest
chs <- chs_full %>% 
  dplyr::select(PUMFID, PFWEIGHT, PPROV, PGEOGR, PDWLTYPE, PDCT_05, PHHTTINC, EHA_10, PRSPGNDR,
                PFTHB5YR, PPAC_05, PPAC_30, PPAC_45A, PPAC_45M) %>% 
  dplyr::rename(id = PUMFID,
                weight = PFWEIGHT,
                province = PPROV,
                region = PGEOGR,
                type = PDWLTYPE,
                tenure = PDCT_05,
                income = PHHTTINC,
                hardships = EHA_10,
                gender = PRSPGNDR,
                ft_buyer = PFTHB5YR,
                move_date = PPAC_05,
                pretenure = PPAC_30,
                forced_move = PPAC_45A,
                move_to_buy = PPAC_45M) %>% 
  dplyr::filter(province == 59) %>% # filter BC
  dplyr::select(-province) %>% # no need to keep
  # now remove all skips and no answers
  dplyr::filter(type != 99,
                tenure != 9,
                income != 99999999999,
                hardships != 9,
                gender != 9,
                ft_buyer != 9,
                move_date != 99,
                pretenure != 9,
                forced_move != 9,
                move_to_buy != 9)
