#!/bin/env R

## Batch Rename Files. 

## This function will rename all files within the working directory folder. 
## It currently handles up to 999 files.

batch_rename_files <- function(microscope, antibody, picture_date, lens_magnification){
  
  ## Checks to make sure parameters are entered ----
  if(missing(microscope)){
    message("Usage: rename_files(microscope, antibody, picture_date, lens_magnification)")
    stop(paste("Microscope not provided"), call. = FALSE)
  }
  if(missing(antibody)){
    message("Usage: rename_files(microscope, antibody, picture_date, lens_magnification)")
    stop(paste("Antibody not provided"), call. = FALSE)
  }
  if(missing(picture_date)){
    message("Usage: rename_files(microscope, antibody, picture_date, lens_magnification)")
    stop(paste("Picture date not provided"), call. = FALSE)
  }
  if(missing(lens_magnification)){
    message("Usage: rename_files(microscope, antibody, picture_date, lens_magnification)")
    stop(paste("Lens magnification not provided"), call. = FALSE)
  }
  
  ## User input required to confirm parameters ----
  confirmParameter <- function(param_name, parameter){
    cat("\nValue provided for ", param_name, ": ", parameter, "\n", sep="")
    answer <- readline(prompt = "Is this correct? (y/n): ")
    if(answer != "y" & answer != "Y"){
      stop(paste("Wrong", param_name, "provided"), call. = FALSE)
    }
  }
  
  confirmParameter("microscope", microscope)
  confirmParameter("antibody", antibody)
  confirmParameter("picture date", picture_date)
  confirmParameter("lens magnification", lens_magnification)
  log <- c("Parameters provided:", "", 
           paste("- Microscope:", microscope),
           paste("- Antibody:",antibody), 
           paste("- Picture date:", picture_date),
           paste("- Lens magnification:", lens_magnification),
           "Please note that any illegal characters or white spaces will be removed from file names", "")
  
  ## Clean up illegal characters ----
  ## adapted from `path_sanitize()` from `fs` package https://fs.r-lib.org
  sanitize <- function(file_name, replacement = ""){
    illegal <- "[/\\?<>\\:*|\":]"
    control <- "[[:cntrl:]]"
    reserved <- "^[.]+$"
    whitespace <- "[[:space:]]"
    #        windows_reserved <- "^(con|prn|aux|nul|com[0-9]|lpt[0-9])([.].*)?$"
    #        windows_trailing <- "[. ]+$"
    file_name <- gsub(illegal, replacement, file_name)
    file_name <- gsub(control, replacement, file_name)
    file_name <- gsub(reserved, replacement, file_name)
    file_name <- gsub(whitespace, replacement, file_name)
    return(file_name)
  }
  
  ## Create new filename prefix and log information ----
  prefix <- paste(microscope, antibody, picture_date, lens_magnification, sep="_")
  prefix <- sanitize(prefix)
  
  today <- Sys.time()
  log <- c(log, paste0("Files renamed on ", 
                       format(today,format="%d %B, %Y"), " at ", 
                       format(today, format="%I:%M %p"), ":"))
  
  ## Identify files to rename ----
  files <- setdiff(list.files(".", full.names = TRUE), list.dirs(recursive = FALSE, full.names = TRUE))
  files <- setdiff(files, "./batch_rename_files.r")
  counter <- sprintf("%03d", 1:length(files))
  dir.create("Converted", showWarnings=FALSE)
  
  for(i in 1:length(files)){   # i = 1
    oldfile <- gsub("./", "", files[i])
    extension <- tools::file_ext(files[i])
    newfile = paste0(prefix, "-", counter[i], ".", extension)
    output <- paste0("Converted/", newfile)
    file.copy(files[i], output)
    log = c(log, paste(oldfile, "renamed to", newfile))
  }
  
  ## Write information in the log file ----
  write(log, file="Converted/renaming_log.txt", sep="\n")
}

