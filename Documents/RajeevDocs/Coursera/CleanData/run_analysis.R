# Script Name: run_analysis.R
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity Labels names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

# Project: Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms 
# to attract new users. The data linked to from the course website represent data collected from the 
# accelerometers from the Samsung Galaxy S smartphone. 
# A full description is available at the site where the data was obtained: 
#     http://archive.ics.uci.edu/ml/datasets/Human+actLabels+Recognition+Using+Smartphones 
# Data for the project: 
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## set working directory
## setwd("/Users/rguliani/Documents/RajeevDocs/Coursera/CleanData")

## Step #1: read actLabels labels and format columns
actLabels <- read.table("./data/activity_labels.txt", sep = "" , header = FALSE )
actLabels[, 2] <- tolower(gsub("_", "", actLabels[, 2])) 
substr(actLabels[2, 2], 8, 8) <- toupper(substr(actLabels[2, 2], 8, 8)) 
substr(actLabels[3, 2], 8, 8) <- toupper(substr(actLabels[3, 2], 8, 8)) 


## Step #2: read features and format data
features <- read.table("./data/features.txt", sep = "" , header = FALSE )
mean_and_std_list <- grep("-(mean|std)\\(\\)", features[, 2])

# Step #3: Read train dataset (labels, subject and data)
trainData <- read.table("./data/train/X_train.txt", sep="", header=FALSE)
trainLabels = read.table("./data/train/Y_train.txt", sep="", header=FALSE)
trainSub = read.table("./data/train/subject_train.txt", sep="", header=FALSE)

# Step #4 :read test dataset ((labels, subject and data))
testData = read.table("./data/test/X_test.txt", sep="", header=FALSE)
testLabels = read.table("./data/test/Y_test.txt", sep="", header=FALSE)
testSub = read.table("./data/test/subject_test.txt", sep="", header=FALSE)

# Step #5: merge train and test data sets (Sub, Activity and Data)
allData = rbind(trainData, testData)
allLabels = rbind(testLabels, trainLabels)
allSub = rbind(trainSub, testSub)

# Step #6: Get subset of the columns and create merged data sets
# Change case and remove characters for matching (-,())
allData <- allData[, mean_and_std_list]
names(allData) <- gsub("\\(\\)", "", features[mean_and_std_list, 2]) 
names(allData) <- gsub("mean", "Mean", names(allData)) 
names(allData) <- gsub("std", "Std", names(allData))
names(allData) <- gsub("-", "", names(allData)) 

# assign column names and clean data
actAll <- actLabels[allLabels[, 1], 2] 
allLabels[, 1] <- actAll
names(allLabels) <- "activity"
names(allSub) <- "subject"
# merge all train and test datasets (activity, subject and data)
mergedData <- cbind(allSub, allLabels, allData) 
dim(mergedData) 

# output clean data set to a file
write.table(mergedData, "merged_clean_data.txt") 

# Step #7: Create tidy data set with each combination of activity and subject
subLen <- length(table(allSub))
actLen <- dim(actLabels)[1] 
dataLen <- dim(mergedData)[2] 
resultSet <- matrix(NA, nrow=subLen*actLen, ncol=dataLen) 
resultSet <- as.data.frame(resultSet) 
colnames(resultSet) <- colnames(mergedData) 

# Loop through comination of subject and activity to create tidy data set
rownum <- 1
for(subCount in 1:subLen) { 
  for(actCount in 1:actLen) { 
    resultSet[rownum, 1] <- sort(unique(allSub)[, 1])[subCount] 
    resultSet[rownum, 2] <- actLabels[actCount, 2] 
    check_sub <- subCount == mergedData$subject
    check_act <- actLabels[actCount, 2] == mergedData$activity
    resultSet[rownum, 3:dataLen] <- colMeans(mergedData[check_sub&check_act, 3:dataLen]) 
    rownum <- rownum + 1
  } 
} 
head(resultSet) 

# Step #8: Write to output file (tidy dataset)
write.table(resultSet, "clean_data_with_means.txt") 
