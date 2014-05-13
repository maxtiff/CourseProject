## Source data.table library to efficiently process large data sets 
library(data.table)

#### Function organizes all files and then merges the test and train data sets together. Necessary files
merge <- function(mainDir, testDir, trainDir) {
  
}

## Setting up data variables
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDirPath <- "data"
datasetDirPath <- file.path(dataDirPath, "UCI HAR Dataset")
zipFilename <- "UCI HAR Dataset.zip"
zipPath <- file.path(dataDirPath, zipFilename)


## Downloading/Unzipping data
if(!file.exists(dataDirPath)){ 
  dir.create(dataDirPath) 
}

if(!file.exists(zipPath)){ 
  download.file(fileUrl, zipPath, mode="wb")
}

if(!file.exists(datasetDirPath)) { 
  unzip(zipPath, exdir=dataDirPath)
  unlink(zipPath)
}



