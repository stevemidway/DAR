### Supplementary code for big data in R

### Marine Science Data Analysis in R; OCS 7313

### Midway, 2024



######################
# 1. Check your memory
######################

memory.limit()
# This is only for Windows machines


############################
# 2. Check your object sizes
############################

# create object
n100 <- rnorm(100) 

# print object size
object.size(n100)

# remove an object from memory
rm(n100)

# Clear your entire memory
rm(list = ls())


##########################
# 3. How do objects scale?
##########################

# Create objects
set.seed(4)
n10 <- rnorm(10)
n100 <- rnorm(100)
n1000 <- rnorm(1000)
n10000 <- rnorm(10000)
n100000 <- rnorm(100000)
n1000000 <- rnorm(1000000)
n10000000 <- rnorm(10000000)

# Report object size
object.size(n10)
object.size(n100)
object.size(n1000)
object.size(n10000)
object.size(n100000)
object.size(n1000000)
object.size(n10000000)

# I should be looping all this!

size <- c(168,840,8040,80040,800040,8000040,80000040)
n <- c(10,100,1000,10000,100000,1000000,10000000)

plot(size ~ n, pch=16, xlab= "Sample size", ylab = "Object Size", type="b")
abline(0,1, lwd=3, col=2) # slope of 1

plot(size ~ n, pch=16, ylim = c(0,10000), xlim = c(0,10000), type="b",
     xlab= "Sample size", ylab = "Object Size")
abline(0,1, lwd=3, col=2) # slope of 1


############################
# 4. Load only what you need
############################

# data.table package for loading large datasets
install.packages("data.table")
library(data.table) # Very good package for large datasets!

df <- fread('Data_for_phreeqc.csv')
dim(df)
head(df)
object.size(df) # 44 Mb

df.col1 <- fread('Data_for_phreeqc.csv',select = c(1))
head(df.col1)
object.size(df.col1) # 2 Mb

# How much savings?
(as.numeric(object.size(df.col1)) / as.numeric(object.size(df))) * 100


#######################
# 5. Subset/sample data
#######################

# Subset
# See Introductory code for subsetting

# Sample (random)
n10000.samp <- sample(n10000, size = 100, replace = F)
length(n10000.samp)


#####################################
# 6. Time and announce your functions
#####################################

## Example 1: Reading data
# Set timer
start.time = Sys.time()  
# Do your thing
df <- read.csv("Data_for_phreeqc.csv",header = T)
# End timer
end.time = Sys.time()
# Print time
elapsed.time = round(difftime(end.time, start.time, units='mins'), dig = 2)
cat('Function computed in ', elapsed.time, ' minutes\n\n', sep='') 

# Set timer
start.time = Sys.time()  
# Do your thing
df <- fread('Data_for_phreeqc.csv')
# End timer
end.time = Sys.time()
# Print time
elapsed.time = round(difftime(end.time, start.time, units='mins'), dig = 2)
cat('Function computed in ', elapsed.time, ' minutes\n\n', sep='')
system("say All done, students!")

## Example 2: Simulating data
# Set timer
start.time = Sys.time()  
# Do your thing
n100000000 <- rnorm(100000000)
# End timer
end.time = Sys.time()
# Print time
elapsed.time = round(difftime(end.time, start.time, units='mins'), dig = 2)
cat('Function computed in ', elapsed.time, ' minutes\n\n', sep='') 

# Set timer
start.time = Sys.time()  
# Do your thing
n100000000 <- sample(n1000, size = 100000000, replace = T)
# End timer
end.time = Sys.time()
# Print time
elapsed.time = round(difftime(end.time, start.time, units='mins'), dig = 2)
cat('Function computed in ', elapsed.time, ' minutes\n\n', sep='') 

# beepr library
install.packages("beepr")
library(beepr)
df <- read.csv("Data_for_phreeqc.csv",header = T)
beep(sound = "fanfare")
beep(sound = "sword")
beep(sound = "mario")
beep(sound = "complete")

# Just use your computer (no package)
system("say Your data is loaded, your model is fit, there is no significance, you cannot publish this! Cry me a river, then build a bridge and get over it!")


#############################
# 7. Parallel/Other Computing
#############################
install.packages("parallel")
library(parallel)

# Count your number of cores
detectCores()

# Set up the number of cores
no_cores <- detectCores() - 2

# Download other packages to spilt processing to no_cores

# Amazon web services
# https://aws.amazon.com/hpc/

# LSU HPC Center
# http://www.hpc.lsu.edu/

