library(data.table)

####  Function that downloads file from specified url and unzips into a destination directory.
####  Function will not run if a directory exists.

# download <- function(url, destination) {
#   
#   ## Check if dir for data exists. Create dir if not.
#   if (!file.exists("data.zip")) {
#     dir <- "./data"
#     dir.create("data")
#     
#     ## Download file
#     fileUrl <- url
#     download.file(fileUrl,destination)
#     
#     ## Unzip file
#     unzip(destination, exdir="./data")
#   }
#   
# }

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
}

# download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","data.zip")