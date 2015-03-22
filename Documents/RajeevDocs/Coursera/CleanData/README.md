
README.rmd
---------------------

This file describes the script for cleaning and tidy’ing data (run_analysis.R)

- Download and unzip the datasets from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- Unzipped data folder and the script (run_analysis.R) should be in the same directory
- Run the script sunning RStudio -> source(“run_analysis.R)
- This script will generate two datasets - Cleaned data and tidy data
- You can check the dataset using the read.table command

```
outClean <- read.table("merged_clean_data.txt")
head(outClean)
outTidy <- read.table("clean_data_with_means.txt")
head(outTidy)
```

