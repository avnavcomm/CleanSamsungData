# CleanSamsungData: run_analysis.R

## Summary

The script "run_analysis.R" is used for cleaning the raw data from Samsung's "Human
Activity Recognition Using Smartphones Dataset Version 1.0". Data were obtained
via 
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Unzipping the .zip file will produce a directory called "UCI HAR Dataset",
which is referred to here as DATA_ROOT.  The script "run_analysis.R" is not
included, and must be downloaded directly from the CleanSamsungData
github respository. run_analysis.R needs to be executed in the
DATA_ROOT directory for the script to find the dataset files without modifying the script. 
To ensure you are in DATA_ROOT, you should see the following files (along with run_analysis.R):
* README.txt -- original readme file with full description of data collection
* activity_labels.txt
* features.txt
* features_info.txt
* test -- test dataset directory 
* train -- training dataset directory

Data were collected using the Samsung Galaxy S II smartphones from 30 volunteers
(subjects).  The subjects were all asked to perform six different actions while wearing the smartphone:
* Walking
* Walking upstairs
* Walking downstairs
* Sitting
* Standing
* Laying
The accelerometer and gyroscope on the phone gave three-axis motion information. The datasets contain 
multiple measurements for each subject for each activity. The main datasets contain 561 columns for
the measurement variables given in the "features.txt" file available in the .zip file. The rows of 
the measurement sets are not ordered in the raw data.


## Script actions and results

The script "run_analysis.R" takes the raw data and converts it into a cleaned (tidy) dataset,
selecting 68 out of the 561 measurement variables and reducing the row size from over 10 000 to 
180.  This is done as follows:
* The training and test datasets are merged (the raw data has these datasets separated into two datasets).
* Measurements of the mean and standard deviation variables are selected from the table.  
  * These are denoted by mean() and std(), respectively, in the name of the variable in the features.txt file of the raw data. 
* The columns of the dataset are named according to their feature name (with minor changes for readability). 
* The measurements corresponding to a given subject for a given action are averaged and sorted by subject and then action.
  * This gives a long-form tidy dataset, where for each action, the averaged mean and std measurements for the subjects 1-30 are listed. 
* The script then writes out the table to a file.  **Unless changed by the user, the cleaned dataset text file is "UCI_HAR_Dataset_Cleaned.txt".** 

The accompanying CodeBook.md (on the CleanSamsungData repository), gives the column names and units. 

A long-form format, with the activities stacked, is chosen over a wide-form, for the simplicity in the naming of the columns.
The long-form format allows quick selection of activies after the table is read into R, e.g.,
> cleanData <- read.table("data<-read.table("UCI_HAR_Dataset_Cleaned.txt",stringsAsFactors = FALSE,header=TRUE)

The activies retain their names from the raw data: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING


## Script dependencies

Must have "reshape2" and "plyr" packages installed. 

## Running the script

* Enter the R environment.
> R
* Ensure your working directory is DATA_ROOT. 
* Source the file (in the R environment) using
> source("run_analysis.R")
* Then run the script (in R)  using
> run_analysis()

* Note: the plyr::join_all function can produce output to screen, describing how data frames
are being joined by the script.  This is OK and normal. 

