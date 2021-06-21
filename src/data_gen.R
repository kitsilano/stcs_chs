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
                PPAC_05, PPAC_30, PPAC_45A, PPAC_45M) %>% 
  dplyr::rename(id = PUMFID,
                weight = PFWEIGHT,
                province = PPROV,
                region = PGEOGR,
                type = PDWLTYPE,
                tenure = PDCT_05,
                income = PHHTTINC,
                hardships = EHA_10,
                gender = PRSPGNDR,
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
                move_date != 99,
                pretenure != 9,
                forced_move != 9,
                move_to_buy != 9) %>% 
  dplyr::mutate(
    region = case_when(
      region == 25 ~ 'Vancouver',
      region == 26 ~ 'Other CMA',
      region == 27 ~ 'Non CMA',
      TRUE ~ 'NA'
    ),
    tenure = case_when(
      tenure == 1 ~ 'owned',
      tenure == 2 ~ 'rented',
      TRUE ~ 'NA'
    ),
    hardships = case_when(
      hardships == 1 ~ 'very difficult',
      hardships == 2 ~ 'difficult',
      hardships == 3 ~ 'neither',
      hardships == 4 ~ 'easy',
      hardships == 5 ~ 'very easy',
      TRUE ~ 'NA'
    ),
    gender = case_when(
      gender == 1 ~ 'male',
      gender == 2 ~ 'female',
      TRUE  ~ 'NA'
    ),
    move_date = case_when(
      move_date == 1 ~ '<1',
      move_date == 2 ~ '1-2',
      move_date == 3 ~ '2-3',
      move_date == 4 ~ '3-4',
      move_date == 5 ~ '4-5',
      move_date == 6 ~ '5-10',
      move_date == 7 ~ '10+',
      TRUE ~ 'NA'
    ),
    pretenure = case_when(
      pretenure == 1 ~ 'own',
      pretenure == 2 ~ 'rent',
      pretenure == 3 ~ 'rent-free',
      TRUE ~ 'NA'
    ),
    forced_move = case_when(
      forced_move == 1 ~ 'yes',
      forced_move == 2 ~ 'no',
      TRUE ~ 'NA'
    ),
    move_to_buy = case_when(
      move_to_buy == 1 ~ 'yes',
      move_to_buy == 2 ~ 'no',
      TRUE ~  'NA'
    ))


####################
####################
# data saving    ###
####################
####################

readr::write_csv(chs, path = '../data/chs_clean.csv')