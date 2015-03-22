---
title: "ReadMe"
author: "D. Verdes"
date: "Sunday, March 22, 2015"
output: word_document
---

# This ReadMe ("README.md") describes how the script code presented in the "run_analysis.R" works!

### The data archived files can be found at: 
### https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
### the Dataset.zip is saved in a folder called "Project"
### The unziped data are saved in a sub-folder called "UCI HAR Dataset" which subsequently contains the "train" and "test" subfolders 
### There are three libraries which are needed to be loaded on top of the standard libraries. These are:

- "dplyr" from the package with the same name "dplyr"
- "tidyr" from the package with the same name "tidyr"
- "stringr" from the package with the same name "stringr"

#### The load command is: library (name_library)

### Step 1
### Reads the "train" data sets; size: observations x variables

- XX_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
*(XX_train contains the X_train.txt data; size 7532 x 561; observationsxvariables)*

- YY_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
*(YY_train contains the Y_train.txt data; size: 7532 x 1)*

- features <- read.table("./UCI HAR Dataset/features.txt")
*(features contains the features.txt data; size: 561 x 2)*

- features_vector <- features$V2
*(the features_vector takes the second column from data frame "features"; size: 1:561)*

- features_vector <- as.character(features_vector)
*(the values of the features_vector are transformed in character type)*

- subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
*(subj_train contains the subject_train.txt data; size: 7532 x 1)*

- colnames(XX_train) <- features_vector
*(the columns names in the XX_train are replaced with the elements of the features_vector)*

- colnames(YY_train) <- "activity"
*(the column name in YY_train is replaced with "activity")*

- colnames(subj_train) <- "subject"
*(the column name in subj_train is replaced with "subject")*

### binds the train data sets

- training_set <- cbind(subj_train, YY_train, XX_train)
*(the XX_train, YY_train and subj_train are cbind() together; size: 7532 x 563)*

### Reads the "test" data sets; size: observations x variables

- XX_test <- read.table("./UCI HAR Dataset/test/X_test.txt") 
*(XX_test contains the X_test.txt data; size: 2947 x 561)*

- YY_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
*(YY_test contains the Y_test.txt data; size: 2947 x 1)*

- subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
*(subj_test contains the subject_test.txt data; size: 2947 x 1)*

- colnames(XX_test) <- features_vector

- colnames(YY_test) <- "activity"

- colnames(subj_test) <- "subject"
*(the columns names of the three data frames above are changed with the ones contained in the features_vector elements plus the "activity" and "subject")*

- testing_set <- cbind(subj_test, YY_test, XX_test)
*(the three data frames are cbind() together; size: 2947 x 563)*

- all_combined <- rbind (training_set, testing_set)
*(the data contained in "training_set" and "testing_set" are "merged with rbind()"; size: 10299 x 563)*

### Step 2
### Extracts only the measurements on the mean and standard deviation for each measurement

- all<-all_combined[,grepl("subject|activity|-mean|-std", colnames(all_combined))]
*(the data frame "all" contains only the variable "subject", "activity" and those containing "mean" and "std"; size: 10299 x 81)*

### Step 3
### Uses descriptive activity names to name the activities in the data set

- activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
*(the activity_labels data frames contains the activity_labels.txt data; size: 6 x 2)*

- all$activity <- as.factor(activity_labels$V2) [all$activity]
*(the values in the column activity of "all" data frame are replaced with the second column from actuvity_labels data frame. Their meaning is described in the code book attached.)*

### Step 4
### Appropiatly labels the data set with descriptive variables names
### The variables names are described in the code book

### 
- vector_names <- names(all)
*(makes a vector with all variables' names)*

### uses the str_replace_all() function to change the variables names

#### replace "tBody" to "time_body_"
- vector_names <- str_replace_all(vector_names, "tBody", "time_body_")

#### replace "fBody" to "frequency_body_"
- vector_names <- str_replace_all(vector_names, "fBody", "frequency_body_")

#### replace "Acc" to "acceleration_"
- vector_names <- str_replace_all(vector_names, "Acc", "acceleration_")

#### replace "Gyro" to "gyroscope"
- vector_names <- str_replace_all(vector_names, "Gyro", "gyroscope_")

#### replace "tGravity" to "time_gravity"
- vector_names <- str_replace_all(vector_names, "tGravity", "time_gravity_")

#### replace "Jerk" to "jerk_rate"
- vector_names <- str_replace_all(vector_names, "Jerk", "jerk_rate_")

#### replace "Mag" to "magnitude_"
- vector_names <- str_replace_all(vector_names, "Mag", "magnitude_")

#### replace "Freq" to "frequency"
- vector_names <- str_replace_all(vector_names, "Freq", "_frequency")

#### replace "Body" to "body_"
- vector_names <- str_replace_all(vector_names, "Body", "body_")

#### replace "(\\)" to ""
- vector_names <- str_replace_all(vector_names, "\\(\\)", "")

#### replace "-" to "_"
- vector_names <- str_replace_all(vector_names, "-", "_")

#### replace "__" to "_"
- vector_names <- str_replace_all(vector_names, "__", "_")

### replace the variable names in the data frame "all" with the elements of the
### vector "vector_names"
- names(all) <- vector_names

### Step 5
### Creates a second, independent tidy data set with the average of each variables for each activity and each subject.

- all <- tbl_df(all)
*uses the tbl_df() from dplyr library to wrap the data frame. It has few advantages over regular data frames as printing and few others. It is an option not obligatory to obtain the tidy data set*

- all_tidy <- gather(all, key_col, value_col, 3:81)
*uses "gather" from tidyr library to gather the data based in "key" and "value"*

- all_tidy <- all_tidy %>% group_by(subject, activity) %>% 
    summarise (mean = mean(value_col))
*summarizes the data by subject and activity with "Piping-%>%" commands*

- write.table (all_tidy, file = "all_tidy_data.txt", row.names = FALSE)
*writes out the data set to file*

#### The data frames "all" and "all_tidy" contains the tidy data; each variable is contained in one column and each observation is contained in a different row.

#### Note:
#### For a much longer script a ReadMe file should explain the script in less details. For example: only groups of commands may be explained in details.
#### Here, while the script is much shorter I decided to explain the commands line_by_line for clarity and learning 













