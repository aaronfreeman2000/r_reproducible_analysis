install.packages("tidyverse")
library("tidyverse")

gapminder %>% filter(country=="Australia") %>% head(n=12)

gapminder %>%
  dplyr::filter(continent=="Oceania" & year==1997) %>%
  head()