

# If required packages are not present install

if("dplyr" %in% rownames(installed.packages()) == FALSE){
  install.packages("dplyr")
}

if("tidyr" %in% rownames(installed.packages()) == FALSE){
  install.packages("tidyr")
}

library(dplyr)
library(tidyr)

#Download dataset if required to current working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset")) {
  download.file(fileUrl, destfile="UCI_HAR_Dataset.ZIP")
  unzip("UCI_HAR_Dataset.ZIP", exdir=".")
}


#Merge test and training data

#Get test data
testX <- read.table("UCI HAR Dataset/test/X_test.txt",head = FALSE)
testY <- read.table("UCI HAR Dataset/test/Y_test.txt", head = FALSE, col.names = c("Activity"))
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt", head = FALSE, col.names = ("Subject"))

testDataSet <- cbind(testX,testY,sub_test)

#Get train data
trainX <- read.table("UCI HAR Dataset/train/X_train.txt", head = FALSE)
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt", head = FALSE, col.names = c("Activity"))
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt", head = FALSE, col.names = c("Subject"))


trainDataSet <- cbind(trainX,trainY,sub_train)

##Merge test an train
MergedDataSet <- rbind(testDataSet,trainDataSet)

#descriptive activity names to name the activities in the data set

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, col.names = c("AID","ActivityName"))

LabledActivityData <- merge(MergedDataSet,activityLabels,by.x = "Activity", by.y = "AID", sort = FALSE)
LabledActivityData <- LabledActivityData[- c(1)]

#get column names
columnNamesDf <- read.table("UCI HAR Dataset/features.txt", head=FALSE)

columnNames <- c(as.vector(columnNamesDf[['V2']]),"Subject","Activity")

filteredColumnsIds <- grep("mean|std|Activity|Subject",columnNames)

FilteredData <- LabledActivityData[filteredColumnsIds]


#use descriptive names
columnNames <- gsub("^t(.*)$", "\\1-time", columnNames)
columnNames <- gsub("Mag", "-Magnitude", columnNames)
columnNames <- gsub("Acc", "-Acceleration", columnNames)
columnNames <- gsub("^f(.*)$", "\\1-Frequency", columnNames)
columnNames <- gsub("(Jerk|Gyro)", "-\\1", columnNames)

names(FilteredData) <- columnNames[filteredColumnsIds]


#Generate tidy data
tidyData <- tbl_df(FilteredData)
tidyData <- group_by(tidyData, Subject, Activity)
tidyData <- summarise_each(tidyData,funs(mean))
tidyData <- gather(tidyData, Measurement,mean,-Activity,-Subject)

# Write tidy data table to file
write.table(tidyData, file="tidy_data.txt", row.name=FALSE)

