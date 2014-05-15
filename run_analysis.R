## Source data.table library to efficiently process large data sets 
library(data.table)


## Set up path variables for file download.
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


####Load and manage features and activity data files.

## load features label data. 
featuresFilePath <- file.path(datasetDirPath, "features.txt")
featuresNamesFile <- read.table(featuresFilePath)
names(featuresNamesFile) <- c('feature id', 'feature name')

## load activity labels data.
activityLabelsFilePath <- file.path(datasetDirPath, "activity_labels.txt")
activityFile <- read.table(activityLabelsFilePath)
names(activityFile) <- c('activity id', 'activity name')


#### Function loads user-defined raw set. Either 'test' or 'train' data set.
dataSetLoader <- function(set) {
  
  ## Set file path variables for subjects, X (observations) and Y (activity) text files.
  outputPath <- file.path(datasetDirPath,set,paste("X_",set,".txt", sep=""))
  activityPath <- file.path(datasetDirPath,set,paste("Y_",set,".txt", sep=""))
  subjectPath <- file.path(datasetDirPath,set,paste("subject_",set,".txt",sep=""))
  
  ## Read in data from path variables.
  outputData <- read.table(outputPath)
  activityData <- read.table(activityPath)
  subjectPath <- read.table(subjectPath)
  
  
  
  
}

print(dataSetLoader('test'))

#### Proceed to assignment requirements.

## Merges the training and the test sets to create one data set.


## Extracts only the measurements on the mean and standard deviation for each measurement.


## Use descriptive activity names to name the activities in the data set.
## Load activity labels data.
activityLabelsFilePath <- file.path(datasetDirPath, "activity_labels.txt")
activityFile <- read.table(activityLabelsFilePath)
names(activityFile) <- c('activity id', 'activity name')

## Appropriately labels the data set with descriptive activity names.
activityData <- cbind(activityData,activityFile)

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


