# Getting & Cleaning Data Project

This file contains information about the course project for the above mentioned course.

## Course Project

The R script called run_analysis.R does the following: 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive variable names. 
* Creates an independent tidy data set with the average of each variable for each activity and each subject.

The dataset needed to run this code is automatically downloaded from the website
when you run the run_analysis.R file

## Execution of the code
1. Save the run_analysis.R file in your local computer.
2. Set the directory in which the code is saved as your working directory using setwd() in RStudio.
3. Use source(run_analysis.R) in the command console.
4. On flawless execution of the code, "UCI HAR Dataset" folder is created.
5. The folder contains the dataset used for the analysis.
6. The code generates a new Tidy_data.txt file in the working directory.

## Dependencies
* The base and plyr packages (along with their dependencies) are required. 