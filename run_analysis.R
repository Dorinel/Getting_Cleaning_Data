# the code file run_analysis.R
# load the needed libraries
library(dplyr)
library(stringr)
library (tidyr)
#
#
### Step 1
#
# Read the training data set, (measurements, activities and subjects) 
#-------------------------------------------------------------
XX_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
YY_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
features_vector <- features$V2
features_vector <- as.character(features_vector)
subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(XX_train) <- features_vector
colnames(YY_train) <- "activity"
colnames(subj_train) <- "subject"
#
# binds the train data sets
training_set <- cbind(subj_train, YY_train, XX_train)
#--------------------------------------------------------------
# Read the test data set, (measurements, activities and subjects)
# --------------------------------------------------------------
XX_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
YY_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(XX_test) <- features_vector
colnames(YY_test) <- "activity"
colnames(subj_test) <- "subject"
#
# binds the test data sets
testing_set <- cbind(subj_test, YY_test, XX_test)
#--------------------------------------------------------------
# Merges the training and testing sets to create one data set!
#
all_combined <- rbind (training_set, testing_set)
#--------------------------------------------------------------
#
### Step 2
#
# Extracts only the measurements on the mean and standard deviation for each
# measurement!
all<-all_combined[,grepl("subject|activity|-mean|-std", colnames(all_combined))]
#--------------------------------------------------------------
#
### Step 3
#
# Uses descriptive activity names to name the activities in the data set!
#
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
all$activity <- as.factor(activity_labels$V2) [all$activity]
#
#---------------------------------------------------------------
### Step 4
#
# Appropriatly labels the data set with descriptive variables names!
# Makes a vector with all variables' names!
vector_names <- names(all)
# replace "tBody" to "time_body_"
vector_names <- str_replace_all(vector_names, "tBody", "time_body_")
# replace "fBody" to "frequency_body_"
vector_names <- str_replace_all(vector_names, "fBody", "frequency_body_")
# replace "Acc" to "acceleration_"
vector_names <- str_replace_all(vector_names, "Acc", "acceleration_")
# replace "Gyro" to "gyroscope"
vector_names <- str_replace_all(vector_names, "Gyro", "gyroscope_")
# replace "tGravity" to "time_gravity"
vector_names <- str_replace_all(vector_names, "tGravity", "time_gravity_")
# replace "Jerk" to "jerk_rate"
vector_names <- str_replace_all(vector_names, "Jerk", "jerk_rate_")
#replace "Mag" to "magnitude_"
vector_names <- str_replace_all(vector_names, "Mag", "magnitude_")
# replace "Freq" to "frequency"
vector_names <- str_replace_all(vector_names, "Freq", "_frequency")
# replace "Body" to "body_"
vector_names <- str_replace_all(vector_names, "Body", "body_")
# replace "(\\)" to ""
vector_names <- str_replace_all(vector_names, "\\(\\)", "")
# replace "-" to "_"
vector_names <- str_replace_all(vector_names, "-", "_")
# replace "__" to "_"
vector_names <- str_replace_all(vector_names, "__", "_")
# replace the variable names in the data frame "all" with the elements of the
# vector "vector_names"
names(all) <- vector_names
#
# ---------------------------------------------------------
### Step 5
#
# Creates a second, independent tidy data set with the average of each variables
# for each activity and each subject
all <- tbl_df(all)
# uses "gather" from tidyr library to gather the data based in "key" and "value"
all_tidy <- gather(all, key_col, value_col, 3:81)
#
#
# summarizes the data by subject and activity with "Piping-%>%" commands
#
all_tidy <- all_tidy %>% group_by(subject, activity) %>% 
    summarise (mean = mean(value_col))
#
# writes out the data set to file
write.table (all_tidy, file = "all_tidy_data.txt", row.names = FALSE)
write.csv (all_tidy, file = "all_tidy_data.csv", row.names = FALSE)
# ------------------------------------------------------------























