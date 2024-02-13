install.packages("tidyverse")
library("tidyverse")

gapminder %>% filter(country=="Australia") %>% head(n=12)


##Filters data by criteria

gapminder %>%
  dplyr::filter(continent=="Oceania" & year==1997) %>%
  head()

##Same filter as above but in two separate lines of code

gapminder %>%
  filter(continent=="Oceania") %>%
  filter(year==1997) %>%
  head()

##Using "Or" condition to specify filter

gapminder %>%
  filter(continent=="Oceania" | continent =="Americas") %>%
  filter(year==1997) %>%
  head()

##Next example selects observations/rows from a list of countries and also restricts year to 1997

gapminder %>%
  filter(country %in% c("Australia", "New Zealand", "Argentina") & year ==1997) %>%
  head()

##Next example selects observations by omitting one continent. The code that causes "omit" is the "!=" syntax

gapminder %>%
  filter(continent!="Oceania" & year==1997) %>%
  head()

##Saving as a new data frame

gap97 <- gapminder %>%
  filter(continent!="Oceania" & year==1997)

glimpse(gap97)

##Make a dataset on the ten countries in 1997 with highest gdp.

gapminder %>% filter(year==1997) %>%
  top_n(n=10, wt=gdpPercap) %>%
  head(n=10)

##Subset using select

# the next command selects three variables and renames two of them:

gapminder %>%
  select(country, Year=year, LifeExp=lifeExp) %>%
  head()

# to change the order of display, puts year first in the list of variables

gapminder %>%
  select(year,everything()) %>%
  head()

##Order using arrange

# This command will show the countries with highest life expectancy because
# the data are arranged in descending order of life expectancy 

gapminder %>%
  filter(year==1997) %>%
  select(country, continent, lifeExp) %>%
  arrange(desc(lifeExp)) %>%
  head()

# This command uses default ascending order with respect to life expectancy

gapminder %>%
  filter(year==1997) %>%
  select (country, continent, lifeExp) %>%
  arrange(lifeExp) %>%
  head()

## the top_n function will select the n rows with the largest values of a variable  
gapminder %>%
  filter(year==1997) %>%
  select(country, continent, lifeExp) %>%
  top_n(n=6,wt=lifeExp) %>%
  kable()

# the results can the be order by the life expectancy
gapminder %>%
  filter(year==1997) %>%
  select(country, continent, lifeExp) %>%
  top_n(n=6,wt=lifeExp) %>%
  arrange(desc(lifeExp)) %>%
  kable()

# reorder countries with largest life expectancy 
# according to another variable like population

gapminder %>%
  filter(year==1997) %>%
  select(country, continent, lifeExp, pop) %>%
  top_n(n=6, wt=lifeExp) %>%
  arrange(desc(pop)) %>%
  kable()

## Another usefule verb is group_by. Suppose we wanted to view two countries
## with the highest life expectancy in 1997, in each continent

gapminder %>%
  filter(year==1997) %>%
  select(country, continent, lifeExp, pop) %>%
  group_by(continent) %>%
  top_n(n=2,wt=lifeExp) %>%
  arrange(continent) %>%
  kable()

## Create a new variable based on an existing variable. Use mutate

gapminder %>% 
  mutate(logpopulation = log(pop)) %>%
  glimpse()

# If I want to rename logpopulation to logPop rerun mutate or use rename function
# In addition we create a new version of the gampinder dataset that contains the
# new new variable - called gapVers1.

gapVers1 <- gapminder %>%
  mutate(logpopulation = log(pop)) %>%
  rename(logPop=logpopulation)
  glimpse(gapVers1)
  
## if_else function has form (logical condition, value if TRUE, value if FALSE)

gapminder %>%
  mutate(region = if_else(country=="Oceania", "Oceania", "NotOceania")) %>%
  mutate(regionf = as_factor(region)) %T>%
  glimpse() %>%
  head()

## Simple Counting Using tally() and count()

gapminder %>% filter(year==1997) %>%
  filter(continent=="Americas") %>%
  tally()

gapminder %>% filter(year==1997) %>%
  filter(continent=="Americas") %>%
  count()

# Now we group by continent

gapminder %>% filter(year==1997) %>%
  group_by(continent) %>%
  filter(continent=="Americas") %>%
  tally()

#

gapminder %>% filter(year==1997) %>%
  group_by(continent) %>%
  tally()

## Missing values. If a variable is not complete and contains empty places
## These are denoted as NA. First create a dataset with missing values

x <- c(1,2,NA,4)
y <- c(11,12,13,NA)
z <- c(7,8,9,10)
tempdf <- data.frame(x,y,z)
tempdf

# count missing values for variable x

tempdf %>%
  summarise(count = sum(is.na(x)))

# subset of rows with complete data for specified columns
tempdf %>%
  select(y,z) %>%
  drop_na() %>%
  head()

# drop rows with missing values in all variables
tempdf %>%
  drop_na() %>%
  head()

# Use base is.na function
tempdf %>%
  filter(!is.na(x), # remove obs with missing x
         !is.na(y), #remove obs with missing y
         !is.na(z)) # remove obs with missing z

#Some code will execute a filter that will permit only rows with entire
# data in x to pass through

tempdf %>%
  filter(x %>% is.na() %>% not()) %>%
  head()
