Codebook for *Getting and Cleaning Data: Human Activity Recognition*
=============

This is the codebook for the run_analysis.R script that explains how the data from the Human Activity Recognition page is cleaned and processed for effective data analysis.

#### Steps of run_analysis.R script.

1. After sourcing the requisite "data.table" and "reshape" libraries, the script first declares the variables necessary to download and store the data files. The script creates variables for the folder in which the zip file is downloaded; the OS neutral path in which the script extracts the zip file contents to; the name of the zip file, which is used in the *download.file()* function; a OS neutral path for where the zip file will reside; and finally the source url for the zip file. 
```{r}
dataDirPath <- "data"
datasetDirPath <- file.path(dataDirPath, "UCI HAR Dataset")
zipFilename <- "UCI HAR Dataset.zip"
zipPath <- file.path(dataDirPath, zipFilename)
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```

2. The script will then attempt to download and then extract the activity data contents of the zip file, if and only if the zip file does not previously exist. The script will also create a destination folder if and only if one does not yet exist.
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

You can also embed plots, for example:

```{r fig.width=7, fig.height=6}
plot(cars)
```

