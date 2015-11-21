UCI HAR Dataset Cleaning
=========================

This repo contains the R scripts which generates tidy data set from [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Its course project for "Getting and Cleaning Data" course of Data Science specialization track in Coursera.

## Problem statement

Create a R script that does the following

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## R code

The R code for above problem statement in the [run_analysis.R](run_analysis.R) file.

you can Source this file using following command in R. it will download dataset if required, perform cleaning, tidy the data and save it in the file `tidy_data.txt`.

```R
source("run_analysis.R")
```

The tidy data set can be loaded back into R using the following command

```R
tidy_data <- read.table("tidy_data.txt")
```

## Data CodeBook

The [codebook](CodeBook.MD) available in this repo describes the variables, the data, the transformations that are done and the clean up that was performed on the data.
