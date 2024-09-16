
# Create example data frame
data <- data.frame(
  x1 = c(1:4, 99999, 1, NA, 1, 1, NA),   # Column with numerical data
  x2 = c(1:5, 1, NA, 1, 1, NA),           # Another numeric column with NA values
  x3 = c(letters[1:3], "x  x", "x", "   y    y y", "x", "a", "a", NA),  # Text column
  x4 = "",                                # Empty column
  x5 = NA                                 # NA column
)

# To remove outliers using boxplot.stats for column x1:
data <- data[!data$x1 %in% boxplot.stats(data$x1)$out, ]

# Print the updated data
data



# Print example data frame
#modify column name modify
colnames(data)
colnames(data)                                `# Print column names
# [1] "x1"   "x1.1" "x1.2" "x4"   "x5"

#Let’s assume that we want to change these column names to a consecutive range with the prefix “col”. Then, we can apply the colnames, paste0, and ncol functions as shown below:

colnames(data) <- paste0("col", 1:ncol(data))    # Modify all column names
data                                             # Print updated data frame
# format missing data
#In the R programming language, missing values are usually represented by NA. For that reason, it is useful to convert all missing values to this NA format.

#In our specific example data frame, we have the problem that some missing values are represented by blank character strings.

#We can print all those blanks to the RStudio console as shown below:
data[data == ""]   # Print blank data cells
#If we want to assign NA values to those blank cells, we can use the following syntax:

data[data == ""] <- NA  # Replace blanks by NA


# NA IS A character sring
data$col2                                                 # Print column
#  [1] "1"  "2"  "3"  "4"  "5"  "1"  "NA" "1"  "1"  "NA"
# Update data

data$col2[data$col2 == "NA"] <- NA     # Replace character "NA"

data 


# Remove empty rows & columns
#The syntax below demonstrates how to use the rowSums, is.na, and ncol functions to remove only-NA rows:

data <- data[rowSums(is.na(data)) != ncol(data), ]   # Drop empty rows
data                                                # Print updated data frame
# we have converted all empty characters “” and all character “NA” to true missing values.

#we can also exclude columns that contain only NA values: 
data <- data[ , colSums(is.na(data)) != nrow(data)]       # Drop empty columns
data                                                      # Print updated data frame

# Remove row with missing value(should be done with care! Statistical bias )
# have decided to remove all rows with one or more NA values, you may use the na.omit function as shown below:


data <- na.omit(data)    # Delete rows with missing values 
data                   # Print updated data frame
# Remove Duplicates
data <- unique(data)    # Exclude duplicates
data                   # Print updated data frame

#Modify Classes Of Columns 
sapply(data, class)                 # Print classes of all columns
#        col1        col2        col3 
#   "numeric" "character" "character"


data <- type.convert(data, as.is = TRUE)
data     # Print updated data frame


sapply(data, class)      # Print classes of updated columns
#        col1        col2        col3 
#   "integer"   "integer" "character"

#Detect & Remove Outliers
data$col1[data$col1 %in% boxplot.stats(data$col1)$out] # Identify outliers in column
# [1] 99999


# outlier should be removed. Then, we can apply the R code below:

# Remove rows with outliers
data <- data[! data$col1 %in% boxplot.stats(data$col1)$out, ]  # Remove rows with outliers
data   


data                 # Print updated data frame
# Remove Spaces in Character Strings
#we can use the gsub function as demonstrated below:


data$col3 <- gsub(" ", "", data$col3) # Delete white space in character strings
data                 # Print updated data frame

# Combine categories
#merge certain categories of a categorical variable.

data$col3[data$col3 %in% c("b", "c")] <- "a"      # Merge categories
data                          # Print updated data frame






#Here are the most common ways to “clean” a dataset in R:

Method 1: Remove Rows with Missing Values

library(dplyr)

#remove rows with any missing values
df %>% na.omit()
#Method 2: Replace Missing Values with Another Value

library(dplyr)
library(tidyr)

#replace missing values in each numeric column with median value of column
df %>% mutate(across(where(is.numeric), ~replace_na(., median(., na.rm=TRUE))))
#Method 3: Remove Duplicate Rows
library(dplyr)

df %>% distinct(.keep_all=TRUE)
#create data frame
df <- data.frame(team=c('A', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'),
                 points=c(4, 4, NA, 8, 6, 12, 14, 86, 13, 8),
                 rebounds=c(9, 9, 7, 6, 8, NA, 9, 14, 12, 11),
                 assists=c(2, 2, NA, 7, 6, 6, 9, 10, NA, 14))

#view data frame
df

#Example 1: Remove Rows with Missing Values
library(dplyr)

#remove rows with missing values
new_df <- df %>% na.omit()

#view new data frame
new_df

#Example 2: Replace Missing Values with Another Value
library(dplyr)
library(tidyr)

#replace missing values in each numeric column with median value of column
new_df <-df %>% mutate(across(where(is.numeric),~replace_na(.,median(.,na.rm=TRUE)))) 

#view new data frame
new_df

#missing values in each numeric column have each been replaced with the median value of the column.
# also replace median in the formula with mean to instead replace missing values with the mean value of each column.

#Example 3: Remove Duplicate Rows
#to replace any missing values with the median value of each column:

library(dplyr)

#remove duplicate rows
new_df <- df %>% distinct(.keep_all=TRUE)

# Remove rows with any missing values
cleaned_data <- na.omit(data)

# Impute missing values with the mean for numerical columns
data$column[is.na(data$column)] <- mean(data$column, na.rm = TRUE)


# Normalize data to a range [0, 1]
data$normalized_column <- (data$column - min(data$column)) / (max(data$column) - min(data$column))

# Standardize data to have mean 0 and standard deviation 1
data$standardized_column <- scale(data$column)
# Use the caret package for one-hot encoding
library(caret)
dummy_vars <- dummyVars(~ ., data = data)
data_encoded <- predict(dummy_vars, newdata = data)
# Convert categorical variable to factor and then to numeric
data$encoded_column <- as.numeric(factor(data$categorical_column))































