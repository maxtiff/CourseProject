## Source data.table library to efficiently process large data sets 
library(data.table)

#### Function organizes all files and then merges the test and train data sets together. Necessary files
merge <- function(mainDir, testDir, trainDir) {
  #Place
  
}


#### Function downloads dataset. Data will not be downloaded if it previously exists.
download <- function(url, dataFilename, zipFilename) {
  dataDirPath <- "data"
  datasetDirPath <- file.path(dataDirPath, dataFilename)
  zipPath <- file.path(dataDirPath, zipFilename)
  
  ## Downloading/Unzipping data
  if(!file.exists(dataDirPath)){ 
    dir.create(dataDirPath) 
  }
  
  if(!file.exists(zipPath)){ 
    download.file(url, zipPath, mode="wb")
  }
  
  if(!file.exists(datasetDirPath)) { 
    unzip(zipPath, exdir=dataDirPath)
  }
  
  return(datasetDirPath)
  
}

## Setting up variables that are used as parameters in the download function.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFilename <- "UCI HAR Dataset"
zipFilename <- "UCI HAR Dataset.zip"

## Download file and return dir that contains the data.
mainDir <- download(url, dataFilename, zipFilename)

scan

list.dirs()


