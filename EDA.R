library(data.table)
abalone <- fread('http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data')
# Metadata: http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.names

head(abalone)
# no column names

colnames(abalone) <- c("SEX","LENGTH","DIAMETER",
                       "HEIGHT","WHOLE_WT","SHUCKED_WT", 
                       "VISCERA_WT","SHELL_WT","RINGS")

head(abalone)
dim(abalone)

library(dplyr)

# Multivariate (correlations)
ab.cor <- select(abalone, 2:9)
cor(ab.cor)
round(cor(ab.cor),2)
pairs(ab.cor, pch = 16, cex = 0.5)

library(corrgram)
corrgram(ab.cor, order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)

# Some dplyr examples

##### select function #####
select(abalone, WHOLE_WT:SHELL_WT)
select(abalone, 5:8)
select(abalone, -(5:8))
# Note that we have not created objects from these data frames!

##### filter function #####
abalone.male <- filter(abalone, SEX == "M")
filter(abalone, RINGS >= 10)
filter(abalone, SEX == "F" & RINGS < 7)

##### arrange function #####
arrange(abalone, HEIGHT)
arrange(abalone, desc(HEIGHT))
arrange(abalone, SEX, RINGS)

##### rename function #####
rename(abalone, DIAM = DIAMETER, WHOLE_WEIGHT_G = WHOLE_WT)

##### mutate function #####
mutate(abalone, SHUCKED_WT.detrend = SHUCKED_WT - mean(SHUCKED_WT))
abalone2 <- mutate(abalone, COND = WHOLE_WT/LENGTH)
mutate(abalone2, COND.detrend = COND - mean(COND))
transmute(abalone2, COND.detrent = COND - mean(COND)) # drops existing variables

##### group_by #####
abalone3 <- group_by(abalone, RINGS) # Groupings are carried forward in other dplyr commands
summarize(abalone3, WHOLE_WT = mean(WHOLE_WT), DIAMETER = mean(DIAMETER))
#ungroup(abalone3)

##### pipeline operator %>% #####
# Conventional way: third(second(first(x)))
# %>% allows left to right operations
## first(x) %>% second %>% third

mutate(abalone, COND = WHOLE_WT/LENGTH) %>%
  group_by(RINGS) %>%
  summarize(LENGTH.mean = mean(LENGTH),
            COND.max = max(COND))









