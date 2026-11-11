library(readr)
library(ggplot2)
library(dplyr)
SKIN <- read_csv("ADSKPT1_JACI2018.csv")
FAMHIST <- read_csv("ADFHX1_JACI2018.csv")
View(SKIN)
View(FAMHIST)

SKINXFAM <- left_join(SKIN, FAMHIST, by = join_by(ParticipantId)) %>% select(-("RAWWHL":"ParticipantVisit/Visit.y")) %>% select(-("STUDYID.y":"ASTREAT.y")) %>%
  select(-("DYCRYN":"DOGYN")) %>% select(-("COWYN":"MEATAGE")) %>% select(-("MOMRNCN":"DADRNCN")) %>% select(-("MATEDUC":"MATEDSP")) %>% select(-("BFAGEPR":"CURRENT")) %>%
  select(-("COMPSTC.x":"DISCSRS.x")) %>% select(-("GSTNAGE":"BCMPLYN")) %>% select(-("STUDYID.x":"TRTC.x")) %>% select(-("INFCDT.x":"SAMP.x")) %>% select(-"SEXC.x",-"FLUPTM.x",-"VISITNUM",-"ITT.x") %>%
  select(-"SEQNO", -("MOMFDLN":"SEASONB")) %>% filter(COMPST.x != 0) %>% 
  mutate(AGEYRS = (((as.numeric(difftime(FUDT.x, DAY0DT.x, units = "weeks")))/52)+ AGE.x/12))

View(SKINXFAM)

colnames(SKINXFAM)
