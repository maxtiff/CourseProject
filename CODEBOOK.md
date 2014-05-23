Codebook for *Getting and Cleaning Data: Human Activity Recognition*
=============

This is the codebook for the run_analysis.R script that explains how the data from the Human Activity Recognition page is cleaned and processed for effective data analysis.

#### Steps of run_analysis.R script.

1. After sourcing the requisite "data.table" and "reshape" libraries, the script first declares the variables necessary to download and store the data files. The script creates variables for the folder in which the zip file is downloaded (*dataDirPath*); the OS neutral path in which the script extracts the zip file contents to (*zipPath*); the name of the zip file (*zipFilename*), which is used in the *download.file()* function; a OS neutral path for where the zip file will reside (*zipPath*); and finally the source url for the zip file (*zipUrl*). 
```{r}
dataDirPath <- "data"
datasetDirPath <- file.path(dataDirPath, "UCI HAR Dataset")
zipFilename <- "UCI HAR Dataset.zip"
zipPath <- file.path(dataDirPath, zipFilename)
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```

2. The script will create a destination folder if and only if one does not yet exist. The script will also then attempt to download and then extract the activity data contents of the zip file, if and only if the zip file does not previously exist. 
```{r}
if(!file.exists(dataDirPath)) { 
  dir.create(dataDirPath) 
}

if(!file.exists(zipPath)) {
  download.file(zipUrl, zipPath, mode="wb") 
}

if(!file.exists(datasetDirPath)) {
  unzip(zipPath, exdir=dataDirPath)
}
```
The extraction process establishes two sub-directories that delineates the output data into seperate training and test groups. These sub-directories are used in the dataReader function below. Extensive notes on the structure of the of the contents of the "data/UCI HAR dataset" folder are contained within *README.txt*. 


3. The script proceeds to load and manage the feature variables file with the "data.table" package. The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
```{r}
featuresFilePath <- file.path(datasetDirPath, "features.txt")
featuresNames <- read.table(featuresFilePath)
names(featuresNames) <- c("id", "feature")
```

4. Next, it processes the activity labels file in order to name the activities in the dataset. The data is stored in a table called "activityLabels."
```{r}
activityLabelsFilePath <- file.path(datasetDirPath, "activity_labels.txt")
activityLabels <- read.table(activityLabelsFilePath)
names(activityLabels) <- c("id", "activity")
```

5. The script defines a dataReader() function in order to handle the train and test data subsets, and corresponding metadata, from their respective directories. First, the script reads in the output data, the activity data, and the subject data. Then it binds the output data with its subject, and the activity labels that correspond to the numbered activity that was performed by the subject. The features list is added as a header. From there, the script uses a regular expression to isolate only the measurements that look at the mean and standard deviation of each activity.The script finally outputs the tidied data set as *outputData*.
```{r}
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
  
  ## Extracts only the mean and standard deviation for each measurement.
  outputData <- outputData[grep(pattern="(mean\\(\\)|std\\(\\))|^(activity|subject)$",names(outputData),ignore.case=T)]
  
  return(outputData)
  
}
```

6. The script uses the output from the previously defined dataReader() function to create a 'test' and 'train' data set ...
```{r}
testData <- dataReader("test")
trainData <- dataReader("train")
```
7. ...which the script then combines:
```{r}
mergedData <- rbind(trainData, testData)
```

8. To create a second, independent tidy data set with the average of each variable for each activity and each subject the script melts the data to long & tall form. Then, using dcast, the script finds the average of each variable for each activity and each subject.
```{r}
meltedData <- melt(mergedData,id=c("subject","activity"))

tidyData <- dcast(meltedData,subject+activity~variable,mean)
```

9. Finally, the second tidy data set is saved as a "tidy_data.txt" in the main directory.
```{r}
write.table(tidyData,"tidy_data.txt")
```

