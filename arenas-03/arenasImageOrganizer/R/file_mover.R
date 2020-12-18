#!/bin/env R

## File Mover. 
## Original script by Oliver Tam tam@cshl.edu, June 2020

## The `file_mover()` function will create subfolders according
## to the convention outlined by the Arenas lab, and move the files
## within.
##
## NOTE: please ensure that the files were checked by the `name_checker()`
##       function before trying to move them.

######## Expected Nomenclature ########
##
## Eight (8) sections separated by underscores ("_")
##
## The first three sections will indicate the folder that it should be
## moved to.
##
## Section 1: Experimental name and researcher initials
##       e.g. NES-SAI2d15-CS
## Section 2: Experiment date and experiment number
##       e.g. 200514-01
## Section 3: Condition and replicate number
##       e.g. Vehicle-1
##
##
## Example file name:
##       NES-SAI2d15-CS_200514-01_Vehicle-1_200517_DAPI+goPitx3-dk488+rbAldh1-dk555+moTh-dk647_CF_10Xz1-1.tiff
##
## Folders to be created:
##       NES-SAI2d15-CS/200514-01/Vehicle-1
##
## File name after being moved:
##       200517_DAPI+goPitx3-dk488+rbAldh1-dk555+moTh-dk647_CF_10Xz1-1.tiff
##
########################################

#' Moving files to subfolder based on file name
#' This function will parse the file name, create appropriate subfolders,
#' and move the files into those subfolders (trimming the file name accordingly)
#'
#' @param folder Folder containing the files to be moved
#' @param dest_root The root folder where subfolders are to be made from. Default: folder containing the files
#' @param anonymize Anonymize the files after moving (default = FALSE)
#' @return A log of the files moved
#' @export
#' 

file_mover <- function(folder, dest_root=folder, anonymize=FALSE){ 
    
    ## Check that the folder exists
    if(! dir.exists(folder)){
        log = paste0(c(paste("This folder", folder, "does not exist."),"Please double-check"))
        return(log)
    }
    
    ## Identify files to be moved ----
    ## Only look for TIFF files or Zeiss microscope output (*.czi or *.lsm)
    files <- setdiff(list.files(folder, pattern="\\.czi$|\\.tif$|\\.tiff$|\\.lsm$",full.names = TRUE), list.dirs(recursive = FALSE))
    if(length(files) < 1){
        log = c(paste("No suitable files identified in",folder))
        return(log)
    }

    ## Set up log file ----
    today <- Sys.time()
    log = c(paste0("Files were moved on ", 
            format(today,format="%d %B, %Y"), " at ", 
            format(today, format="%I:%M %p"), "."),"")
    destList <- vector()
    
    ## Iterate through each file found and extract the information ----
    for(i in 1:length(files)){   # i = 1
        current_file = basename(files[i])
        file_info <- unlist(strsplit(current_file, "_",fixed=TRUE))
        if(length(file_info) != 8){
            stop("The file name does not fit the expected nomenclature. Not progressing further.")
        }

        ## According to nomenclature, the first three sections is the subdirectory structure, and the rest is the actual file name
        subdir <- do.call('file.path',as.list(file_info[1:3]))
        newfile <- paste(file_info[4:length(file_info)],collapse="_")

        ## Move the file, store the destination with a new file and make notes in log
        destination  <- file.path(dest_root,subdir)
        if(! dir.exists(destination)){
            dir.create(destination,recursive=TRUE)
        }
        
#        file.move(files[i],file.path(destination,newfile))
        file.copy(files[i],file.path(destination,newfile))

        destList <- c(destList,destination)
        log <- c(log,paste(current_file,"moved to",subdir))
        
    }

    ## Run file_anonymizer if requested
    if(anonymize){
        log = c(log,"")
        destList = unique(destList)
        for(i in 1:length(destList)){
            anonlog <- file_anonymizer(destList[i])
            log <- c(log,anonlog)
        }
    }
    
    ## Return the log output after processing multiple files ----
    return(log)
}
