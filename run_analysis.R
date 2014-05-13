## Source data.table library to efficiently process large data sets 
library(data.table)

## Setting up data variables for download.
dataDirPath <- "data"
datasetDirPath <- file.path(dataDirPath, "UCI HAR Dataset")
zipFilename <- "UCI HAR Dataset.zip"
zipPath <- file.path(dataDirPath, zipFilename)
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Downloading/Unzipping data iff files do not previously exist.
if(!file.exists(dataDirPath)) { 
  dir.create(dataDirPath) 
}

if(!file.exists(zipPath)) {
  download.file(zipUrl, zipPath, mode="wb") 
}

if(!file.exists(datasetDirPath)) {
  unzip(zipPath, exdir=dataDirPath)
}

print(datasetDirPath)

#### Function to load and manage data files.

#### Proceed to assignment requirements.

# 1. Merges the training and the test sets to create one data set.

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# 3. Uses descriptive activity names to name the activities in the data set.

# 4. Appropriately labels the data set with descriptive activity names.

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


