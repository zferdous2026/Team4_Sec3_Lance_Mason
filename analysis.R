library(readr)
library(ggplot2)
library(dplyr)
SKIN <- read_csv("ADSKPT1_JACI2018.csv")
FAMHIST <- read_csv("ADFHX1_JACI2018.csv")

SKINXFAM <- left_join(SKIN, FAMHIST, by = join_by(ParticipantId)) %>% select(-("RAWWHL":"ParticipantVisit/Visit.y")) %>% select(-("STUDYID.y":"ASTREAT.y")) %>%
  select(-("DYCRYN":"DOGYN")) %>% select(-("COWYN":"MEATAGE")) %>% select(-("MOMRNCN":"DADRNCN")) %>% select(-("MATEDUC":"MATEDSP")) %>% select(-("BFAGEPR":"CURRENT")) %>%
  select(-("COMPSTC.x":"DISCSRS.x")) %>% select(-("GSTNAGE":"BCMPLYN")) %>% select(-("STUDYID.x":"TRTC.x")) %>% select(-("INFCDT.x":"SAMP.x")) %>% select(-"SEXC.x",-"FLUPTM.x",-"VISITNUM",-"ITT.x") %>%
  select(-"SEQNO", -("MOMFDLN":"SEASONB")) %>% filter(COMPST.x != 0) %>% 
  mutate(AGEYRS = (((as.numeric(difftime(FUDT.x, DAY0DT.x, units = "weeks")))/52)+ AGE.x/12)) %>% 
  mutate(
    allergy_status = factor(
      ifelse(PNTWHL > 0, "Allergic", "Non-Allergic"),
      levels = c("Non-Allergic", "Allergic")
    ),
    BIRTH = factor(BRTHTYP)
  ) %>% select(-"BRTHTYP")

View(SKINXFAM)


#Breastfeeding VS Peanut, DONE (datwise)
SKINXFAM %>% 
  filter(PNTWHL != 0) %>%
  ggplot(aes(x = BFAGEST, y = PNTWHL)) +
  geom_jitter(width = 0.5, height = 0.5, alpha = 0.5, color = "steelblue") +
  scale_size_area(max_size = 6) +
  geom_smooth(method = "lm", se = TRUE, color = "darkred", fill = "lightpink") +
  labs(
    title = "Peanut Wheal Size (mm) VS. Age of Cessation of Breastfeeding (months)",
    x = "Age of Cessation of Breastfeeding (months)",
    y = "Peanut Wheal Size (mm)",
    size = "Count"
  ) +
  theme_minimal()

#Foods VS Peanut, DONE
SKINXFAM %>% 
  filter(PNTWHL != 0) %>%
  group_by(NFOODS) %>%
  mutate(label = paste0(NFOODS, "\n(n-", n(), ")")) %>%
  ggplot(aes(x = factor(NFOODS), y = PNTWHL)) +
  geom_boxplot(fill = "lightblue", color = "steelblue4", alpha = 0.7, outlier.shape = NA) +
  geom_jitter(width = 0.25, height = 0.15, size = 1.5, alpha = 0.5, color = "darkblue") +
  labs(
    title = "Peanut Wheal Size (mm) VS. Number of Foods in Diet at Baseline",
    x = "Number of Foods in Diet",
    y = "Peanut Wheal Size (mm)",
  ) +
  theme_minimal()

#Cigarettes VS Peanut, also sort of meh
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

#Earliest Solids VS Peanut
SKINXFAM %>%
  filter(PNTWHL != 0) %>%
  group_by(MINAGE) %>%
  mutate(label = paste0(MINAGE, "\n(n-", n(), ")")) %>%
  ggplot(aes(x = factor(MINAGE), y = PNTWHL)) +
  geom_boxplot(fill = "lightblue", color = "steelblue4", alpha = 0.7, outlier.shape = NA) +
  geom_jitter(width = 0.25, height = 0.15, size = 1.5, alpha = 0.5, color = "darkblue") +
  labs(
    title = "Peanut Wheal Size (mm) vs. Minimum Age Solids Introduced (months)",
    x = "Minimum Age Solids Introduced (months)",
    y = "Peanut Wheal Size (mm)",
  ) +
  theme_minimal()

#Birth Type vs Allergic Percent
SKINXFAM %>%
  ggplot(aes(x = BIRTH, fill = allergy_status)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    x = "Type of Birth",
    y = "Percent of Participants",
    fill = "Peanut Allergy Status",
    title = "Peanut Allergy by Type of Birth"
  ) + theme_minimal()
