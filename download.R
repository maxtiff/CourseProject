download <- function(url, destination) {
  
  ## Check if dir for data exists. Create dir if not.
  if (!file.exists("data")) {
    dir <- "./data"
    dir.create("data")
    
    ## Download file
    fileUrl <- url
    download.file(fileUrl,destination)
    
    ## Unzip file
    unzip(destination, exdir="./data")
  }

}