
Getting and Cleaning Data Course: Week 3 Project Codebook
----------------------------------------------------------

Instructions for the project are listed here:-
[Project Instructions](https://class.coursera.org/getdata-012/human_grading/view/courses/973499/assessments/3/submissions)

Datasets for this project can be downloaded from here:-
[Datasets](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

- Step 1: Read, clean and format the case (using tolower and toupper functions) for the labels in the activity dataset
- Step 2: Read, clean and identfy (using grep) the mean and standard dev columns in the features dataset
```
features <- read.table("./data/features.txt", sep = "" , header = FALSE )
mean_and_std_list <- grep("-(mean|std)\\(\\)", features[, 2])
```

- Step 3: Read the train data, labels and subject from respective files from the train sub-folder.
- Step 4: Read the test data, labels and subject from respective files from the test sub-folder.
- Step 5: Merge subject, labels and and data from training and test data (step #3 and step #4) using rbind. At this point we will have three merged datasets (subject, label and data)
```
allData = rbind(trainData, testData)
allLabels = rbind(testLabels, trainLabels)
allSub = rbind(trainSub, testSub)
```

- Step 6: Get subset of the columns and create merged data sets. Change case and remove characters for matching (-,()). We will also assign column names in this step. Output of this clean data will be saved in the current folder (filename: merged_clean_data.txt)

- Step 7: This step creates the tidy dataset. It loops through subject and activity and assigns value from the dataset
```
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
```
- Step 8: Write the output of tidy dataset in the current folder (filename: clean_data_with_means.txt)

