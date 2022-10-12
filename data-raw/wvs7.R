## code to prepare `wvs7s` dataset goes here

wvs7 <- readRDS("D:/MEGAsync/Nutstore/Data/WVS1981-2020/WVS_Cross-National_Wave_7_R_v20200720.rds")

library(tidyverse)
library(countrycode)

df_wvs7 <- wvs7 %>%
  group_by(B_COUNTRY) %>%
  sample_frac(size = .02) %>%
  ungroup


df_wvs7s <- df_wvs7 %>%
  mutate(
    country = countrycode(B_COUNTRY,
                          origin = "iso3n",
                          destination = "country.name"),
    female = Q260 == 2,
    age = Q262,
    education = Q275,
    religious = factor(Q173, labels = c("Religious", "Non-religious", "Atheist")),
    marital = factor(
      Q273,
      labels = c(
        "Married",
        "Cohabitant",
        "Divoiced",
        "Separated",
        "Widowed",
        "Single"
      )
    ),
    incomeLevel = Q288,
    equalIncentive = Q106,
    equalFreedom = Q149,
    corruption_state = ordered(Q113, labels = c("None", "Few", "Most", "All")),
    corruption_local = ordered(Q115, labels = c("None", "Few", "Most", "All")),
    corruption_civil = ordered(Q116, labels = c("None", "Few", "Most", "All")),
    trust_family = 5 - Q58,
    trust_neighbor = 5 - Q59,
    trust_stranger = 5 - Q61,
    trust_foreigner = 5 - Q63,
    confidence_armedForce = 5 - Q65,
    confidence_policy = 5 - Q69,
    confidence_court = 5 - Q70,
    confidence_gov = 5 - Q71,
    confidence_parliament = 5 - Q73,
    confidence_civil = 5 - Q74,
    confidence_parties = 5 - Q72,
    confidence_tv = 5 - Q67
  ) %>%
  select(
    country,
    female,
    age,
    education,
    religious,
    marital,
    incomeLevel,
    equalIncentive,
    equalFreedom,
    corruption_state,
    corruption_local,
    corruption_civil,
    trust_family,
    trust_neighbor,
    trust_stranger,
    trust_foreigner,
    confidence_armedForce,
    confidence_policy,
    confidence_court,
    confidence_gov,
    confidence_parliament,
    confidence_civil,
    confidence_parties,
    confidence_tv
  ) %>%
  filter(!(country %in% c("China", "Hong Kong SAR China", "Taiwan")))


save(
  df_wvs7,
  file = here::here("data", "wvs7.rda")
)

load("data-raw/wvs7.rda")
usethis::use_data(wvs7, overwrite = TRUE)

