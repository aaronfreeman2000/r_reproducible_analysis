## Create the fake cat data

cats <- data.frame(coat = c("calico", "black", "tabby"),
                   weight = c(2.1, 5.0, 3.2),
                   likes_string = c(1, 0, 1))

## Write .csv file for it

write.csv(x = cats, file = "Data/feline-data.csv", row.names = FALSE)

## Load it into R

cats <- read.csv(file = "Data/feline-data.csv")
cats

## Check data types

str(cats)

## Explore dataset

cats$weight
cats$coat

## Say we discovered the scale was two Kg light:

cats$weight + 2

## other operations

paste("my cat is", cats$coat)
