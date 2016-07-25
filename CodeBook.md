# Code Book - Getting and Cleaning Data
* By Francois Brillon

# Initial Data used for this project 
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Goal of the analysis
* The initial data contains several files spread into 2 groups, "test" and "train". The goal of this assignment was to merged those files into a single tidy dataset, easier to manipulate and analyze.

# Methodology
* Download and unzip original data set
* Read activities and features description data sets
  * Each activity and feature has a numeric ID and a name
* Read X_test.txt data set, which contains all observations and measurements
* Use the features descriptions to label columns in X_test data set
* Read subject_test.txt data set which contains the id of the subject who performed each action, corresponding to an observation
* Read Y_test.txt data set, which contains the identifier of the activity corresponding to each observation
* Merge the subject and activities data set into X_test data set 
* Keep only the mean and standard deviation (std) of each measurements, along with the subject and activity label.
* And conver the subject and activity columns into factors

# Data
## Factors
* subject : identifier of the subject who performed the activity
* activity_name : name of the activity performed

## Measurements 
* There are 2 groups of measurements
  * mean = mean
  * std = standard deviation
* The measurements are as follows
* '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
  * tBodyAcc-XYZ
  * tGravityAcc-XYZ
  * tBodyAccJerk-XYZ
  * tBodyGyro-XYZ
  * tBodyGyroJerk-XYZ
  * tBodyAccMag
  * tGravityAccMag
  * tBodyAccJerkMag
  * tBodyGyroMag
  * tBodyGyroJerkMag
  * fBodyAcc-XYZ
  * fBodyAccJerk-XYZ
  * fBodyGyro-XYZ
  * fBodyAccMag
  * fBodyAccJerkMag
  * fBodyGyroMag
  * fBodyGyroJerkMag
