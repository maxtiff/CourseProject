## Source data.table library to efficiently process large data sets and reshape2 library to melt and dcast merged data set.
library(data.table)
library(reshape2)


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
names(featuresNames) <- c("id", "feature")

## Use descriptive activity names to name the activities in the data set.
## Load activity labels data.
activityLabelsFilePath <- file.path(datasetDirPath, "activity_labels.txt")
activityLabels <- read.table(activityLabelsFilePath)
names(activityLabels) <- c("id", "activity")


#### Function loads user-defined raw set and creates a data table from all appropriate files. Either 'test' or 'train', representing 
#### observations drawn from the different experiment groups, can be used in the argument.
dataReader <- function(set) {

  ## Set file path variables for subjects, X (observations) and Y (activity) text files.
  outputPath <- file.path(datasetDirPath,set,paste("X_",set,".txt", sep=""))
  activityPath <- file.path(datasetDirPath,set,paste("Y_",set,".txt", sep=""))
  subjectPath <- file.path(datasetDirPath,set,paste("subject_",set,".txt",sep=""))
  
  ## Read in data from path variables.
  outputData <- read.table(outputPath)
  activityData <- read.table(activityPath)
  subjectData <- read.table(subjectPath)
  
  ## Appropriately labels the data set with descriptive activity names.
  outputData <- cbind(outputData,factor(activityData[[1]],levels=activityLabels$id,labels=activityLabels$activity))

  ## Add subject ids to outputData data frame.
  outputData <-cbind(outputData,factor(subjectData[[1]]))
  
  ## Add header information to data set.
  names(outputData) <- c(as.character(featuresNames$feature),"activity", "subject")
  
  ## Extracts only the measurements on the mean and standard deviation for each measurement.
  outputData <- outputData[grep(pattern="(mean\\(\\)|std\\(\\))|^(activity|subject)$",names(outputData),ignore.case=T)]
  
  return(outputData)
  
}


## Create two data sets with 'test' and 'train' data. 
testData <- dataReader("test")
trainData <- dataReader("train")

## Merge the training and the test sets to create one data set.
mergedData <- rbind(trainData, testData)

## Melt data to long & tall form.
meltedData <- melt(mergedData,id=c("subject","activity"))

## Create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- dcast(meltedData,subject+activity~variable,mean)

## Save tidy data table to file.
write.table(tidyData,"tidy_data.txt")