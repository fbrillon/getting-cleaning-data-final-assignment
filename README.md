# getting-cleaning-data-final-assignment
## By Francois Brillon

This repository contains 
* This README.md file
* A CodeBook.md file - containing details about the analysis and data sets used in this assignment
* A single R script "runAnalysis.R"

The script runAnalysis.R contains 3 functions
* assignment - which is a simple wrapper of the 2 other functions. It does perform all tasks for this assignment
* runAnalysis - which extract data from the source, merge the test and train sets, then generate a first tidy data set (tasks 1 to 4)
* tidyset - which generate a 2nd data set grouped by subject and activity (task 5)
