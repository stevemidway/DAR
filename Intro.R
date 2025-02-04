# Data in R ----

## Loading data from external source (e.g., csv) ----
# Check your working directory
getwd()

# Set your working directory (optional, if needed)
# setwd("path/to/your/working/directory")
# or quit R and open from folder where data is

# Load the CSV file
mydata <- read.csv("path/to/your/file.csv")

# Display the first few rows of the data
head(mydata)

# View a summary of the dataset
summary(mydata)

# Try it Yourself


## Loading data from internal source (e.g., package) ----

# Load the dataset
data("iris")

# Display the first few rows of the dataset
head(iris)

# View a summary of the dataset
summary(iris)

# Check the structure of the dataset
str(iris)

# Try it Yourself
# run 'data()' to see available datasets


## Create data within / using R ----
# Create a data frame with three columns: Name, Age, and Score
my_data <- data.frame(
  Name = c("Alice", "Bob", "Charlie"),
  Age = c(25, 30, 35),
  Score = c(90, 85, 88)
)

# View the created dataset
print(my_data)

# Add a new column to the dataset
my_data$Passed <- my_data$Score > 80

# Display the updated dataset
print(my_data)

# Try it Yourself

## Final comments about data input ----

# 1. Don’t need to worry about missing data, will be NA (if blank)
# 2. Watch for commas in data (e.g., in comments)
# 3, Best to keep all files in one directory
# 4. Use simplest, non-propritary file types
# 5. Use only basic (ASCII) characters in data


## Checking your data ----

dim(iris) # dimensions of the data object
head(iris) # first 5 rows of actual data
str(iris) # structure of the data
summary(iris) # summary of the data


## Saving your data or work ----

# 1. Save scripts often (like Word document) 
# 2. Save workspace? Maybe, maybe not
# 3. Save data / output? Probably

write.table(mydata,
            file = "myresults.csv",
            sep = ",")


## More on creating data ----

### rep() ----
# Repeat a single value
rep(5, times = 4) 

# Repeat a vector
rep(c(1, 2, 3), times = 2)

# Each element repeated a specific number of times
rep(c(1, 2, 3), each = 2) 


### seq() ----
# Create a sequence from 1 to 10
seq(1, 10)

# Sequence with a specific step size
seq(1, 10, by = 2) 

# Sequence of a specific length
seq(1, 10, length.out = 5)


### c() ----
# Combine numeric values
c(1, 2, 3, 4) 

# Combine different data types (will coerce to the same type)
c(1, "apple", TRUE)  

# Combine vectors
c(c(1, 2), c(3, 4)) 


### replicate() ----
# Generate random numbers multiple times
replicate(5, runif(1))


## Data types ----

### Numeric ----
# Description: Represents real numbers, including decimals
# Default for numbers in R

x <- 3.14        # Assign a numeric value
is.numeric(x)    # Check if it's numeric (TRUE)
class(x)         

### Integer ----
# Description: Represents whole numbers
# Can coerce or use "L"

x <- 5           # Assign an integer value
is.integer(x)    # Check if it's an integer (TRUE)
x <- 5L          # Assign an integer value
is.integer(x)    # Check if it's an integer (TRUE)
class(x)         

# Whole numbers can still be numeric and not integer!

### Character ----
# Description: Represents text or strings
# Strings are enclosed in quotes (" " or ' ')

x <- "Snow!"      # Assign a string
is.character(x)   # Check if it's a character (TRUE)
class(x)          


### Factor ----
# Description: Represents categorical data
# Stores categories as levels (is memory-efficient)
# Used in statistical modeling

x <- factor(c("Low", "Medium", "High", "Medium", "Low"))
print(x)             

# Check levels
levels(x)         

# Summary of factor
summary(x)

# But what if you want the order Low, Medium, High?
x <- factor(c("Low", "Medium", "High"), 
            levels = c("Low", "Medium", "High"), 
            ordered = TRUE)
print(x)


## Object types ----

### Vector ----
# A one-dimensional collection of elements of the same type (e.g., numeric).
vec <- c(1, 2, 3, 4, 5)

# Access elements
vec[4]        

# Check the type
is.vector(vec)  
class(vec)      


### Matrix ----
# A two-dimensional structure where all elements must have the same type.
mat <- matrix(1:9, nrow = 3, ncol = 3)

# View the matrix
print(mat)

# Access an element (row 2, column 3)
mat[2, 3]       

# Row and column sums
rowSums(mat)    
colSums(mat)    


### Array ----
# A multi-dimensional structure where all elements have the same type

arr <- array(1:12, dim = c(3, 2, 2))

# View the array
print(arr)

# Access an element (row 2, column 1, slice 2)
arr[2, 1, 2]     

# View a specific slice (slice 1)
arr[, , 1]

### List ----
# Collection of objects of different types (e.g., vectors, data frames, functions)

my_list <- list(
  Name = "Kohinur",
  Age = 25,
  Scores = c(90, 85, 88),
  Info = data.frame(Hobby = c("Reading", "Cycling"))
)

# Access elements by name
my_list$Name     

# Access elements by position
my_list[[2]]      

# View the structure of the list
str(my_list)


### Data Frame ----
# A two-dimensional structure where columns can have different types (e.g., numeric, character)

df <- data.frame(
  Name = c("Joe", " Susan", "John"),
  Age = c(25, 30, 35),
  Score = c(90, 85, 88) 
  )

# View the data frame
print(df)

# Access a column
df$Name         

# Summary of the data frame
summary(df)


# Manipulating Data ----

library(tidyverse)

## filter() ----
# Subsets rows based on condition(s)

# Filter rows where mpg is greater than 20
filter(mtcars, mpg > 20)

# Same as
mtcars %>% filter(mpg > 20)
# But does not save output as object!

# Q: Filter cars that ONLY have 4 cylinders (cyl)


## select() ----
# Selects specific columns from a data frame

# Select columns mpg, cyl, and hp
mtcars %>%
  select(mpg, cyl, hp)

## mutate() ----
# Creates new columns or modifies existing ones

# Create new column for weight in pounds
mtcars %>%
  mutate(weight_lb = wt * 1000)

# Q: Mutate mpg as a percent of the most efficient car


## summarize() ----
# Summarizes data (mean, sum, etc.)

# Summarize cars by mean mpg
mtcars %>%
  summarize(mean_mpg = mean(mpg))


## group_by() ----
# Groups the dataset by 1+ variables for grouped operations

# Group by the number of cylinders (cyl)
mtcars %>%
  group_by(cyl)

# ...often more powerful when combined with operation
mtcars %>%
  group_by(cyl) %>% 
  summarize(mean_mpg = mean(mpg))

# Q: Summarize maximum hp by number of gears


## count() ----
# Counts the number of rows in each group.

# Count the number of cars for each cylinder group
mtcars %>%
  count(cyl)

# ...and a lot more verbs to choose from

# Q: Pipe some code:
# 1. Filter mtcars to include only 6 or more cylinders
# 2. Select only columns for mpg, cyl, and hp
# 3. Group by number of cylinders
# 4. Summarize the average hp
mtcars %>%
  filter(cyl >= 6) %>%
  select(mpg, cyl, hp) %>%
  group_by(cyl) %>%
  summarize(avg_hp = mean(hp))

# Q: In 2000, what was the 8th city in TX for home sales?


txhousing %>% 
  filter(year == 2000) %>% 
  group_by(city,year) %>% 
  summarize(ann_sales = sum(sales)) %>% 
  arrange(desc(ann_sales))

