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

## Load features label data. 
featuresFilePath <- file.path(datasetDirPath, "features.txt")
featuresNames <- read.table(featuresFilePath)
names(featuresNames) <- c('featureid', 'featurename')

## Use descriptive activity names to name the activities in the data set.
## Load activity labels data.
activityLabelsFilePath <- file.path(datasetDirPath, "activity_labels.txt")
activityLabels <- read.table(activityLabelsFilePath)
names(activityLabels) <- c('activityid', 'activityname')


#### Function loads user-defined raw set. Either 'test' or 'train' data set.
dataSetLoader <- function(set) {
  
  ## Set file path variables for subjects, X (observations) and Y (activity) text files.
  outputPath <- file.path(datasetDirPath,set,paste("X_",set,".txt", sep=""))
  activityPath <- file.path(datasetDirPath,set,paste("Y_",set,".txt", sep=""))
  subjectPath <- file.path(datasetDirPath,set,paste("subject_",set,".txt",sep=""))
  
  ## Read in data from path variables.
  outputData <- read.table(outputPath)
  activityData <- read.table(activityPath)
  subjectData <- read.table(subjectPath)
  
  ## Appropriately labels the data set with descriptive activity names.
  ## Use factor() to map activity ids to labels
  outputData <- cbind(outputData,factor(activityData[[1]],levels=activityLabels$activityid,labels=activityLabels$activityname))

  ## Add subject ids to outputData data frame
  outputData <-cbind(outputData,factor(subjectData[[1]]))
  
  names(outputData) <- c(as.character(featuresNames$featurename),"activity", "subject")
  
  return(outputData)
}

testData <- dataSetLoader('test')
trainData <- dataSetLoader('train')


## Merge the training and the test sets to create one data set.
mergedData <- rbind(trainData, testData)

## Extracts only the measurements on the mean and standard deviation for each measurement.


## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


