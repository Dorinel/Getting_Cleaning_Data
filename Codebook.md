---
title: "Codebook"
author: "D. Verdes"
date: "Sunday, March 22, 2015"
output: word_document
---
# Project Description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Study design
### This info is taken from the "readme" and "feature info" files attached to the raw data files!
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

### Description how the raw data is pre-processed

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The raw data contains the following features recorded in separate files:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### The units of the raw data sets:
The feature are normalized and bounded within [-1,1]

# Creating the tidy file

A longer description of how the data is loaded, read and processed to creat a tidy data (data.frame) or file is given in the uploaded ReadMe file.

Here just a short description is presented!

- The "train" (70% of volunteers) data set and "test" (30% of volunteers) data set are loaded in XX_train and XX_test, respectively. They contain the measured and pre_processed features. 
- The activities performed are loaded in YY_train and YY_test, respectively. The activity is coded in numbers and the assignment is given in activity_labels.
- The activity_labels data frame containg the given activities
- the name of the variables is loaded in the "features" data frame.

To create a tidy data file the following steps are performed:

Step 1:

- Reads "X_train.txt" in "XX_train" data frame
- Reads "Y_train.txt" in "YY_train" data frame
- Reads "X_test.txt" in "XX_test" data frame
- Reads "Y_test.txt" in "YY_test" data frame
- Reads "features.txt" in "features" data frame
- Reads "subject_train.txt" in "subj_train" data frame
- Reads "subject_test.txt" in "subj_test" data frame
- Performs a "column bind" for "XX_train", "YY_train" and "subj_train" to obtain "training_set" data frame
- Performs a "column bind" for "XX_test", "YY_test" and "subj_test" to obtain "testing_set" data frame
- Merges the "training_set" with "testing_set" to obtain a full set of data in "all_combined" data frame

Step 2:

- Extracts only the measurements on the mean and standard deviation for each measurements. This data are contained in a data frame called "all"

# Description of the variables in "all" tidy data set: Size (10299-observations) X (81 variables)

- first variable "subject" (class: integer) contains the number of the subjects in the experiment (30)
- second variable "activity" (class: factor) contains the type of activity performed: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

### the remaining variables (3:81),(class: numeric) have more combined names depending of the type of measurements:
#### every word used to describe the variables names is described below: 
####the variables names start with "time_" or "frequency_" to denote whether the signals are measured in time domain   or "suffered" a Fourier tranformation to "frequency" domain


- the "XYZ" denotes the 3-axial signals measured in the X,Y and Z directions
- the "time_" shows the features measured in time (constant rate of 50Hz); so called time domain signals (40 variables in the data set)
- the "frequency_" shows the features tranformed in frequency domain by "fast fourier transformation", (30 variables in the data set)
- the "mean_" stands for the Mean value
- the "std_" stands for the Standard Deviation
- the "acceleration_" stands for the data coming from the accelerometer
- the data from accelerometer are separated in "body_acceleration_" and "gravity_acceleration_"
- Example: "time_body_acceleration_mean_X" or "time_gravity_acceleration_std_X"

- the "gyroscope_" stands for data coming from the gyroscope
- the data from gyroscope are separated in "body_gyroscope_" and "body_body_gyroscope"
- the "jerk_rate-" stands for the rate of change for acceleration linear and angular
- the "acceleration_jerk_rate_" stands for the body linear acceleration changes in time
- the "gyroscope_jerk_rate_" stands for the angular velocity changes in time
- the "magnitude_" stands for the signal calculated using "the Euclidian norm" as described in the "feature info"

Source: the name's descriptions above for the variables in the tidy data set are inspired from the description provided with the raw data sets: features_info.txt and Readme.txt

ReadMe: the full description of the source code "run_analysis.R" to obtain the tidy data is presented in the ReadMe file attached to this codebook.












