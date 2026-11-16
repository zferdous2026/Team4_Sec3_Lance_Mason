library(readr)
library(ggplot2)
library(dplyr)
SKIN <- read_csv("ADSKPT1_JACI2018.csv")
FAMHIST <- read_csv("ADFHX1_JACI2018.csv")

SKINXFAM <- left_join(SKIN, FAMHIST, by = join_by(ParticipantId)) %>% select(-("RAWWHL":"ParticipantVisit/Visit.y")) %>% select(-("STUDYID.y":"ASTREAT.y")) %>%
  select(-("DYCRYN":"DOGYN")) %>% select(-("COWYN":"MEATAGE")) %>% select(-("MOMRNCN":"DADRNCN")) %>% select(-("MATEDUC":"MATEDSP")) %>% select(-("BFAGEPR":"CURRENT")) %>%
  select(-("COMPSTC.x":"DISCSRS.x")) %>% select(-("GSTNAGE":"BCMPLYN")) %>% select(-("STUDYID.x":"TRTC.x")) %>% select(-("INFCDT.x":"SAMP.x")) %>% select(-"SEXC.x",-"FLUPTM.x",-"VISITNUM",-"ITT.x") %>%
  select(-"SEQNO", -("MOMFDLN":"SEASONB")) %>% filter(COMPST.x != 0) %>% 
  mutate(AGEYRS = (((as.numeric(difftime(FUDT.x, DAY0DT.x, units = "weeks")))/52)+ AGE.x/12))

View(SKINXFAM)


#This chart below kind of sucks
SKINXFAM %>% 
  filter(PNTWHL != 0) %>%
  ggplot(aes(x = BFAGEST, y = PNTWHL)) +
  geom_count(color= "steelblue", alpha = 0.7) +
  scale_size_area(max_size = 6) +
  geom_smooth(method = "lm", se = TRUE, color = "darkred", fill = "lightpink") +
  labs(
    title = "Peanut Wheal Size (mm) VS. Age of Cessation of Breastfeeding (months)",
    x = "Age of Cessation of Breastfeeding (months)",
    y = "Peanut Wheal Size (mm)",
    size = "Count"
  ) +
  theme_minimal()

#also kind of sucks
SKINXFAM %>% 
  filter(PNTWHL != 0) %>%
  ggplot(aes(x = NFOODS, y = PNTWHL)) +
  geom_count(color= "steelblue", alpha = 0.7) +
  scale_size_area(max_size = 6) +
  geom_smooth(method = "lm", se = TRUE, color = "darkred", fill = "lightpink") +
  labs(
    title = "Peanut Wheal Size (mm) VS. Number of Foods in Diet at Baseline",
    x = "Number of Foods in Diet",
    y = "Peanut Wheal Size (mm)",
    size = "Count"
  ) +
  theme_minimal()

#also sort of meh
SKINXFAM %>% 
  filter(PNTWHL != 0, CGRTNUM != 0) %>%
  ggplot(aes(x = CGRTNUM, y = PNTWHL)) +
  geom_count(color= "steelblue", alpha = 0.7) +
  scale_size_area(max_size = 6) +
  geom_smooth(method = "lm", se = TRUE, color = "darkred", fill = "lightpink") +
  labs(
    title = "Peanut Wheal Size (mm) VS. Number of Cigarettes Smoked in House Per Week",
    x = "Number of Cigarettes Smoked in House Per Week",
    y = "Peanut Wheal Size (mm)",
    size = "Count"
  ) +
  theme_minimal()
